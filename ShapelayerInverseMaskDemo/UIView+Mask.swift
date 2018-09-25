//
//  UIView+Mask.swift
//  ShapelayerInverseMaskDemo
//
//  Created by Bhat, Adithya H (external - Project) on 25/09/18.
//  Copyright © 2018 Bhat, Adithya H (external - Project). All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func mask(rect: CGRect, inverse: Bool, isRounded rounded: Bool) {
        let path = UIBezierPath(roundedRect: rect,
                                cornerRadius: rounded ? min(rect.width, rect.height) / 5.0 : 0)
        let maskLayer = CAShapeLayer()
        
        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = kCAFillRuleEvenOdd
        }
        
        maskLayer.path = path.cgPath
        
        self.layer.mask = maskLayer
    }
    
    func clearMask() {
        guard let subLayers = layer.sublayers else {
            return
        }
        for layer in subLayers {
            layer.removeFromSuperlayer()
        }
    }
    
}

