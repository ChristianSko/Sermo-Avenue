//
//  NavigationBarExtention.swift
//  AlphaBeez
//
//  Created by Ivan Tilev on 26/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func hideNavigationItemBackground() {
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = UIColor.clear
    }
}
