//
//  VKMethods.swift
//  VK
//
//  Created by Антон Васильченко on 29.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation
import Alamofire

class VkMethods {
    
    var session = Session.instance
    
    func getVkFriends () {
        
        let urlPath = "https://api.vk.com/method/friends.get"
        let parameters: Parameters = [
            "user_id": session.userId,
            "fields": "bdate,city,domain",
            "access_token": session.token,
            "v": "5.68",
            "order": "name",
            "count": "3"
        ]
        AF.request(urlPath, parameters: parameters).responseJSON {(response) in print(response.value ?? "No JSON")}
        
    }
    
    func getPhotos() {
        let urlPath = "https://api.vk.com/method/photos.getAll"
        let parameters: Parameters = [
            "owner_id" : session.userId,
            "count": 2,
            "access_token": session.token,
            "v": "5.68"
        ]
        AF.request(urlPath, parameters: parameters).responseJSON {(response) in print(response.value ?? "No JSON")}

    }
    
    func getGroups() {
        print(session.token)
        let urlPath = "https://api.vk.com/method/groups.get"
        let parameters: Parameters = [
            "user_id": session.userId,
            "count": 2,
            "access_token": session.token,
            "v": "5.68"
        ]
        AF.request(urlPath, parameters: parameters).responseJSON {(response) in print(response.value ?? "No JSON")}

    }
    
    func getSearchedGroups() {
        let urlPath = "https://api.vk.com/method/groups.search"
        let parameters: Parameters = [
            "q": "Auto",
            "count": 2,
            "access_token": session.token,
            "v": "5.68"
        ]
        AF.request(urlPath, parameters: parameters).responseJSON {(response) in print(response.value ?? "No JSON")}
        
    }
    
}
