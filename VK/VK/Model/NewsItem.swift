//
//  NewsItem.swift
//  VK
//
//  Created by Антон Васильченко on 30.09.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

final class NewsItems {
    var type: NewsItemType
    var profile: NewsProfiles?
    var sourceID: Int
    var date: Double
    var author: String?
    var authorImageURL: String?
    var likeCount: Int = 0
    var viewCount: Int = 0
    var commentCount: Int = 0
    var repostCount: Int = 0
    
    var text: String?
    var photo: NewsItemPhoto?
//    var attachmentURL: String?

    init(json: JSON) {
        
        self.type = NewsItemType(rawValue: json["type"].stringValue) ?? .post
        self.sourceID = json["source_id"].intValue
        self.date = json["date"].doubleValue
        self.likeCount = json["likes"]["count"].intValue
        self.viewCount = json["views"]["count"].intValue
        self.commentCount = json["comments"]["count"].intValue
        self.repostCount = json["reposts"]["count"].intValue
//        self.attachmentURL = json["attachments"]["photo"]["sizes"].arrayValue.map{$0["url"].stringValue}
        
        switch self.type {
        case .post:
            self.text = json["text"].string
        case .photo:
            if let json = json["photos"]["items"].arrayValue.first {
                self.photo = NewsItemPhoto(json: json)
            }
            
//            self.photoURL = json["photos"]["items"].arrayValue.first?["photo_604"].string ?? ""
        
        }
        

    }
}

final class NewsItemPhoto{
    var sourceID: Int
    var date: Double
    var height: Int
    var width: Int
    var url: String
    var likeCount: Int = 0
    var viewCount: Int = 0
    var commentCount: Int = 0
    var repostCount: Int = 0
    
    var aspectRatio: CGFloat {
        return CGFloat(height) / CGFloat(width)
    }
    
    init(json: JSON) {
        
        self.sourceID = json["post_id"].intValue
        self.date = json["date"].doubleValue
        self.height = json["height"].intValue
        self.width = json["width"].intValue
        self.url = json["photo_604"].stringValue
        self.likeCount = json["likes"]["count"].intValue
        self.viewCount = json["views"]["count"].intValue
        self.commentCount = json["comments"]["count"].intValue
        self.repostCount = json["reposts"]["count"].intValue
        
    }
}


enum NewsItemType: String {
    case post
    case photo = "wall_photo"
}

final class NewsProfiles {
    var id: Int
    var name: String
    var imageURL: String?
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.imageURL = json["photo_50"].stringValue
        if let name = json["name"].string {
            self.name = name
        } else {
            let firstName = json["first_name"].stringValue
            let lastName = json["last_name"].stringValue
            self.name = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
        }
    }
}
