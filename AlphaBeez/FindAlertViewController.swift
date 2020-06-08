//
//  FindAlertViewController.swift
//  AlphaBeez
//
//  Created by Nadia Ruocco on 06/06/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

class FindAlertViewController: UIViewController {

    // Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstParagraph: UILabel!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Parent Zone!"
        
        firstParagraph.text = """
        Take this time to explore more characteristics and descriptive words that can be used to categorize the word on the flashcard. This search and find activity provides you and your child with the opportunity to communicate and create a narrative around the word you just learned together.
        
        Talk through why certain objects have the same characteristics and why they don’t and try to incorporate other words that you may have learned recently with your child.
        
        Encourage creativity and help him/her observe your environment by talking about what you discover together. Create stories with the elements and objects that you find during your hunt. Remember that every moment is a teachable moment and to raise curiosity in learning new words!
        """
        
        titleLabel.font = FontKit.roundedFont(ofSize: 28, weight: .bold)
        firstParagraph.font = FontKit.roundedFont(ofSize: 26, weight: .regular)
        
        self.scrollView.layer.borderWidth = 10
        self.scrollView.layer.borderColor = UIColor.green.cgColor
        self.scrollView.layer.cornerRadius = 10
        
       
    }

    
    // MARK: - Action for exit button
    @IBAction func exitButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
