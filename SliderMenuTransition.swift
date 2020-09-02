//
//  SliderMenuTransition.swift
//  HoustonMTSApp
//
//  Created by Uma Sethuraman.
//  Copyright © 2019-2020 Houston Meenakshi Temple. All rights reserved.
//

import UIKit

class SliderMenuTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    /* Check if menu is needed at this moment */
    var isPresenting = false
    
    let dimView = UIView()
    
    /* How long it takes the menu to slide out */
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    /* Set transition for menu to slide out when the menu button is clicked */
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toController = transitionContext.viewController(forKey: .to),
            let fromController = transitionContext.viewController(forKey: .from) else { return }
        
        let container = transitionContext.containerView
        
        let width = toController.view.bounds.width * 0.8
        let height = fromController.view.bounds.height
        if isPresenting {
            dimView.backgroundColor = .black
            dimView.alpha = 0.0
            container.addSubview(dimView)
            dimView.frame = container.bounds
            container.addSubview(toController.view)
            
            toController.view.frame = CGRect(x: -width, y:0, width: width, height: height)
        }
        
        /* Animate menu onto screen */
        let transform = {
            self.dimView.alpha = 0.5
            toController.view.transform = CGAffineTransform(translationX: width, y: 0)
        }
        
        /* Animate menu back off of screen */
        let identity = {
            self.dimView.alpha = 0.0
            fromController.view.transform = .identity
        }
        
        /* Allows menu to stay on screen until user clicks on an option
           and dismisses it */
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transform() : identity()
        }) { (_) in
            transitionContext.completeTransition(!isCancelled)
        }
    }
}
