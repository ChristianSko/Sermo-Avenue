//
//  AnimationViewController.swift
//  AlphaBeez
//
//  Created by Ivan Tilev on 06/06/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit
import CoreGraphics

class AnimationViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var sermoImageView: UIImageView!
    @IBOutlet weak var ballImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Will hide the navigationController and leave only the back button!
         navigationController!.hideNavigationItemBackground()
        
        UIView.animate(withDuration: 9.0) {
            self.sermoImageView.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi * 0.999))
            self.ballImageView.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
}
