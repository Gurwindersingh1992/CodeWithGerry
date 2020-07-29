//
//  View+Helper.swift
//  SceneProject
//
//  Created by Gurwinder singh on 28/07/20.
//  Copyright © 2020 Gurwinder singh. All rights reserved.
//

import Foundation
import UIKit


extension UIView{
    
    func dropShadow(shadowValue : CGFloat ){
        // All UIChanges should be on Main Thread Only for Running Smoothly without issues.
        
        DispatchQueue.main.async {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: shadowValue, height: shadowValue)
            self.layer.shadowRadius = shadowValue
            self.layer.shadowOpacity = 1.0
            self.layer.cornerRadius = shadowValue
        }
        
    }
    
    func shake(){
        DispatchQueue.main.async {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
            self.layer.add(animation, forKey: "position")
        }
    }
}
extension UIImageView{
    
    func makeRounded() {
        
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
}
