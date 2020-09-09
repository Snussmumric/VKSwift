//
//  NewsModel.swift
//  VK
//
//  Created by Антон Васильченко on 06.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import RealmSwift

final class News: Object, Decodable {
    
    @objc dynamic var type: String = ""
    @objc dynamic var author: Int = 0
    @objc dynamic var date: Double = 0
    @objc dynamic var text: String? = ""
    @objc dynamic var commentsCount: Int = 0
    @objc dynamic var likesCount: Int = 0
    @objc dynamic var repostsCount: Int = 0
    @objc dynamic var viewsCount: Int = 0

    
    enum CodingKeys: String, CodingKey {
        case type
        case author = "source_id"
        case date
        case text
//        case attachments
//        case comments
//        case likes
//        case reposts
//        case views
    }
//
//    enum AttachmentsKeys: String, CodingKey {
//        case type
//        case photo
//    }
//
//    enum PhotoKeys: String, CodingKey {
//        case sizes
//    }
    
//    enum CommentKeys: String, CodingKey {
//        case commentsCount = "count"
//    }
//
//    enum LikesKeys: String, CodingKey {
//        case likesCount = "count"
//    }
//
//    enum RepostsKeys: String, CodingKey {
//        case repostsCount = "count"
//    }
//
//    enum ViewsKeys: String, CodingKey {
//        case viewsCount = "count"
//    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.author = try container.decode(Int.self, forKey: .author)
        self.date = try container.decode(Double.self, forKey: .date)
        self.text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
        
//        var attachmentsValues = try container.nestedUnkeyedContainer(forKey: .attachments)
//        let firstAttachmentValue = try attachmentsValues.nestedContainer(keyedBy: AttachmentsKeys.self)
//        self.photo = try firstAttachmentValue.decodeIfPresent(<#T##type: Bool.Type##Bool.Type#>, forKey: <#T##KeyedDecodingContainer<AttachmentsKeys>.Key#>)
        
//        let commentValues = try container.nestedContainer(keyedBy: CommentKeys.self, forKey: .comments)
//        self.commentsCount = try commentValues.decodeIfPresent(Int.self, forKey: .commentsCount) ?? 0
//
//        let likesValues = try container.nestedContainer(keyedBy: LikesKeys.self, forKey: .likes)
//        self.likesCount = try likesValues.decodeIfPresent(Int.self, forKey: .likesCount) ?? 0
//
//        let repostsValues = try container.nestedContainer(keyedBy: RepostsKeys.self, forKey: .reposts)
//        self.repostsCount = try repostsValues.decodeIfPresent(Int.self, forKey: .repostsCount) ?? 0
//
//        let viewsValues = try container.nestedContainer(keyedBy: ViewsKeys.self, forKey: .views)
//        self.viewsCount = try viewsValues.decodeIfPresent(Int.self, forKey: .viewsCount) ?? 0



    }
    
    
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
