//
//  SliderViewController.swift
//  VK
//
//  Created by Антон Васильченко on 06.08.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit
import Kingfisher

class SliderViewController: UIViewController {

    var photos: [Photos] = []
    var currentIndex = 0
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        photos.forEach { addSlide(image: $0) }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.scrollToPage(page: currentIndex, animated: true)
    }
    
    // MARK: - Helpers
    
    private func addSlide(image: Photos) {
        
        

        
        let imageView = UIImageView()
        
        if let imageUrl = image.imageURL, let url = URL(string: imageUrl) {
            let resource = ImageResource(downloadURL: url)
            imageView.kf.setImage(with: resource)
        }
        
        imageView.contentMode = .scaleAspectFit
        
        stackView.addArrangedSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }

}

extension UIScrollView {
    
    func scrollToPage(page: Int, animated: Bool) {
        var frame = self.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        scrollRectToVisible(frame, animated: animated)
    }
    
}
