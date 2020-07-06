//
//  NewsModel.swift
//  VK
//
//  Created by Антон Васильченко on 06.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

struct NewsModel {
    
    var author: String
    var postDate: String
    var text: String
    var images: [UIImage]
    
    static let fake: [NewsModel] = (1...6).map { _ in
        NewsModel(
            author: "Bob",
            postDate: "01.01.1901",
            text: "TestPost",
            images: (1...Int.random(in: 6...10))
                .map({$0 % 6})
                .shuffled()
                .compactMap({String($0)})
                .compactMap({UIImage(named: $0)})
        )
    }
}
