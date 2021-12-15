//
//  UITextField+Extension.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 10/12/2021.
//

import Foundation


extension UITextField {
    func errorAnimated(){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = 4
        animation.duration = 0.4/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values  = [10 , -10]
        self.layer.add(animation, forKey: "shake")
        
        
    }
}
