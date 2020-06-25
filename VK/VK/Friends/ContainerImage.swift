//
//  FriendImage.swift
//  VK
//
//  Created by Антон Васильченко on 25.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
 
@IBDesignable class ContainerImage: UIImageView {

//    @IBInspectable var newColor : UIColor = UIColor.black
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
        
    
    
    //    @IBInspectable var newOpacity : shad

//
//    layer.shadowColor = UIColor.gray.cgColor
//    layer.shadowOffset = CGSize(width: 0, height: 0)
//    layer.shadowOpacity = 0.2
//    layer.shadowRadius = 8.0
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
