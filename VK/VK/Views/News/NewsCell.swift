//
//  NewsPostCell.swift
//  VK
//
//  Created by Антон Васильченко on 02.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageContainerView: UIView!
    lazy var nextImageView = UIImageView()
    
    lazy var service = VKService()
    var user: [Users] = []
    var group: [Groups] = []
    
    
    let images = (1...Int.random(in: 6...10))
        .map({$0 % 6})
        .shuffled()
        .compactMap({String($0)})
        .compactMap({UIImage(named: $0)})
    
    var currentIndex = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    func configure(item: NewsItems) {
        
//        authorImage.image = UIImage(systemName: "paperplane.fill")
        //        mainImageView.image = model.images.first
//        let date = Date(timeIntervalSince1970: model.date)
//        dateLabel.text = NewsCell.dateFormatter.string(from: date)
        
        
        authorLabel.text = item.profile?.name
        newsText.text = item.text
        likeButton.setTitle(String(item.likeCount), for: .normal)
        commentButton.setTitle(String(item.commentCount), for: .normal)
        viewButton.setTitle(String(item.viewCount), for: .normal)
        repostButton.setTitle(String(item.repostCount), for: .normal)

        
        
        if let imageUrl = item.profile?.imageURL, let url = URL(string: imageUrl) {
            let resource = ImageResource(downloadURL: url)
            authorImage?.kf.setImage(with: resource)
        }
    }
    
//    func setCollectionDelegate (_ delegate: UICollectionViewDataSource & UICollectionViewDelegate, for row: Int) {
//        collectionView.dataSource = delegate
//        collectionView.delegate = delegate
//        collectionView.tag = row
//        collectionView.reloadData()
//    }
    
    
    
}

