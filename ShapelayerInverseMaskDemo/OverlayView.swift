//
//  OverlayView.swift
//  ShapelayerInverseMaskDemo
//
//  Created by Bhat, Adithya H (external - Project) on 25/09/18.
//  Copyright © 2018 Bhat, Adithya H (external - Project). All rights reserved.
//

import UIKit

protocol OverlayViewDelegate:NSObjectProtocol {
    func overlayTapped()
}

class OverlayView: UIView {
    
    weak var delegate: OverlayViewDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let delegate = delegate {
            delegate.overlayTapped()
        }
    }
    
}
