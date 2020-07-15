//
//  TransitionController.swift
//  VK
//
//  Created by Антон Васильченко on 14.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit


class TransitionController: NSObject, UIViewControllerTransitioningDelegate {
    
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    var startView: UIImageView?
    var endView: UIImageView?
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator(.present, startView: startView)
    }

    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator(.dismiss, startView: startView, endView: endView)
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }


    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return UIPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
