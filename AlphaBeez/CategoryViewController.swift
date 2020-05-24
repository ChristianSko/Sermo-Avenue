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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Defining the custom layout and then adding it to the collectionView
        layout.itemSize = CGSize(width: 250, height: 250)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
    }
    // MARK: - Required methods for the UICollectionViewDataSource Protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allFlashcards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        let flashcard = allFlashcards[indexPath.row]
        cell.imageView.image = UIImage(named: flashcard.image!)
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
