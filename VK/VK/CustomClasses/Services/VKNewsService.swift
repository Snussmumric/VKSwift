//
//  VKNewsService.swift
//  VK
//
//  Created by Антон Васильченко on 29.09.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation
import SwiftyJSON

struct NewsItems {
    var type: NewsItemType
    var sourceID: Int
    var text: String
    var date: Double
    var author: String?
    var authorImageURL: String?
    var likeCount: Int? = 0
    var viewCount: Int? = 0
    var commentCount: Int? = 0
    var repostCount: Int? = 0

    init (json: JSON) {
        
        let typeString = json["type"].stringValue
        self.type = NewsItemType(rawValue: typeString) ?? .post
        self.sourceID = json["source_id"].intValue
        self.text = json["text"].stringValue
        self.date = json["date"].doubleValue
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

struct NewsProfiles {
    var id: Int
    var name: String
    var imageURL: String
    
    init (json: JSON) {
        self.id = json["id"].intValue
        self.name = json["first_name"].stringValue
        self.imageURL = json["photo_50"].stringValue
    }
}

struct NewsGroups {
    var id: Int
    var name: String
    var imageURL: String
    
    init (json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.imageURL = json["photo_50"].stringValue
    }
}

final class VKNewsService {
    
    func get (completion: @escaping ([NewsItems]) -> Void) {
        
        guard let url = VKService.createURL(for: .news(.post)) else {
            completion([])
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            let items = self?.parce(data) ?? []
            completion(items )
            //                print(data)
        }
        
        
        task.resume()
    }
    
    func parce(_ data: Data?) -> [NewsItems] {
        guard let data = data else { return [] }
        
        do {
            let json = try JSON(data: data)
            let items = json["response"]["items"].arrayValue.map {NewsItems(json: $0)}
            let profiles = json["response"]["profiles"].arrayValue.map {NewsProfiles(json: $0)}
            let groups = json["response"]["groups"].arrayValue.map {NewsGroups(json: $0)}
            let newItems =  matchItems(items, profile: profiles, group: groups)
            return newItems
        } catch  {
            print(error)
            return []
        }
    }
    
    func matchItems(_ items: [NewsItems], profile: [NewsProfiles], group: [NewsGroups]) -> [NewsItems]{
        
        var newItems: [NewsItems] = []
        
        for item in items {
            var newItem = item
            if item.sourceID > 0 {
                let profile = profile.filter ({item.sourceID == $0.id}).first
                newItem.author = profile?.name
                newItem.authorImageURL = profile?.imageURL
            } else {
                let group = group.filter ({(item.sourceID * -1) == $0.id}).first
                newItem.author = group?.name
                newItem.authorImageURL = group?.imageURL
            }
            newItems.append(newItem)
        }
        
        return newItems
    }
    
}


