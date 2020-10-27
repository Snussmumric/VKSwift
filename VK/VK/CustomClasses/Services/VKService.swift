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
    
    enum VKMethod {
        case friends
        case photos(id: Int)
        case groups
        case searchGroups(text: String)
        case users(id: Int)
        case news(_ type: NewsItemType)
        case groupID(id: Int)
        
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
            }
        }
    }
    
    static func createURL(for method: VKMethod) -> URL? {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = method.path
        let queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.21")
        ]
        let methodQueryItems = method.parameters.map { URLQueryItem(name: $0, value: $1) }
        components.queryItems = queryItems + methodQueryItems
        
        return components.url
        
    }
    
    private func getData(_ method: VKMethod, completion: @escaping ((Data?) -> Void)) {

        
        guard let url = Self.createURL(for: method) else {
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
                //                print(data)
            }
        }
        
        task.resume()
        
    }
    
    func getData<T: Decodable>(_ method: VKMethod,
                               _ type: T.Type,
                               shouldCache: Bool = true,
                               completion:  (([T]) -> Void)? = nil) {
        getData(method) { [weak self] (data) in
            guard let data = data else {
                completion?([])
                return
            }
            
            do {
                let response = try JSONDecoder().decode(VKResponse<T>.self, from: data)
                if shouldCache, let objects = response.items as? [Object] {
                    self?.saveToRealm(objects)
                }
                completion?(response.items)
            } catch {
                print(error.localizedDescription)
                completion?([])
            }
        }
    }
    

    
    func getNews<T: News>(_ type: T.Type,
                          completion:  (([T]) -> Void)? = nil) {
        DispatchQueue.global(qos: .utility).async {
            
            self.getData(.news(.post)) { (data) in
                guard let data = data else {
                    completion?([])
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(NewsResponse<T>.self, from: data)
                    completion?(response.items)
                } catch {
                    print(error.localizedDescription)
                    completion?([])
                }
            }
        }
    }
    
    private func saveToRealm<T: Object >(_ objects: [T] ) {
        do {
            let realm = try Realm()
            
            try realm.write{
                realm.add(objects, update: .modified)
            }
        } catch {
            print(error)
        }
        
    }
    
}
