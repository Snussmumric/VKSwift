//
//  VKNewsService.swift
//  VK
//
//  Created by Антон Васильченко on 29.09.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation
import SwiftyJSON

class VKNewsService {
    
    let session = Session.instance
    
    func get (fromTime startTime: TimeInterval? = nil, fromID startID: String = "", completion: @escaping ([NewsItems], String) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/newsfeed.get"
        var queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.21"),
            URLQueryItem(name: "start_from", value: startID)
        ]
        if let startTime = startTime  {
            queryItems.append(URLQueryItem(name: "start_time", value: String(startTime)))
        }
        components.queryItems = queryItems
        
        guard let url = components.url else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            var items: [NewsItems] = []
            var nextFrom = ""
            if let data = data, let json = try? JSON(data: data) {
                items = self?.parce(json) ?? []
                nextFrom = json["response"]["next_from"].stringValue
            }
            DispatchQueue.main.async {
                completion(items, nextFrom)
            }
            
            
        }.resume()
    }
    
    func parce (_ json: JSON) -> [NewsItems] {
        
        let profiles = json["response"]["profiles"].arrayValue.map {NewsProfiles(json: $0)}
        let groups = json["response"]["groups"].arrayValue.map {NewsProfiles(json: $0)}
        let allProfiles = profiles + groups
        
        let items = json["response"]["items"].arrayValue.map{NewsItems(json: $0)}
        for (index, item) in items.enumerated(){
            items[index].profile = allProfiles.first(where: { abs(item.sourceID) == $0.id }) 
        }
        return items
        
        
    }
    
    //    func get (completion: @escaping ([NewsItems]) -> Void) {
    //
    //        guard let url = VKService.createURL(for: .news(.post)) else {
    //            completion([])
    //            return
    //        }
    //
    //        let session = URLSession.shared
    //        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
    //            if let error = error {
    //                print(error.localizedDescription)
    //            }
    //            var items: [NewsItems] = []
    //            if let data = data, let json = try?JSON(data: data) {
    //                items = self?.parce(json) ?? []
    //            }
    //            completion(items)
    //            //                print(data)
    //        }
    //
    //
    //        task.resume()
    //    }
    
    //    func parce(_ json: JSON) -> [NewsItems] {
    //        let profiles = json["response"]["profiles"].arrayValue.map {NewsProfiles(json: $0)}
    //        let groups = json["response"]["groups"].arrayValue.map {NewsProfiles(json: $0)}
    //        let allProfiles = profiles + groups
    //        //            let newItems =  matchItems(items, profile: profiles, group: groups)
    //        //            return newItems
    //        var items = json["response"]["items"].arrayValue.map {NewsItems(json: $0)}
    //        for (index,item) in items.enumerated() {
    //            items[index].profile = allProfiles.first(where: {abs(item.sourceID) == $0.id})
    //        }
    //        return items
    //    }
    
    //    func matchItems(_ items: [NewsItems], profile: [NewsProfiles], group: [NewsGroups]) -> [NewsItems]{
    //
    //        var newItems: [NewsItems] = []
    //
    //        for item in items {
    //            var newItem = item
    //            if item.sourceID > 0 {
    //                let profile = profile.filter ({item.sourceID == $0.id}).first
    //                newItem.author = profile?.name
    //                newItem.authorImageURL = profile?.imageURL
    //            } else {
    //                let group = group.filter ({(item.sourceID * -1) == $0.id}).first
    //                newItem.author = group?.name
    //                newItem.authorImageURL = group?.imageURL
    //            }
    //            newItems.append(newItem)
    //        }
    //
    //        return newItems
    //    }
    
}


