//
//  AllFriendsCell.swift
//  VK
//
//  Created by Антон Васильченко on 20.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import Kingfisher

final class MyFriendsCell: UITableViewCell {
    
    @IBOutlet weak var friendName: UILabel!
//    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var containerView: AvatarView!


    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.makeCircle()
    }
    
    func configure(friend: Users) {
        friendName?.text = friend.name
        
        if let imageUrl = friend.imageUrl50, let url = URL(string: imageUrl) {
            let resource = ImageResource(downloadURL: url)
            containerView?.imageView.kf.setImage(with: resource)
        }
    }

}

extension UIView {

    func makeCircle() {
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }

}
