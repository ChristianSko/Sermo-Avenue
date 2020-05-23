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
class SaveToCoreDataViewController: UIViewController, UITextFieldDelegate {
    
    // Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var imageTextField: UITextField!
    @IBOutlet weak var hapticTextField: UITextField!
    @IBOutlet weak var syllablesTextField: UITextField!
    
    // Properties to keep the value from the textFields
    var name: String = ""
    var category: String = ""
    var image: String = ""
    var hapticPath: String = ""
    var syllables: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting this ViewController to be the delegate for all the textFields
        nameTextField.delegate = self
        categoryTextField.delegate = self
        imageTextField.delegate = self
        hapticTextField.delegate = self
        syllablesTextField.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func saveNameButtonPressed(_ sender: UIButton) {
        print(name)
    }
    
    @IBAction func saveCategoryButtonPressed(_ sender: UIButton) {
        print(category)
    }
    
    @IBAction func saveImageButtonPressed(_ sender: UIButton) {
        print(image)
    }
    
    @IBAction func saveHapticButtonPressed(_ sender: UIButton) {
        print(hapticPath)
    }
    
    @IBAction func saveSyllablesButtonPressed(_ sender: UIButton) {
        print(syllables)
    }
    
    

    // MARK: - Action that will save the Flashcard item to CoreData Model
    
    @IBAction func saveFlashcardPressed(_ sender: UIBarButtonItem) {
    }
    
    // Will determine which texField is typing on and will assign the value to the proper property
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            name = nameTextField.text!
        case categoryTextField:
            category = categoryTextField.text!
        case imageTextField:
            image = imageTextField.text!
        case hapticTextField:
            hapticPath = hapticTextField.text!
        case syllablesTextField:
            syllables = Int(syllablesTextField.text!)!
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        categoryTextField.resignFirstResponder()
        imageTextField.resignFirstResponder()
        hapticTextField.resignFirstResponder()
        syllablesTextField.resignFirstResponder()
        return true
    }
    
}
