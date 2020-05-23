//
//  SaveToCoreDataViewController.swift
//  AlphaBeez
//
//  Created by Ivan Tilev on 23/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit
import CoreData

// MARK: - Here we can create new items and save them to the CoreData Model

// ( will be visible only for developer stuff only and the user will not have access to it! )
class SaveToCoreDataViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var imageTextField: UITextField!
    @IBOutlet weak var hapticTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func saveNameButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func saveCategoryButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func saveImageButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func saveHapticButtonPressed(_ sender: UIButton) {
    }
    

    // MARK: - Action that will save the Flashcard item to CoreData Model
    
    @IBAction func saveFlashcardPressed(_ sender: UIBarButtonItem) {
    }
    
    
}
