//
//  AvatarView.swift
//  VK
//
//  Created by Антон Васильченко on 01.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

@IBDesignable class AvatarView: UIView {
    
    @IBInspectable var shadowRadius: CGFloat = 1 {
        didSet {
            updateShadow()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            updateShadow()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 1 {
        didSet {
            updateShadow()
        }
    }
    
    @IBInspectable var avatarImage: UIImage? = nil {
        didSet {
            imageView.image = avatarImage
            setNeedsDisplay()
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        view.backgroundColor = .black
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        print(#function)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(#function)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        avatarImage = UIImage(systemName: "person")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
        shadowView.layer.cornerRadius = shadowView.frame.width / 2
    }
    
    private func setup() {
        addSubview(shadowView)
        addSubview(imageView)
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            shadowView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            shadowView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
        ])
    }
    
    private func updateShadow() {
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOpacity = shadowOpacity
        shadowView.layer.shadowRadius = shadowRadius
    }
    
}
