//
//  FriendCell.swift
//  VK
//
//  Created by Антон Васильченко on 21.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class FriendCell: UICollectionViewCell {
    @IBOutlet weak var friendBigImage: UIImageView!
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
    
    @IBAction func likePressed() {
        if likeButton.currentImage == UIImage(systemName: "heart"){
            
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeLabel.text = "1"
        }else{
            
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeLabel.text = "0"
            
        }
        
    }
    
}
