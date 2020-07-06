//
//  NewsCell.swift
//  VK
//
//  Created by Антон Васильченко on 02.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!

    func configure(model: NewsModel) {
        mainImageView.image = model.images.first
        authorLabel.text = model.author
        dateLabel.text = model.postDate
        newsText.text = model.text
        
        collectionView.register(UINib(nibName: "NewsPhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
    }

    
    func setCollectionDelegate (_ delegate: UICollectionViewDataSource & UICollectionViewDelegate, for row: Int) {
        collectionView.dataSource = delegate
        collectionView.delegate = delegate
        collectionView.tag = row
        collectionView.reloadData()
    }
    

    
}
