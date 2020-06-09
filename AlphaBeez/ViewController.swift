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
    let backButton = UIImage(named: "back")
    
    // Configuration and name of the SF Symbols
    let configurator = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
    let exitImage = UIImage(systemName: "xmark.circle")!
    
    // Array of category backgrounds
    var backgroundImage : [UIImage] = [
        UIImage(named: "background-home")!,
        UIImage(named: "background-market")!,
        UIImage(named: "background-park")!
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Changing the native back button with our custom one
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // Changing the native back button with our custom one
        let systemButton = UIImage(systemName: "arrow.left.circle", withConfiguration: configurator)
        self.navigationController?.navigationBar.backIndicatorImage = systemButton
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = systemButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load All Flashcards
        let request:NSFetchRequest<Flashcard> = Flashcard.fetchRequest()
        do {
            allFlashcards = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        // Will hide the navigationController and leave only the back button!
        navigationController!.hideNavigationItemBackground()
        
        
        //        set Menù background image
        let backgroundMenuImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundMenuImage.image = UIImage(named: "background-menu")
        backgroundMenuImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundMenuImage, at: 0)
        
    }
    
    // MARK: - PrepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let button = sender as? UIButton, let controller = segue.destination as? CategoryViewController,
            segue.identifier == "toCategory" {
//            var chosenCategory = [Flashcard]()
            
            switch button {
            case homeButton:
//                allFlashcards = getFlashcardsForCategory(category: "home")
                controller.categoryBackground = backgroundImage[0]
                controller.allFlashcards = getFlashcardsForCategory(category: "home")
            case marketButton:
//                allFlashcards = getFlashcardsForCategory(category: "market")
                controller.categoryBackground = backgroundImage[1]
                controller.allFlashcards = getFlashcardsForCategory(category: "market")
            case parkButton:
//                allFlashcards = getFlashcardsForCategory(category: "park")
                controller.categoryBackground = backgroundImage[2]
                controller.allFlashcards = getFlashcardsForCategory(category: "park")
            default:
                break
            }
        }
    }
    
    // Will transfer to the chosen category screen with the flashcards
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toCategory", sender: sender)
        
    }
    
    //MARK: -  Will load all the items from our Database
//    func loadFlashcards() {
//        let request:NSFetchRequest<Flashcard> = Flashcard.fetchRequest()
//        do {
//            allFlashcards = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//    }
    
    func getFlashcardsForCategory(category: String) -> [Flashcard] {
        var array = [Flashcard]()
        for flashcard in allFlashcards {
            if flashcard.category == category {
                array.append(flashcard)
            }
        }
        return array
    }
    
    //    This calls the OnboardingViewController
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if Core.shared.isNewUser() {
            
            let vc = storyboard?.instantiateViewController(identifier: "onboarding") as! OnBoardingViewController
            
            
            //This makes sure the modal on-boarding cannot be swipe down
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
        }
    }

}
    
// This class is to make sure On-Boarding only appears once
class Core {
    
    static let shared = Core()
    
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}

