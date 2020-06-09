//
//  Puzzle1AlertViewController.swift
//  AlphaBeez
//
//  Created by Nadia Ruocco on 06/06/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

class PuzzleAlertViewController: UIViewController {

    // Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstParagraph: UILabel!
    
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Parent Zone!"
        
        firstParagraph.text = """
        The puzzle activity here can be used to help break up and slow down a word for better comprehension.
        
        Make sure your child is holding the phone to ensure that they feel the vibrotactile representation of the word.
        
        Remember that repition is an important part of learning a new word. It never hurts to revisit a word for extra verification!
        """
        
        titleLabel.font = FontKit.roundedFont(ofSize: 28, weight: .bold)
        firstParagraph.font = FontKit.roundedFont(ofSize: 26, weight: .regular)

        
        self.scrollView.layer.borderWidth = 10
        self.scrollView.layer.borderColor = UIColor.greenElement.cgColor
        self.scrollView.layer.cornerRadius = 10
    }
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
