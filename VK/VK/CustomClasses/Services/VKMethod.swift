//
//  VKMethod.swift
//  VK
//
//  Created by Антон Васильченко on 16.11.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation

enum VKMethod {
    case friends
    case photos(id: Int)
    case groups
    case searchGroups(text: String)
    case users(id: Int)
    case news(_ type: NewsItemType)
    case groupID(id: Int)
    case stats
    
    var path: String {
        switch self {
        case .friends:
            return "/method/friends.get"
        case .photos:
            return "/method/photos.getAll"
        case .groups:
            return "/method/groups.get"
        case .users:
            return "/method/users.get"
        case .searchGroups:
            return "/method/groups.search"
        case .news:
            return "/method/newsfeed.get"
        case .groupID:
            return "/method/groups.getById"
        case .stats:
        return "/method/stats.trackVisitor"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .friends:
            return ["fields": "photo_50,photo_100"]
        case let .photos(id):
            return ["owner_id": String(id)]
        case let .users(id):
            //                let param =
            return ["user_ids": String(id), "fields": "photo_50"]
        case .groups:
            return ["extended": "1"]
        case let .searchGroups(text):
            return ["q": text]
        case let .news(type):
            return ["filter": type.rawValue]
        //                return ["filter": "post,photo,photo_tag,wall_photo"]
        case let .groupID(id):
            return ["group_id": String(id)]
        case .stats:
        return [:]
        }
    }
}
