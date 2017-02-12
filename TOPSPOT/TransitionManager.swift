//
//  TransitionManager.swift
//  TOPSPOT
//
//  Created by Ludo on 09/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private var preseting = true
    
    // return how many seconds the transiton animation will take
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.preseting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.preseting = false
        return self
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // get reference to our fromView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        // set up from 2D transforms that we'll use in the animation
        let offScreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
        
        // start the toView to the right of the screen
        var whereTo = offScreenLeft
        let toVC = transitionContext.viewController(forKey: .to)
        let title = toVC!.title!
        if self.preseting == true {
        switch title {
        case "Login":
            toView.transform = offScreenLeft
            whereTo = offScreenRight
        case "SignUp", "DiscoverList" :
            toView.transform = offScreenRight
            whereTo = offScreenLeft
        default:
            toView.transform = offScreenRight
            whereTo = offScreenLeft
        }
        } else {
            switch title {
            case "Login":
                toView.transform = offScreenLeft
                whereTo = offScreenRight
            case "DiscoverList" :
                toView.transform = offScreenLeft
                whereTo = offScreenRight
            default:
                toView.transform = offScreenRight
                whereTo = offScreenLeft
            }
        }
        
        // add the both views to our view controller
        container.addSubview(toView)
        container.addSubview(fromView)
        
        // get the duration of the animation
        // DON'T just type '0.5s' -- the reason why won't make sense until the next post
        // but for now it's important to just follow this approach
        let duration = self.transitionDuration(using: transitionContext)
        
        // perform the animation!
        // for this example, just slid both fromView and toView to the left at the same time
        // meaning fromView is pushed off the screen and toView slides into view
        // we also use the block animation usingSpringWithDamping for a little bounce
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, animations: {
            
            fromView.transform = whereTo
            toView.transform = .identity
            
        }, completion: { finished in
            
            // tell our transitionContext object that we've finished animating
            transitionContext.completeTransition(true)
            
        })
        
    }
}
