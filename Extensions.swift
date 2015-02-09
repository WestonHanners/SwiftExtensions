//
//  Extensions.swift
//
//  Created by Weston Hanners on 1/8/15.
//  Copyright (c) 2015 Hanners Software. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func pushStoryboard(name: String, bundle: NSBundle?) {
        
        pushStoryboard(name: name, bundle: bundle, transitionDelegate: nil)

    }
    
    func pushStoryboard(#name: String, bundle: NSBundle?, transitionDelegate: UINavigationControllerDelegate?) {
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        
        let destination = storyboard.instantiateInitialViewController() as UIViewController
        
        if let delegate = transitionDelegate {
            self.delegate = delegate
        }
        
        pushViewController(destination, animated: true)
    }
    
}

extension UIViewController {
    
    func presentStoryboard(name: String, bundle: NSBundle?) {
        
        presentStoryboard(name: name, bundle: bundle, transitionDelegate: nil)
        
    }
    
    func presentStoryboard(#name: String, bundle: NSBundle?, transitionDelegate: UIViewControllerTransitioningDelegate?) {
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        
        let destination = storyboard.instantiateInitialViewController() as UIViewController
        
        if let delegate = transitionDelegate {
            destination.transitioningDelegate = transitionDelegate
        }
        
        presentViewController(destination, animated: true, completion: nil)
    }
}

extension UINavigationBar {
    
    func removeShadow() {
        if let view = removeShadowFromView(self) {
            view.removeFromSuperview()
        }
    }
    
    func removeShadowFromView(view: UIView) -> UIImageView? {
    
        if (view.isKindOfClass(UIImageView) && view.bounds.size.height <= 1) {
            return view as? UIImageView
        }
        
        for subView in view.subviews {
    
            if let imageView = removeShadowFromView(subView as UIView) {
                return imageView
            }
        }
        
        return nil
    }
   
}

extension UIImage {
    
    func tintedWith(color: UIColor) -> UIImage {
    
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)

        let context = UIGraphicsGetCurrentContext() as CGContextRef
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, kCGBlendModeNormal)

        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        color.setFill()
        CGContextFillRect(context, rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()

        return newImage
    }

}

extension Array {
    func firstObjectOfType(c: AnyClass) -> AnyObject? {
        
        return filter({
        
            let obj = $0 as NSObject
            
            return obj.isKindOfClass(c)
        
        }).first as NSObject
        
    }
    
    func contains<T : AnyObject>(obj: T) -> Bool {
        return self.filter({$0 as? T === obj}).count > 0
    }
}