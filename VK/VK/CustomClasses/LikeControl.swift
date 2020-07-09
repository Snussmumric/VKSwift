//
//  LikeControl.swift
//  VK
//
//  Created by Антон Васильченко on 28.06.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

@IBDesignable class LikeControl: UIControl {
    
    @IBInspectable var isLiked : Bool = false {
        didSet {
            updateLike()
        }
    }
    
    @IBInspectable var likesCount : Int = 0 {
        didSet {
            countLabel.text = "\(likesCount)"
        }
    }
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    } ()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .red
        label.textAlignment = .center
        label.text = "\(0)"
        return label
    } ()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    } ()
    
   public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            ])
        
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(likeButton)
        
        
    }
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transfrom.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1
        
        layer.add(pulse, forKey: nil)
        
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        isLiked.toggle()
    }
    
    
    private func updateLike() {
        let imageName = isLiked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        likesCount = isLiked ? likesCount + 1 : likesCount - 1
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.countLabel.transform = .init(scaleX: 1.25, y: 1.25)
        }) { (finished: Bool) -> Void in
            self.countLabel.text = String(self.likesCount)
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                self.countLabel.transform = .identity
            })
        }
        
    }
    

}

