//
//  UIButton.swift
//  AlphaBeez
//
//  Created by Ivan Tilev on 02/06/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func applyShadowAndVisualFeedback() {
        self.showsTouchWhenHighlighted = true
        self.tintColor = .white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
}
