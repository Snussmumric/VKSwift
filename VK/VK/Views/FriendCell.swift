//
//  FriendCell.swift
//  VK
//
//  Created by Антон Васильченко on 21.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import Kingfisher

class FriendCell: UICollectionViewCell {
    @IBOutlet weak var friendBigPhotos: UIImageView!
    
    
    func configure(photo: Photos) {
        
        if let imageUrl = photo.imageURL, let url = URL(string: imageUrl) {
            let resource = ImageResource(downloadURL: url)
            friendBigPhotos?.kf.setImage(with: resource)
        }
    }
        
}
