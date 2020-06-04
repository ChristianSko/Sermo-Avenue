//
//  CategoryViewController.swift
//  AlphaBeez
//
//  Created by Ivan Tilev on 12/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//
// This is the CategoryViewController that will show all the flashcard for it
import UIKit
import CoreHaptics
import Foundation
import CoreData

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Initialize an empty array and will hold the chosen category arrays
    var allFlashcards = [Flashcard]()
    
    // CollectionView Outlets, so I can add the custom FlowLayout
    @IBOutlet weak var collectionView: UICollectionView!
    
    // CustomFlowLayOut that will determine the
    let layout = UICollectionViewFlowLayout()
    
    // Category background image
    var categoryBackground = UIImage()
    
    // Array of flashcard backgrounds
    var flashcardBackgroundImage : [UIImage] = [
        UIImage(named: "backgroundmixflashcard-home")!,
        UIImage(named: "backgroundmixflashcard-park")!,
        UIImage(named: "backgroundmixflashcard-market")!
    ]
    
    // Back Button Image
    let backButton = UIImage(named: "back")
    
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
        
        // Defining the custom layout and then adding it to the collectionView
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        
        // Set category background
        let categoryBackgroundImage = UIImageView(frame: UIScreen.main.bounds)
        categoryBackgroundImage.image = categoryBackground
        categoryBackgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(categoryBackgroundImage, at: 0)
        
    }
    // MARK: - Required methods for the UICollectionViewDataSource Protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allFlashcards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        let flashcard = allFlashcards[indexPath.row]
        
        if flashcard.category == "home" {
            cell.layer.borderColor = UIColor.homeColor.cgColor
        } else if flashcard.category == "park" {
            cell.layer.borderColor = UIColor.parkColor.cgColor
        } else if flashcard.category == "market" {
            cell.layer.borderColor = UIColor.marketColor.cgColor
        }
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 10
        cell.imageView.image = UIImage(named: flashcard.image!)
        return cell
    }
    
    // MARK: - PrepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FlashcardViewController,
            let index = collectionView.indexPathsForSelectedItems?.first {
         destination.selectedFlashcard = allFlashcards[index.row]
            
            if destination.selectedFlashcard.category == "home" {
            destination.flashcardBackground = flashcardBackgroundImage[0]
             } else if destination.selectedFlashcard.category == "park" {
              destination.flashcardBackground = flashcardBackgroundImage[1]
               } else if destination.selectedFlashcard.category == "market" {
                destination.flashcardBackground = flashcardBackgroundImage[2]
               }
        }
    }
}
