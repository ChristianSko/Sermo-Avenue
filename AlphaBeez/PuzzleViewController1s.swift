//
//  PuzzleViewController1s.swift
//  AlphaBeez
//
//  Created by Christian Skorobogatow on 22/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit
import CoreHaptics
import AVFoundation

class PuzzleViewController1s: UIViewController {
    
    
    var oneSyllablePuzzleButton: UIButton!
    var currentAnimation = 0
    var selectedFlashcard = Flashcard()
    
    @IBOutlet weak var fullImagePuzzleOne: UIImageView!
    @IBOutlet weak var borderView: UIImageView!
    @IBOutlet weak var flashcardWordLabel: UILabel!
    @IBOutlet weak var oneSyllablePuzzle1: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    
    
    var starsImage: UIImageView!
    
    // Back Button Image
    let backButton = UIImage(named: "back")
    
    // Puzzle_1 Activity background image
    var puzzle1Background = UIImage()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Changing the native back button with our custom one
        self.navigationController?.navigationBar.backIndicatorImage = backButton
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        // Hiding the custom back button
        navigationItem.hidesBackButton = true
        
        // Set puzzle_1 activity background
        let puzzle1BackgroundImage = UIImageView(frame: UIScreen.main.bounds)
        puzzle1BackgroundImage.image = puzzle1Background
        puzzle1BackgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(puzzle1BackgroundImage, at: 0)
        
        // Creating the HapticEngine
        HapticEngine.shared.creteEngine()
        
        // Properties for centered blurred image of puzzle 1
        fullImagePuzzleOne.image = UIImage(named: selectedFlashcard.image!)
        fullImagePuzzleOne.alpha = 0.5
        
        //Stars hidden on top of the centered blurred image
        starsImage = UIImageView(image: UIImage(named: "star-puzzle-black"))
        starsImage.contentMode = UIView.ContentMode.scaleAspectFit
        starsImage.frame.size.width = fullImagePuzzleOne.frame.size.width * 1.5
        starsImage.frame.size.height = fullImagePuzzleOne.frame.size.height * 1.5
        starsImage.center = self.view.center
        starsImage.isHidden = true
        view.addSubview(starsImage)
        
        //Sets image for the puzzle piece
        oneSyllablePuzzle1.setImage(UIImage(named: selectedFlashcard.image!), for: .normal)
        
        // Hides label to make because we want it to appear after completing the puzzle
        flashcardWordLabel.isHidden = true
        flashcardWordLabel.text = selectedFlashcard.name!.uppercased()
        flashcardWordLabel.font = FontKit.roundedFont(ofSize: 48, weight: .bold)
        
        borderView.layer.borderWidth = 12
        borderView.layer.cornerRadius = 10
        
        if selectedFlashcard.category == "home" {
            borderView.layer.borderColor = UIColor.homeColor.cgColor
        } else if selectedFlashcard.category == "park" {
            borderView.layer.borderColor = UIColor.parkColor.cgColor
        } else if selectedFlashcard.category == "market" {
            borderView.layer.borderColor = UIColor.marketColor.cgColor
        }
        
        
    }
    
    @IBAction func oneSyllablePuzzleTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:  {
            
            switch self.currentAnimation {
            case 0:
                
                
                // This merges two animations scale & move
                var concatinatedAnimation = CGAffineTransform.identity
                concatinatedAnimation = concatinatedAnimation.scaledBy(x: 2, y: 2)
                concatinatedAnimation = concatinatedAnimation.translatedBy(x: -131.5, y: 0)
                
                //Calls animation + haptic sound
                self.oneSyllablePuzzle1.transform = concatinatedAnimation
                HapticEngine.shared.playHapticsFile(name: self.selectedFlashcard.hapticPath!)
                
                self.starsImage.isHidden = false
                self.flashcardWordLabel.isHidden = false
                self.starsImage.transform = CGAffineTransform(rotationAngle: .pi)
                
                
            // For Testing and repeating, only possible when sender isnt hidden
            case 1:
                //                self.oneSyllablePuzzle1.transform = .identity
                print("Hi")
                
            default:
                break
            }
        }) { (finished) in
            print("Test")
            
        }
    }
    
    // MARK: - Action for pressing the exit button
    @IBAction func exitButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func restartTapped(_ sender: UIButton) {
        self.starsImage.isHidden = true
        self.flashcardWordLabel.isHidden = true
        oneSyllablePuzzle1.transform = .identity
        starsImage.transform = .identity
        
    }
    
    
    // MARK: - Action for pressing the info button
    @IBAction func infoButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "puzzleAlert", sender: sender)
    }
    
    
    
    
}
