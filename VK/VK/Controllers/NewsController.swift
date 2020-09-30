//
//  NewsController.swift
//  VK
//
//  Created by Антон Васильченко on 02.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import RealmSwift

class NewsController: UITableViewController {
    
    
    lazy var service = VKService()
    lazy var newsService = VKNewsService()
    
    var news: [NewsItems] = []
    //    var profile: [Profile] = []
    //    let news = NewsModel.fake
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        tableView.register(UINib(nibName: "NewsWallPhotoCell", bundle: nil), forCellReuseIdentifier: "NewsWallPhotoCell")
        
        newsService.get { [weak self] (news: [NewsItems]) in
            self?.news = news
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - dateFormatter
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM HH:mm"
        return formatter
    }()

    var dateTextCache: [IndexPath: String] = [:]

    func getCellDateText(forIndexPath indexPath: IndexPath, andTimestamp timestamp: Double) -> String {
            if let stringDate = dateTextCache[indexPath] {
                return stringDate
            } else {
                let date = Date(timeIntervalSince1970: timestamp)
                let stringDate = dateFormatter.string(from: date)
                dateTextCache[indexPath]  = stringDate
                return stringDate
            }
        }


    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = news[indexPath.row]
        print(item.type)
        switch item.type {
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsWallPhotoCell", for: indexPath) as! NewsWallPhotoCell
            cell.configure(model: news[indexPath.row])
            cell.dateLabel.text = getCellDateText(forIndexPath: indexPath, andTimestamp: news[indexPath.row].date)
            return cell
        case .post:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
            cell.configure(model: news[indexPath.row])
            cell.dateLabel.text = getCellDateText(forIndexPath: indexPath, andTimestamp: news[indexPath.row].date)
            return cell
        }
    }
}


// MARK: - CollectionView
//
//    enum Constants {
//
//        static let maxPhotosCount = 4
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        let imagesCount = news[collectionView.tag].images.count
//        let imagesCount = 0
//
//        return imagesCount > Constants.maxPhotosCount ? Constants.maxPhotosCount : imagesCount
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NewsPhotoCollectionCell
//
//        let image = UIImage(systemName: "Person")
//        cell.photoImageView.image = image
//
////        if indexPath.row == Constants.maxPhotosCount - 1 {
////            let count = newsModel.images.count - Constants.maxPhotosCount
////            cell.countLabel.text = "+\(count)"
////            cell.containerView.isHidden = count == 0
////
////        }
//
//        return cell
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: collectionView.bounds.width/2, height: collectionView.bounds.height/2)
//
//    }
//
//
//}
