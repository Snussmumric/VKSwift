//
//  NewsController.swift
//  VK
//
//  Created by Антон Васильченко on 02.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import RealmSwift

class NewsController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    lazy var service = VKService()
    
    var news: [News] = []
//    let news = NewsModel.fake

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        tableView.register(UINib(nibName: "NewsWallPhotoCell", bundle: nil), forCellReuseIdentifier: "NewsWallPhotoCell")
        service.getData(.news, News.self, shouldCache: false) {
            [weak self] (news: [News]) in
            self?.news = news
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = news[indexPath.row]
        print(item.type)
        switch item.type {
        case "post":
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
            cell.configure(model: news[indexPath.row])
            return cell
        case "wall_photo":
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsWallPhotoCell", for: indexPath) as! NewsWallPhotoCell
            cell.configure(model: news[indexPath.row])
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
            cell.configure(model: news[indexPath.row])
            return cell
            

        }

        
    }
//
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let cell = cell as? NewsPostCell else {return}
//        cell.setCollectionDelegate(self, for: indexPath.row)
//    }


    
    // MARK: - CollectionView
    
    
    enum Constants {
        
        static let maxPhotosCount = 4
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let imagesCount = news[collectionView.tag].images.count
        let imagesCount = 0
        
        return imagesCount > Constants.maxPhotosCount ? Constants.maxPhotosCount : imagesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NewsPhotoCollectionCell
        
//        let newsModel = news[collectionView.tag]
//        let image = news[collectionView.tag].images[indexPath.row]
        let image = UIImage(systemName: "Person")
        cell.photoImageView.image = image
        
//        if indexPath.row == Constants.maxPhotosCount - 1 {
//            let count = newsModel.images.count - Constants.maxPhotosCount
//            cell.countLabel.text = "+\(count)"
//            cell.containerView.isHidden = count == 0
//
//        }
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.bounds.width/2, height: collectionView.bounds.height/2)

    }

    
}
