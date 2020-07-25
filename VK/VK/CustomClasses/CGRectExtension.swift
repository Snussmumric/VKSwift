//
//  CGRectExtension.swift
//  VK
//
//  Created by Антон Васильченко on 15.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

extension CGRect {
    
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
