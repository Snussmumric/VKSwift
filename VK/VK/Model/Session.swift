//
//  Session.swift
//  VK
//
//  Created by Антон Васильченко on 25.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation

class Session: CustomStringConvertible {
    
    static let instance = Session()
    
    private init() {}
    
    var token = ""
    var userId = 0
    
    var description: String {
        return "token: \(token), userID: \(userId)"
    }
    
}
