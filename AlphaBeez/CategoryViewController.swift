//
//  CategoryViewController.swift
//  AlphaBeez
//
//  Created by Ivan Tilev on 12/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//
// This is the CategoryViewController that will show all the flashcard for it
import UIKit

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let allImages: [UIImage] = [
        UIImage(named: "dog")!,
        UIImage(named: "dog")!,
        UIImage(named: "food")!,
        UIImage(named: "juice")!,
        UIImage(named: "read")!,
        UIImage(named: "real")!,
        UIImage(named: "talk")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Required methods for the UICollectionViewDataSourcer
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        let image = allImages[indexPath.row]
        cell.imageView.image = image
        return cell
    }

}
