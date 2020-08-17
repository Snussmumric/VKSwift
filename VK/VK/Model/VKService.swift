//
//  VKService.swift
//  VK
//
//  Created by Антон Васильченко on 29.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

final class VKService {
    
    let session = Session.instance
//    var ownerId: Int
    
    enum VKMethod {
        case friends
        case photos(id: Int)
        case groups
        case searchGroups(text: String)
        case users(id: String)
        
        
//        var ownerID: Int
        
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
                return ["user_ids": id, "fields": "photo_50"]
            case .groups:
                return ["extended": "1"]
            case let .searchGroups(text):
                return ["q": text]
            }
        }
    }
    
    func getData(_ method: VKMethod, completion: @escaping ((Data?) -> Void)) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = method.path
        let queryItems = [
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.68")
        ]
        let methodQueryItems = method.parameters.map { URLQueryItem(name: $0, value: $1) }
        components.queryItems = queryItems + methodQueryItems
        
        guard let url = components.url else {
            completion(nil)
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                completion(data)
            }
        }
        
        task.resume()
        
    }
    
    func getFriends(completion: @escaping ( [Users]) -> Void) {
        getData(.friends) { [weak self] (data) in
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let response = try JSONDecoder().decode(VKResponse<Users>.self, from: data)
                 completion(response.items)
                self?.saveUsers(response.items)
                
            } catch {
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func getGroups(completion: @escaping ([Groups]) -> Void) {
        getData(.groups) { [weak self] (data) in
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let response = try JSONDecoder().decode(VKResponse<Groups>.self, from: data)
                 completion(response.items)
                self?.saveGroups(response.items)
            } catch {
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func getUser(completion: @escaping ([Users]) -> Void) {
        getData(.groups) {  (data) in
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let response = try JSONDecoder().decode(VKResponse<Users>.self, from: data)
                 completion(response.items)
            } catch {
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func getPhotos(ownerID: Int, completion: @escaping ([Photos]) -> Void) {
        getData(.photos(id: ownerID)) { [weak self] (data) in
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let response = try JSONDecoder().decode(VKResponse<Photos>.self, from: data)
                 completion(response.items)
                self?.savePhotos(response.items)

                
            } catch {
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func saveUsers(_ users: [Users]) {
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.add(users)
            }
        } catch  {
            print(error)
        }
    }
    
    func saveGroups(_ groups: [Groups]) {
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.add(groups)
            }
        } catch  {
            print(error)
        }
    }

    func savePhotos(_ photos: [Photos]) {
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.add(photos)
            }
        } catch  {
            print(error)
        }
    }

    
}
