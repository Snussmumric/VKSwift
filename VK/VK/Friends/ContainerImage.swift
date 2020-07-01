//
//  FriendImage.swift
//  VK
//
//  Created by Антон Васильченко on 25.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

@IBDesignable class ContainerImage: UIImageView {
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            layer.shadowRadius = shadowRadius
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowOpacity: CGFloat = 0.0 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.black
    
}
