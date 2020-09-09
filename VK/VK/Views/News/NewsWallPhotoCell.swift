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
//    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var postPhoto: UIImageView!

    
    lazy var service = VKService()
    var user: [Users] = []
    var group: [Groups] = []
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM HH:mm"
        return formatter
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: News) {
        
        authorImage.image = UIImage(systemName: "paperplane.fill")
        //        mainImageView.image = model.images.first
        let date = Date(timeIntervalSince1970: model.date)
        dateLabel.text = NewsCell.dateFormatter.string(from: date)
        
        
        if model.author < 0 {
            authorLabel.text = "Group"
//            model.author = model.author * -1
//            service.getData(.groupID(id: model.author), Groups.self, shouldCache: false) {
//                [weak self] (group: [Groups]) in
//                self?.group = group
//                print(group.capacity)
//            }
            
            
        }
        if model.author > 0 {
            authorLabel.text = "User"
            
        }
        
        //        dateLabel.text = String(NSDate(timeIntervalSince1970: TimeInterval(model.date)))
//        newsText.text = model.text
        postPhoto.image = UIImage(named: "2")
        //
        //        collectionView.register(UINib(nibName: "NewsPhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        //
    }
    
}
