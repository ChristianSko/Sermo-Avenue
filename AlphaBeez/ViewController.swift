//
//  ViewController.swift
//  AlphaBeez
//
//  Created by Ivan Tilev on 12/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit
import CoreData

// This is the main menu screen with the categories inside
class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var marketButton: UIButton!
    @IBOutlet weak var parkButton: UIButton!
    
    // Tapping into the singleton of AppDelegate to fetch the instance of the context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Array that will hold all the Flashcards that we got back from the FetchRequest
    var allFlashcards = [Flashcard]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFlashcards()
    }

    // Will transfer to the chosen category screen with the flashcards
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toCategory", sender: self)
    }
    
    //MARK: -  Will load all the items from our Database
    func loadFlashcards() {
        let request:NSFetchRequest<Flashcard> = Flashcard.fetchRequest()
        do {
           allFlashcards = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
}
