//
//  SaveToCoreDataViewController.swift
//  AlphaBeez
//
//  Created by Extremely International Team on 23/05/2020.
//  Copyright © 2020 Extremely International Team. All rights reserved.
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
    
    // Tapping into the singleton of AppDelegate to fetch the instance of the context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        // Creating a new instance of the Flashcard Entity inside xcdatamodeld
        let flashcard = Flashcard(context: context)
        // Assign the properties to the results form the input
        flashcard.name = name
        flashcard.category = category
        flashcard.image = image
        flashcard.hapticPath = hapticPath
        flashcard.syllables = Int16(syllables)
        
        // Saving the Flashcard to our data base
        do {
            try context.save()
            print("Saving flashcard to the Database!")
        } catch {
            print("Error saving context \(error)")
        }
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
