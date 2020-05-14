//
//  ViewController.swift
//  AlphaBeez
//
//  Created by Ivan Tilev on 12/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

// This is the main menu screen with the categories inside
class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var marketButton: UIButton!
    @IBOutlet weak var parkButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Will transfer to the chosen category screen with the flashcards
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toCategory", sender: self)
    }
    
}
