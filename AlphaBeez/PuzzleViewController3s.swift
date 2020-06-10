//
//  PuzzleViewController3s.swift
//  AlphaBeez
//
//  Created by Christian Skorobogatow on 22/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit
import CoreHaptics
import AVFoundation

class PuzzleViewController3s: UIViewController {
    
    
    
    //Image Outlets
    @IBOutlet weak var rightPuzzlePiece: UIImageView!
    @IBOutlet weak var upperLeftPuzzlePiece: UIImageView!
    @IBOutlet weak var bottomLeftPuzzlePiece: UIImageView!
    @IBOutlet weak var fullImagePuzzleThree: UIImageView!
    @IBOutlet weak var borderView: UIImageView!
    @IBOutlet weak var flashcardWordLabel: UILabel!
    @IBOutlet weak var rightPuzzlePieceButton: UIButton!
    @IBOutlet weak var upperLeftPuzzlePieceButton: UIButton!
    @IBOutlet weak var bottomLeftPuzzlePieceButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    // Images set programtically
    var starsImage: UIImageView!
    
    //Counters
    var currentAnimation = 0
    var syllableCounter = 1
    
    // The Flashcard that the user have picked from the collectionView
    var selectedFlashcard = Flashcard()
    
    // Back Button Image
    let backButton = UIImage(named: "back")
    
    // Configuration and name of the SF Symbols
    let configurator = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
    
    // Puzzle_3 Activity background image
    var puzzle3Background = UIImage()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Changing the native back button with our custom one
        let systemButton = UIImage(systemName: "arrow.left.circle", withConfiguration: configurator)
        self.navigationController?.navigationBar.backIndicatorImage = systemButton
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = systemButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        // Hiding the custom back button
        navigationItem.hidesBackButton = true
        
        // Giving a visual feedback to the info and the restart buttons
        infoButton.showsTouchWhenHighlighted = true
        restartButton.showsTouchWhenHighlighted = true
        
        // Set puzzle_3 activity background
        let puzzle3BackgroundImage = UIImageView(frame: UIScreen.main.bounds)
        puzzle3BackgroundImage.image = puzzle3Background
        puzzle3BackgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(puzzle3BackgroundImage, at: 0)
        
        // Creating the HapticEngine
        HapticEngine.shared.creteEngine()
        
        // Properties for centered blurred image of puzzle 1
        fullImagePuzzleThree.image = UIImage(named: selectedFlashcard.image!)
        fullImagePuzzleThree.alpha = 0.5
        
        // Image for right puzzle Piece
        rightPuzzlePiece.image = UIImage(named: selectedFlashcard.image!)
        let maskRight = UIImageView()
        maskRight.contentMode = .scaleAspectFit
        maskRight.image = UIImage(named: "puzzle-3pc-1")
        maskRight.frame = rightPuzzlePiece.bounds
        rightPuzzlePiece.mask = maskRight
        
        // Image for upper left puzzle Piece
        upperLeftPuzzlePiece.image = UIImage(named: selectedFlashcard.image!)
        let maskTopLeft = UIImageView()
        maskTopLeft.contentMode = .scaleAspectFit
        maskTopLeft.image = UIImage(named: "puzzle-3pc-2")
        maskTopLeft.frame = upperLeftPuzzlePiece.bounds
        upperLeftPuzzlePiece.mask = maskTopLeft
        
        // Image for bottom left puzzle Piece
        bottomLeftPuzzlePiece.image = UIImage(named: selectedFlashcard.image!)
        let maskBottomLeft = UIImageView()
        maskBottomLeft.contentMode = .scaleAspectFit
        maskBottomLeft.image = UIImage(named: "puzzle-3pc-3")
        maskBottomLeft.frame = bottomLeftPuzzlePiece.bounds
        bottomLeftPuzzlePiece.mask = maskBottomLeft
        
        //Stars hidden on top of the centered blurred image
        starsImage = UIImageView(image: UIImage(named: "star-puzzle-black"))
        starsImage.contentMode = UIView.ContentMode.scaleAspectFit
        starsImage.frame.size.width = fullImagePuzzleThree.frame.size.width * 1.5
        starsImage.frame.size.height = fullImagePuzzleThree.frame.size.height * 1.5
        starsImage.center = self.view.center
        starsImage.isHidden = true
        view.addSubview(starsImage)
        
        flashcardWordLabel.isHidden = true
        flashcardWordLabel.text = selectedFlashcard.name!.uppercased()
        flashcardWordLabel.font = FontKit.roundedFont(ofSize: 48, weight: .bold)
        
        borderView.layer.borderWidth = 15
        borderView.layer.cornerRadius = 10
        
        //      Gives restrart button custom green
        restartButton.tintColor = UIColor.greenElement
        
        if selectedFlashcard.category == "home" {
            borderView.layer.borderColor = UIColor.homeColor.cgColor
        } else if selectedFlashcard.category == "park" {
            borderView.layer.borderColor = UIColor.parkColor.cgColor
        } else if selectedFlashcard.category == "market" {
            borderView.layer.borderColor = UIColor.marketColor.cgColor
        }
        
    }
    
    @IBAction func tappedRightPuzzlePiece(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:  {
            
            switch self.currentAnimation {
            case 0:
                
                self.rightPuzzlePieceButton.isHidden = true
                
                // This merges two animations scale & move
                var concatinatedAnimation = CGAffineTransform.identity
                concatinatedAnimation = concatinatedAnimation.scaledBy(x: 2, y: 2)
                concatinatedAnimation = concatinatedAnimation.translatedBy(x: -132, y: 0)
                self.rightPuzzlePiece.transform = concatinatedAnimation
                
                //Calls animation + haptic sound based on condition
                if self.syllableCounter == 1 {
                    HapticEngine.shared.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s1")
                    self.syllableCounter += 1
                } else if self.syllableCounter == 2 {
                    HapticEngine.shared.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s2")
                    self.syllableCounter += 1
                } else {
                    HapticEngine.shared.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s3")
                    self.starsImage.isHidden = false
                    self.flashcardWordLabel.isHidden = false
                    self.starsImage.transform = CGAffineTransform(rotationAngle: .pi)
                }
                
            case 1:
                self.rightPuzzlePiece.transform = .identity
                
            default:
                break
            }
        }) { (finished) in
            print("Test")
            
        }
        
        currentAnimation += 1
        
        if currentAnimation > 1 {
            currentAnimation = 0
        }
    }
    
    @IBAction func tappedUpperLeftPuzzlePiece(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:  {
            
            switch self.currentAnimation {
            case 0:
                
                self.upperLeftPuzzlePieceButton.isHidden = true
                
                // This merges two animations scale & mrove
                var concatinatedAnimation = CGAffineTransform.identity
                concatinatedAnimation = concatinatedAnimation.scaledBy(x: 2, y: 2)
                concatinatedAnimation = concatinatedAnimation.translatedBy(x: 132, y: 28)
                self.upperLeftPuzzlePiece.transform = concatinatedAnimation
                
                //Calls animation + haptic sound based on condition
                if self.syllableCounter == 1 {
                    HapticEngine.shared.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s1")
                    self.syllableCounter += 1
                } else if self.syllableCounter == 2 {
                    HapticEngine.shared.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s2")
                    self.syllableCounter += 1
                } else {
                    HapticEngine.shared.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s3")
                    self.starsImage.isHidden = false
                    self.flashcardWordLabel.isHidden = false
                    self.starsImage.transform = CGAffineTransform(rotationAngle: .pi)
                }
                
            case 1:
                self.upperLeftPuzzlePiece.transform = .identity
                
            default:
                break
            }
        }) { (finished) in
            print("Test")
        }
        
        currentAnimation += 1
        
        if currentAnimation > 1 {
            currentAnimation = 0
        }
    }
    
    @IBAction func tappedBottomLeftPuzzlePiece(_ sender: UIButton) {
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:  {
            
            switch self.currentAnimation {
            case 0:
                
                self.bottomLeftPuzzlePieceButton.isHidden = true
                
                // This merges two animations scale & movea
                var concatinatedAnimation = CGAffineTransform.identity
                concatinatedAnimation = concatinatedAnimation.scaledBy(x: 2, y: 2)
                concatinatedAnimation = concatinatedAnimation.translatedBy(x: 131, y: -46.5)
                self.bottomLeftPuzzlePiece.transform = concatinatedAnimation
                
                
                if self.syllableCounter == 1 {
                    HapticEngine.shared.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s1")
                    self.syllableCounter += 1
                } else if self.syllableCounter == 2 {
                    HapticEngine.shared.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s2")
                    self.syllableCounter += 1
                } else {
                    HapticEngine.shared.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s3")
                    self.starsImage.isHidden = false
                    self.flashcardWordLabel.isHidden = false
                    self.starsImage.transform = CGAffineTransform(rotationAngle: .pi)
                }
                
            case 1:
                self.bottomLeftPuzzlePiece.transform = .identity
                
            default:
                break
            }
        }) { (finished) in
            print("Test")
            
        }
        
        currentAnimation += 1
        
        if currentAnimation > 1 {
            currentAnimation = 0
        }
    }
    
    
    @IBAction func restartTapepd(_ sender: UIButton) {
       
        rightPuzzlePiece.transform = .identity
        upperLeftPuzzlePiece.transform = .identity
        bottomLeftPuzzlePiece.transform = .identity
        starsImage.transform = .identity
        
        self.starsImage.isHidden = true
        self.flashcardWordLabel.isHidden = true
        self.upperLeftPuzzlePieceButton.isHidden = false
        self.bottomLeftPuzzlePieceButton.isHidden = false
        self.rightPuzzlePieceButton.isHidden = false
        
        syllableCounter = 1
        
    }
    
    
    // MARK: - Action for pressing the exit button
    @IBAction func exitButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Action for pressing the info button
    @IBAction func infoButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "puzzleAlert", sender: sender)
    }

    
}
