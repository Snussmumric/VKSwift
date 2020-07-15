//
//  Animator.swift
//  VK
//
//  Created by Антон Васильченко on 14.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum PresentationType {
        case present
        case dismiss
        
        var isPresenting: Bool {
            return self == .present
        }
        
        var duration: TimeInterval {
            return isPresenting ? 0.75 : 0.25
        }
    }
    
    let presentationType: PresentationType
    var startView: UIImageView?
    var endView: UIImageView?
    
    init(_ presentationType: PresentationType, startView: UIImageView? = nil, endView: UIImageView? = nil) {
        self.presentationType = presentationType
        self.startView = startView
        self.endView = endView
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presentationType.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if presentationType.isPresenting {
            present(using: transitionContext)
        } else {
            dismiss(using: transitionContext)
        }
    }
    
    private func present(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard
            let toView = transitionContext.view(forKey: .to),
            let toViewController = transitionContext.viewController(forKey: .to),
            let startView = startView
            else {
                transitionContext.completeTransition(false)
                return
        }
        
        let originFrame = startView.convert(startView.bounds, to: containerView)
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        
        let xScaleFactor = originFrame.width / finalFrame.width
        let yScaleFactor = originFrame.height / finalFrame.height
        
        toView.transform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        toView.center = originFrame.center
        
        containerView.addSubview(toView)
        
        UIView.animate(
            withDuration: presentationType.duration,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.1,
            animations: {
                toView.transform = .identity
                toView.center = finalFrame.center
        }, completion: { (finished) in
            transitionContext.completeTransition(finished)
        })
    }
    
    private func dismiss(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard
            let toView = transitionContext.view(forKey: .to),
            let fromView = transitionContext.view(forKey: .from),
            let startView = startView,
            let endView = endView
            else {
                transitionContext.completeTransition(false)
                return
        }
        
        let originFrame = endView.frame
        let finalFrame = startView.convert(startView.bounds, to: containerView)
        
        let xScaleFactor = finalFrame.width / originFrame.width
        let yScaleFactor = finalFrame.height / originFrame.height
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(fromView)
        
        UIView.animate(
            withDuration: presentationType.duration,
            delay: 0,
            animations: {
                fromView.transform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
                fromView.center = finalFrame.center
        }, completion: { (finished) in
            transitionContext.completeTransition(finished)
        })
    }
}
