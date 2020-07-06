//
//  FriendsHeader.swift
//  VK
//
//  Created by Антон Васильченко on 01.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class FriendsHeader: UITableViewHeaderFooterView {
    
    let title = UILabel()
    let image = UIImageView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: "header")
        configureHeader()
    }

     public required init?(coder: NSCoder) {
         super.init(coder: coder)
         print(#function)
         configureHeader()
     }
    
    func configureHeader() {
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(image)
        addSubview(title)
        
        // Center the image vertically and place it near the leading
        // edge of the view. Constrain its width and height to 50 points.
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Center the label vertically, and use it to fill the remaining
            // space in the header view.
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor,
                                           constant: 8),
            title.trailingAnchor.constraint(equalTo:
                contentView.layoutMarginsGuide.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        
    }
}
