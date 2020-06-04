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
    
    
    // Images set programtically
    var starsImage: UIImageView!
    
    //Counters
    var currentAnimation = 0
    var syllableCounter = 1
    
    // The Flashcard that the user have picked from the collectionView
    var selectedFlashcard = Flashcard()
    
    // A haptic engine manages the connection to the haptic server.
    var engine: CHHapticEngine!
    
    // Maintain a variable to check for Core Haptics compatibility on device.
    lazy var supportsHaptics: Bool = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.supportsHaptics
    }()
    
    //    To handle the playback
    var audioPlayer : AVAudioPlayer?
    
    // Back Button Image
    let backButton = UIImage(named: "back")
    
    // Puzzle_3 Activity background image
    var puzzle3Background = UIImage()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Changing the native back button with our custom one
        self.navigationController?.navigationBar.backIndicatorImage = backButton
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        // Hiding the custom back button
        navigationItem.hidesBackButton = true
        
        // Set puzzle_3 activity background
        let puzzle3BackgroundImage = UIImageView(frame: UIScreen.main.bounds)
        puzzle3BackgroundImage.image = puzzle3Background
        puzzle3BackgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(puzzle3BackgroundImage, at: 0)
        
        // Creating the HapticEngine
        creteEngine()
        
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
        
        if selectedFlashcard.category == "home" {
            borderView.layer.borderColor = UIColor.homeColor.cgColor
        } else if selectedFlashcard.category == "park" {
            borderView.layer.borderColor = UIColor.parkColor.cgColor
        } else if selectedFlashcard.category == "market" {
            borderView.layer.borderColor = UIColor.marketColor.cgColor
        }
        
    }
    
    func creteEngine() {
        if !supportsHaptics {
            return
        } else {
            // Create and configure a haptic engine.
            do {
                engine = try CHHapticEngine()
            } catch let error {
                print("Engine Creation Error: \(error)")
            }
            
            if engine == nil {
                print("Failed to create engine!")
            }
            
            // The stopped handler alerts you of engine stoppage due to external causes.
            engine.stoppedHandler = { reason in
                print("The engine stopped for reason: \(reason.rawValue)")
                switch reason {
                case .audioSessionInterrupt: print("Audio session interrupt")
                case .applicationSuspended: print("Application suspended")
                case .idleTimeout: print("Idle timeout")
                case .systemError: print("System error")
                case .notifyWhenFinished: print("Playback finished")
                @unknown default:
                    print("Unknown error")
                }
            }
            
            // The reset handler provides an opportunity for your app to restart the engine in case of failure.
            engine.resetHandler = {
                // Try restarting the engine.
                print("The engine reset --> Restarting now!")
                do {
                    try self.engine.start()
                } catch {
                    print("Failed to restart the engine: \(error)")
                }
            }
        }
    }
    
    func playHapticsFile(name filename: String) {
        // If the device doesn't support Core Haptics, abort.
        if !supportsHaptics {
            return
        }
        
        // Express the path to the AHAP file before attempting to load it.
        guard let path = Bundle.main.path(forResource: filename, ofType: "ahap") else {
            return
        }
        
        do {
            // Start the engine in case it's idle.
            try engine.start()
            
            // Tell the engine to play a pattern.
            try engine.playPattern(from: URL(fileURLWithPath: path))
            
        } catch { // Engine startup errors
            print("An error occured playing \(filename): \(error).")
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
                    self.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s1")
                    self.syllableCounter += 1
                } else if self.syllableCounter == 2 {
                    self.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s2")
                    self.syllableCounter += 1
                } else {
                    self.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s3")
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
                    self.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s1")
                    self.syllableCounter += 1
                } else if self.syllableCounter == 2 {
                    self.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s2")
                    self.syllableCounter += 1
                } else {
                    self.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s3")
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
                    self.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s1")
                    self.syllableCounter += 1
                } else if self.syllableCounter == 2 {
                    self.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s2")
                    self.syllableCounter += 1
                } else {
                    self.playHapticsFile(name: self.selectedFlashcard.hapticPath! + "-s3")
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
    
    // MARK: - Action for pressing the exit button
    @IBAction func exitButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
}
