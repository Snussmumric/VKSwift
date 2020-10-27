//
//  NewsWallPhotoCell.swift
//  VK
//
//  Created by Антон Васильченко on 04.09.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import Kingfisher

class NewsWallPhotoCell: UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
//    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var postPhoto: UIImageView!

    
    lazy var service = VKService()
    var user: [Users] = []
    var group: [Groups] = []
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: NewsItems) {
        
//        authorImage.image = UIImage(systemName: "paperplane.fill")
        //        mainImageView.image = model.images.first
//        let date = Date(timeIntervalSince1970: model.date)
//        dateLabel.text = NewsCell.dateFormatter.string(from: date)
        
        authorLabel?.text = model.profile?.name

        

        if let imageUrl = model.profile?.imageURL, let url = URL(string: imageUrl) {
            let resource = ImageResource(downloadURL: url)
            authorImage?.kf.setImage(with: resource)
        }
        
        if let url = URL(string: model.photo?.url ?? "") {
            let resource = ImageResource(downloadURL: url)
            postPhoto?.kf.setImage(with: resource)
        }
//        postPhoto?.image = UIImage(systemName: "heart")
        
        //
        //        collectionView.register(UINib(nibName: "NewsPhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        //
    }
    
}
