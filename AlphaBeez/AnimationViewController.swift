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
    
    let sermoWorldImage = UIImage(named: "sermo-world")
    let ballImage = UIImage(named: "sermo-ball")

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sermoImageView.image = sermoWorldImage
        ballImageView.image = ballImage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Will hide the navigationController and leave only the back button!
         navigationController!.hideNavigationItemBackground()
        
        UIView.animate(withDuration: 7.0, animations: {
            self.sermoImageView.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi * 0.999))
            self.ballImageView.transform = CGAffineTransform(rotationAngle: .pi)
        }) { (finished: Bool) in
            self.performSegue(withIdentifier: "toMainMenu", sender: self)
        }
    }
}
