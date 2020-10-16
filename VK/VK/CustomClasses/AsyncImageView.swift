//
//  AsyncImageView.swift
//  VK
//
//  Created by Антон Васильченко on 02.10.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class AsyncImageView: UIImageView {
    
    private var _image: UIImage?
    
    override var image: UIImage? {
        get {
            return _image
        }
        set {
            _image = newValue
            
            layer.contents = nil
            guard let image = newValue else {return}
            DispatchQueue.global(qos: .userInitiated).async {
                let decodedImage = self.decode(image)
                DispatchQueue.main.async {
                    self.layer.contents = decodedImage
                }
            }
        }
        
    }
    
    private func decode(_ image: UIImage) -> CGImage? {
        guard let newImage = image.cgImage else {return nil}
        
        if let cachedImage = AsyncImageView.cache.object(forKey: image) {
            return (cachedImage as! CGImage)
        }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(
            data: nil,
            width: newImage.width,
            height: newImage.height,
            bitsPerComponent: 8,
            bytesPerRow: newImage.width * 4,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue
        )
        
        context?.draw(newImage, in: CGRect(x: 0, y: 0, width: newImage.width, height: newImage.height))
        
        guard let drawImage = context?.makeImage() else {return nil}
        AsyncImageView.cache.setObject(drawImage, forKey: image)
        
        return drawImage
    }
    
    private struct Cache {
        static var instance = NSCache<AnyObject, AnyObject>()
    }
    
    class var cache: NSCache<AnyObject,AnyObject> {
        get {
            return Cache.instance
        }
        set {
            Cache.instance = newValue
        }
    }
    
}

