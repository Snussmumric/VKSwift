//
//  PhotoService.swift
//  VK
//
//  Created by Антон Васильченко on 24.09.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

final class PhotoService {
    
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    private static let pathName: String = {
        
        let fileManager = FileManager.default
        let pathName = "images"
        
        guard let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !fileManager.fileExists(atPath: url.path) {
            try? fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return pathName
    }()
    
    private func getFilePath(url: String) -> String? {
        let fileManager = FileManager.default
        guard let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(Self.pathName + "/" + hashName).path
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        let fileManager = FileManager.default
        guard let fileName = getFilePath(url: url),
        let data = image.pngData() else { return }
        fileManager.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        print(#function)

        let fileManager = FileManager.default

        guard
            let fileName = getFilePath(url: url),
            let info = try? fileManager.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
            else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else { return nil }

        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }

    
    private var images = [String: UIImage]()
    
    private func loadPhoto(at indexPath: IndexPath, url: String) {
        print(#function)
        AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard
                let data = response.data,
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.images[url] = image
            }
            self?.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self?.container.reloadRow(atIndexpath: indexPath)
            }
            
        }
    }

    func photo(at indexPath: IndexPath, url: String?) -> UIImage? {
        guard let url = url else { return nil }
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(at: indexPath, url: url)
        }
        return image
    }
    
    private let container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
        
}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

extension PhotoService {

    private class Table: DataReloadable {
        let table: UITableView

        init(table: UITableView) {
            self.table = table
        }

        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }

    }

    private class Collection: DataReloadable {
        let collection: UICollectionView

        init(collection: UICollectionView) {
            self.collection = collection
        }

        func reloadRow(atIndexpath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}

