//
//  NewsWallPhotoCell.swift
//  VK
//
//  Created by Антон Васильченко on 04.09.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class NewsWallPhotoCell: UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var postPhoto: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: NewsItems) {
        authorLabel?.text = model.profile?.name
    }
    
}
