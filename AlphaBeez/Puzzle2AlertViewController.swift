//
//  Puzzle2AlertViewController.swift
//  AlphaBeez
//
//  Created by Nadia Ruocco on 06/06/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

class Puzzle2AlertViewController: UIViewController {

    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstParagraph: UILabel!
    @IBOutlet weak var secondParagraph: UILabel!
    @IBOutlet weak var thirdParagraph: UILabel!
    
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Parent Zone!"
        
        firstParagraph.text = """
        The puzzle activity here can be used to help
        break up and slow down a word for better
        comprehension 
        """
        
        secondParagraph.text = """
        Make sure your child is holding the phone to
        ensure that they feel the vibrotactile
        representation of the word.
        """
        
        thirdParagraph.text = """
        Remember that repition is an important part of
        learning a new word. It never hurts to revisit a
        word for extra verification!
        """
        
        titleLabel.font = FontKit.roundedFont(ofSize: 22, weight: .bold)
        firstParagraph.font = FontKit.roundedFont(ofSize: 22, weight: .regular)
        secondParagraph.font = FontKit.roundedFont(ofSize: 22, weight: .regular)
        thirdParagraph.font = FontKit.roundedFont(ofSize: 22, weight: .regular)

       self.scrollView.layer.borderWidth = 10
       self.scrollView.layer.borderColor = UIColor.green.cgColor
    }
    
    
    // MARK: - Action for exit button

    @IBAction func exitButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
}
