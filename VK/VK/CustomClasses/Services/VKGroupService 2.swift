
//
//  VKGroupService.swift
//  VK
//
//  Created by Антон Васильченко on 21.09.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation
import RealmSwift
import PromiseKit

final class VKGroupService {
    
    func get() {
        
        firstly{
            load()
        }.then{ data in
            self.parce(data)
            
        }.done { groups in
            try self.save(groups)
            
        }.catch { error in
            print(error)
        }
        
    }
    
    func load() -> Promise<Data> {
        
        guard let url = VKService.createURL(for: .groups) else {
            return Promise(error: PMKError.cancelled)
        }
        
        return Promise<Data> { (resolver) in
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error {
                    resolver.reject(error)
                } else {
                    resolver.fulfill(data ?? Data())
                }
                
            }.resume()
        }
    }
    
    func parce(_ data: Data) -> Promise<[Groups]> {
        return Promise<[Groups]> { (resolver) in
            do {
                let response = try JSONDecoder().decode(VKResponse<Groups>.self, from: data)
                resolver.fulfill(response.items)
            } catch {
                resolver.reject(error )
            }
        }
    }
    
    func save(_ groups: [Groups]) throws {
        
        let realm = try Realm()
        
        try realm.write{
            realm.add(groups, update: .modified)
        }
        
    }
    
}
