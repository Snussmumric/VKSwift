//
//  NewsPhotoCollectionCell.swift
//  VK
//
//  Created by Антон Васильченко on 06.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class NewsPhotoCollectionCell: UICollectionViewCell {

@IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.isHidden = true
        
    }
}
