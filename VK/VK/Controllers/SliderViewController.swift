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
    
    var transitionController: TransitionController? {
        return transitioningDelegate as? TransitionController
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photos.forEach {
            addSlide(image: $0)
        }
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
        transitionController?.endView = imageView
        
        
        stackView.addArrangedSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tap )
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        view.addGestureRecognizer(pan)
        
    }
    
    @objc func onPan(_ sender: UIPanGestureRecognizer) {
        guard let panView = sender.view else {return}
        
        let translation = sender.translation(in: panView)
        let percent = translation.y / panView.bounds.height
        
        switch sender.state {
        case .began:
            transitionController?.interactionController = UIPercentDrivenInteractiveTransition()
            dismiss(animated: true, completion: nil)
            
        case .changed:
            transitionController?.interactionController?.update(percent)
            
        case .cancelled:
            transitionController?.interactionController?.cancel()
            
        case .ended:
            if percent > 0.5 {
                transitionController?.interactionController?.finish()
            } else {
                transitionController?.interactionController?.cancel()
            }
            
        default:
            break
        }
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
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
