//
//  UIViewExtentionCircleShapeAndCorners.swift
//  vk
//
//  Created by Alex on 06.08.18.
//  Copyright © 2018 Dev Hom. All rights reserved.
//

import UIKit

extension UIView {
    func circle() {
        round(self.frame.height / 2)
    }
    
    func round(_ radius: CGFloat) {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
