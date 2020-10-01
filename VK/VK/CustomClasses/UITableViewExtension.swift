//
//  UITableViewExtension.swift
//  VK
//
//  Created by Антон Васильченко on 01.10.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func showEmptyMessage(_ message: String) {
        let label = UILabel(frame: bounds)
        label.text = message
        label.textColor = .orange
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        
        self.backgroundView = label
        
    }
    
    func hideEmptyMessage() {
        self.backgroundView = nil
    }
}
