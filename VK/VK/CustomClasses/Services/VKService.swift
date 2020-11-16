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

class VKService {
    
    let session = Session.instance
    
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
