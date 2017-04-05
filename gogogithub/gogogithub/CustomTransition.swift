//
//  CustomTransition.swift
//  gogogithub
//
//  Created by Annie Ton-Nu on 4/5/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class CustomTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var duration: TimeInterval
    
    init(duration: TimeInterval = 0.5) {
        self.duration = duration
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    
    //I don't understand this
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
       
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return } //we use guard let because 2 view controllers are optional
    
        transitionContext.containerView.addSubview(toViewController.view)
        
        toViewController.view.alpha = 0.0
        
       
        UIView.animate(withDuration: self.duration, animations: {
            toViewController.view.alpha = 1.0
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
        
    }




}
