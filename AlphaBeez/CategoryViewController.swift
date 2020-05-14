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

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Creating a six object from the Flashcard structure and this is the data that we gonna work with
    let dog = Flashcard(name: "dog", image: UIImage(named: "dog")!, hapticPath: "AHAP/Dog")
    let food = Flashcard(name: "Food", image: UIImage(named: "food")!, hapticPath: "AHAP/Food")
    let juice = Flashcard(name: "Juice", image:  UIImage(named: "juice")!, hapticPath: "AHAP/Juice")
    let read = Flashcard(name: "Read", image: UIImage(named: "read")!, hapticPath:  "AHAP/Read")
    let real = Flashcard(name: "Real", image: UIImage(named: "real")!, hapticPath: "AHAP/Real")
    let talk = Flashcard(name: "Talk", image: UIImage(named: "talk")!, hapticPath: "AHAP/Talk")
    
    // Initialize an empty array and will put all the above objects inside, when the viewDidLoad happends
    var allFlashcards = [Flashcard]()
    
    // CollectionView Outlets, so I can add the custom FlowLayout
    @IBOutlet weak var collectionView: UICollectionView!
    
    // CustomFlowLayOut that will determine the
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Defining the custom layout and then adding it to the collectionView
        layout.itemSize = CGSize(width: 250, height: 250)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        // Adding the created Flashcards objects to the array of Flashcards
        allFlashcards.append(dog)
        allFlashcards.append(food)
        allFlashcards.append(juice)
        allFlashcards.append(read)
        allFlashcards.append(real)
        allFlashcards.append(talk)
        
    }
    // MARK: - Required methods for the UICollectionViewDataSource Protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allFlashcards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        let flashcard = allFlashcards[indexPath.row]
        cell.imageView.image = flashcard.image
        return cell
    }
    
    // MARK: - PrepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FlashcardViewController,
            let index = collectionView.indexPathsForSelectedItems?.first {
            destination.selectedFlashcard = allFlashcards[index.row]
        }
    }

}
