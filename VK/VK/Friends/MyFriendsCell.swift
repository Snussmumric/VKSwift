//
//  AllFriendsCell.swift
//  VK
//
//  Created by Антон Васильченко on 20.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class MyFriendsCell: UITableViewCell {
    
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var containerView: AvatarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
