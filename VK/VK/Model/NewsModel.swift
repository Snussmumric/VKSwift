//
//  NewsModel.swift
//  VK
//
//  Created by Антон Васильченко on 06.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import RealmSwift

class News: Decodable {
    
    var type: String = ""
    var author: Int = 0
    var date: Double = 0
    var text: String? = ""
    var commentsCount: Int = 0
    var likesCount: Int = 0
    var repostsCount: Int = 0
    var viewsCount: Int = 0
    
    
    enum CodingKeys: String, CodingKey {
        case type
        case author = "source_id"
        case date
        case text
        //        case attachments
        case comments
        case likes
        case reposts
        case views
        case count
    }

    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.author = try container.decode(Int.self, forKey: .author)
        self.date = try container.decode(Double.self, forKey: .date)
        self.text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
        
        if let nestedContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .likes) {
            self.likesCount = try nestedContainer.decode(Int.self,forKey: .count)
        }
        if let nestedContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .comments) {
            self.commentsCount = try nestedContainer.decode(Int.self,forKey: .count)
        }
        if let nestedContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .reposts) {
            self.repostsCount = try nestedContainer.decode(Int.self,forKey: .count)
        }
        if let nestedContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .views) {
            self.viewsCount = try nestedContainer.decode(Int.self,forKey: .count)
        }

        
    }
}



enum NewsItemType: String {
    case post
    case photo
}

//struct NewsModel {
//
//    var author: String
//    var postDate: String
//    var text: String
//    var images: [UIImage]
//
//    static let fake: [NewsModel] = (1...6).map { _ in
//        NewsModel(
//            author: "Bob",
//            postDate: "01.01.1901",
//            text: "TestPost",
//            images: (1...Int.random(in: 6...10))
//                .map({$0 % 6})
//                .shuffled()
//                .compactMap({String($0)})
//                .compactMap({UIImage(named: $0)})
//        )
//    }
//}
