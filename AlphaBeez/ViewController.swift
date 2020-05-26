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
    
    // Back Button Image
    let backButton = UIImage(named: "world")
    
    var backgroundImage : [UIImage] = [
    UIImage(named: "background-home")!,
    UIImage(named: "background-market")!,
    UIImage(named: "background-park")!
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Changing the native back button with our custom one
        self.navigationController?.navigationBar.backIndicatorImage = backButton
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFlashcards()
        
        // Will hide the navigationController and leave only the back button!
        navigationController!.hideNavigationItemBackground()
        
//        set Menù background image
        let backgroundMenuImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundMenuImage.image = UIImage(named: "background-menu")
        backgroundMenuImage.contentMode = UIView.ContentMode.scaleAspectFit
        self.view.insertSubview(backgroundMenuImage, at: 0)

    }
    
    // MARK: - PrepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let button = sender as? UIButton, let controller = segue.destination as? CategoryViewController,
            segue.identifier == "toCategory" {
            var chosenCategory = [Flashcard]()
            
            
            switch button {
            case homeButton:
                chosenCategory = getFlashcardsForCategory(category: "home")
                controller.categoryBackground = backgroundImage[0]
            case marketButton:
                chosenCategory = getFlashcardsForCategory(category: "market")
                controller.categoryBackground = backgroundImage[1]
            case parkButton:
                chosenCategory = getFlashcardsForCategory(category: "park")
                controller.categoryBackground = backgroundImage[2]
            default:
                break
            }
            controller.allFlashcards = chosenCategory
        }
    }

    // Will transfer to the chosen category screen with the flashcards
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toCategory", sender: sender)
        
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
    
    func getFlashcardsForCategory(category: String) -> [Flashcard] {
        var array = [Flashcard]()
        for flashcard in allFlashcards {
            if flashcard.category == category {
                array.append(flashcard)
            }
        }
        return array
    }

    }
    

