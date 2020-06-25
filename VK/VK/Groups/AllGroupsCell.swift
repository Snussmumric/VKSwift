//
//  AllGroupsCell.swift
//  VK
//
//  Created by Антон Васильченко on 20.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class AllGroupsCell: UITableViewCell {

    @IBOutlet weak var allGroupsName: UILabel!
    @IBOutlet weak var allGroupsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        allGroupsImage.layer.borderWidth = 1
        allGroupsImage.layer.masksToBounds = false
        allGroupsImage.layer.borderColor = UIColor.clear.cgColor
        allGroupsImage.layer.cornerRadius = allGroupsImage.frame.height/2
        allGroupsImage.clipsToBounds = true
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
