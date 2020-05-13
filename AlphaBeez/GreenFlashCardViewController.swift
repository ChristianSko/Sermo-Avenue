//
//  GreenFlashCardViewController.swift
//  AlphaBeez
//
//  Created by Nadia Ruocco on 13/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

class GreenFlashCardViewController: UIViewController {
    

    @IBOutlet weak var GreenImageView: UIImageView!
    @IBOutlet weak var GreenLabel: UILabel!
    @IBOutlet weak var GreenCameraButton: UIButton!
    @IBOutlet weak var GreenRecordButton: UIButton!
    @IBOutlet weak var GreenPlayButton: UIButton!
    
override func viewDidLoad() {
       super.viewDidLoad()
       // Do any additional setup after loading the view.
    GreenImageView.image = UIImage(named: "real")
   }
    


}
