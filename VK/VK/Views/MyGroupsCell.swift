//
//  MyGroupsCell.swift
//  VK
//
//  Created by Антон Васильченко on 20.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class MyGroupsCell: UITableViewCell {
    
    @IBOutlet weak var myGroupImage: UIImageView!
    @IBOutlet weak var myGroupName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer (target: self, action: #selector(avatarTapped))
        myGroupImage.isUserInteractionEnabled = true
        myGroupImage.addGestureRecognizer(tap)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    
    @objc func avatarTapped(_ recognizer: UITapGestureRecognizer) {
        
        
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0,
            options: [],
            animations: {
                self.myGroupImage.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.myGroupImage.transform = .identity
        }, completion: { _ in
            
        })
    }
    
}
