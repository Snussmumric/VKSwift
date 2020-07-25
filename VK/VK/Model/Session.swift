//
//  Session.swift
//  VK
//
//  Created by Антон Васильченко on 25.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation

class Session: CustomStringConvertible {
    
    var token: String
    var userId: Int
    
    init(token: String, userId: Int) {
        self.token = token
        self.userId = userId
    }
    
    var description: String {
        return "token: \(token), userID: \(userId)"
    }
    
}
