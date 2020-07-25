//
//  ZoomedPictureController.swift
//  VK
//
//  Created by Антон Васильченко on 15.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class ZoomedPictureController: UIViewController {
    
    var photo: UIImage?
    
    @IBOutlet weak var friendBigPhoto: UIImageView!
    
    var transitionController: TransitionController? {
        return transitioningDelegate as? TransitionController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendBigPhoto.image = photo
        transitionController?.endView = friendBigPhoto
        
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
