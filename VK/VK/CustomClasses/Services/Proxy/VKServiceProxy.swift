//
//  VKServiceProxy.swift
//  VK
//
//  Created by Антон Васильченко on 16.11.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation

protocol VKServiceInterface {
    func getData(_ method: VKMethod, completion: @escaping ((Users) -> Void))
}

class VKServiceProxy: VKServiceInterface {
    var users = Users()
    let vkService: VKService
    init(vkService: VKService) {
        self.vkService = vkService
    }
    
    func getData(_ method: VKMethod, completion: @escaping ((Users) -> Void)) {
        self.getData(.friends) { [weak self] (users: Users) in
            self?.users = users
            print("called func getWeathers with city=\(users)")
        }
        
    }
    
}
