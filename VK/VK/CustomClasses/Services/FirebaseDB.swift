//
//  FirebaseDB.swift
//  VK
//
//  Created by Антон Васильченко on 22.08.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class FirebaseDB {
    let groupID: Int
    var ref: DatabaseReference?
    
    init( groupID: Int) {
        self.groupID = groupID
    }
    
    init?(snapshot: DataSnapshot){
        guard
            let value = snapshot.value as? [String: Any],
            let groupID = value["groupID"] as? Int
            else {return nil}
        
        self.groupID = groupID
        self.ref = snapshot.ref
    }
    
    
    func toDatabase() -> Int {
        return groupID
    }
}
