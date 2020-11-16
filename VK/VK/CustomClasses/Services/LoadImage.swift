//
//  LoadImage.swift
//  VK
//
//  Created by Антон Васильченко on 09.11.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import Kingfisher

final class LoadImage {
    
    func downloadImage(with urlString: String ,
                               completion: @escaping (UIImage?) -> Void) {
        guard let url = URL.init(string: urlString) else {
            return completion(nil)
        }
        let resource = ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                completion(value.image)
            case .failure:
                completion(nil)
            }
        }
    }
}
