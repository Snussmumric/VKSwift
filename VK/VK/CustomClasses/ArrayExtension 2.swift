//
//  ArrayExtension.swift
//  VK
//
//  Created by Антон Васильченко on 18.08.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation


extension Array where Element == Int {
    
    func mapToIndexPaths () -> [IndexPath] {
        return map({IndexPath(row: $0, section: 0)})
    }
}
