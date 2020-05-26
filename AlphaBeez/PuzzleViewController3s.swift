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
    
    // Invisibles buttons set programtically
    var upperLeftPuzzlePieceButton: UIButton!
    var bottomLeftPuzzlePieceButton: UIButton!
    var rightPuzzlePieceButton: UIButton!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating the HapticEngine
        creteEngine()
        
        // Properties for centered blurred image of puzzle 1
        fullImagePuzzleThree.image = UIImage(named: selectedFlashcard.image!)
        fullImagePuzzleThree.alpha = 0.2
        fullImagePuzzleThree.layer.borderWidth = 1
        fullImagePuzzleThree.layer.borderColor =  UIColor.blue.cgColor
        
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
        
        //Invisible Buttton behind the right puzzle Piece that triggers animation
        rightPuzzlePieceButton = UIButton()
        rightPuzzlePieceButton.frame.size.width = rightPuzzlePiece.frame.size.width
        rightPuzzlePieceButton.frame.size.height = rightPuzzlePiece.frame.size.height
        rightPuzzlePieceButton.center = rightPuzzlePiece.center
        //Adding Border for testing purpose, uncomment for seing size
        //        rightPuzzlePieceButton.layer.borderWidth = 3
        //        rightPuzzlePieceButton.layer.borderColor = UIColor.blue.cgColor
        rightPuzzlePieceButton.addTarget(self, action: #selector(self.tappedRightPuzzlePiece(sender:)), for: .touchUpInside)
        view.addSubview(rightPuzzlePieceButton)
        
        //Invisible Buttton behind the upper left puzzle Piece that triggers animation
        upperLeftPuzzlePieceButton = UIButton()
        upperLeftPuzzlePieceButton.frame.size.width = upperLeftPuzzlePiece.frame.size.width
        upperLeftPuzzlePieceButton.frame.size.height = upperLeftPuzzlePiece.frame.size.height
        upperLeftPuzzlePieceButton.center = upperLeftPuzzlePiece.center
        //Adding Border for testing purpose, uncomment for seing size
        //        upperLeftPuzzlePieceButton.layer.borderWidth = 3
        //        upperLeftPuzzlePieceButton.layer.borderColor = UIColor.blue.cgColor
        upperLeftPuzzlePieceButton.addTarget(self, action: #selector(self.tappedUpperLeftPuzzlePiece(sender:)), for: .touchUpInside)
        view.addSubview(upperLeftPuzzlePieceButton)
        
        //Invisible Buttton behind the right puzzle Piece that triggers animation
        bottomLeftPuzzlePieceButton = UIButton()
        bottomLeftPuzzlePieceButton.frame.size.width = bottomLeftPuzzlePiece.frame.size.width
        bottomLeftPuzzlePieceButton.frame.size.height = bottomLeftPuzzlePiece.frame.size.height
        bottomLeftPuzzlePieceButton.center = bottomLeftPuzzlePiece.center
        //Adding Border for testing purpose
        //        bottomLeftPuzzlePieceButton.layer.borderWidth = 3
        //        bottomLeftPuzzlePieceButton.layer.borderColor = UIColor.blue.cgColor
        bottomLeftPuzzlePieceButton.addTarget(self, action: #selector(self.tappedBotttomLeftPuzzlePiece(sender:)), for: .touchUpInside)
        view.addSubview(bottomLeftPuzzlePieceButton)
        
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
    
    // Animation function for right puzzle piece get triggered en tapping button
    @objc func tappedRightPuzzlePiece(sender: UIButton) {
        
        sender.isHidden = true
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:  {
            
            switch self.currentAnimation {
            case 0:
                
                // This merges two animations scale & move
                var concatinatedAnimation = CGAffineTransform.identity
                concatinatedAnimation = concatinatedAnimation.scaledBy(x: 2, y: 2)
                concatinatedAnimation = concatinatedAnimation.translatedBy(x: -132, y: -6)
                self.rightPuzzlePiece.transform = concatinatedAnimation
                
//                selectedFlashcard.
                
            case 1:
                self.rightPuzzlePiece.transform = .identity
                
            default:
                break
            }
        }) { (finished) in
            print("Test")
            
            //                        Uncomment for testing animation several times in arow
            sender.isHidden = false
            
        }
        
        currentAnimation += 1
        
        if currentAnimation > 1 {
            currentAnimation = 0
        }
    }
    
    // Animation function for upper left puzzle piece get triggered en tapping button
    @objc func tappedUpperLeftPuzzlePiece(sender: UIButton) {
        
        sender.isHidden = true
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:  {
            
            switch self.currentAnimation {
            case 0:
                // This merges two animations scale & move
                var concatinatedAnimation = CGAffineTransform.identity
                concatinatedAnimation = concatinatedAnimation.scaledBy(x: 2, y: 2)
                concatinatedAnimation = concatinatedAnimation.translatedBy(x: 132, y: 31)
                self.upperLeftPuzzlePiece.transform = concatinatedAnimation
                
            case 1:
                self.upperLeftPuzzlePiece.transform = .identity
                
            default:
                break
            }
        }) { (finished) in
            print("Test")
            
            //                        Uncomment for testing animation several times in arow
            sender.isHidden = false
            
        }
        
        currentAnimation += 1
        
        if currentAnimation > 1 {
            currentAnimation = 0
        }
    }
    
    // Animation function for bottom left puzzle piece get triggered en tapping button
    @objc func tappedBotttomLeftPuzzlePiece(sender: UIButton) {
        
        sender.isHidden = true
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:  {
            
            switch self.currentAnimation {
            case 0:
                // This merges two animations scale & movea
                var concatinatedAnimation = CGAffineTransform.identity
                concatinatedAnimation = concatinatedAnimation.scaledBy(x: 2, y: 2)
                concatinatedAnimation = concatinatedAnimation.translatedBy(x: 131, y: -43)
                self.bottomLeftPuzzlePiece.transform = concatinatedAnimation
                
                if self.syllableCounter == 1 {
                    self.playHapticsFile(name: self.selectedFlashcard.name! + "-s1")
                    self.syllableCounter += 1
                } else if self.syllableCounter == 2 {
                    self.playHapticsFile(name: self.selectedFlashcard.name! + "-s2")
                    self.syllableCounter += 1
                } else {
                    self.playHapticsFile(name: self.selectedFlashcard.name! + "-s3")
                }
                
            case 1:
                self.bottomLeftPuzzlePiece.transform = .identity
                
            default:
                break
            }
        }) { (finished) in
            print("Test")
            
            //                        Uncomment for testing animation several times in arow
            sender.isHidden = false
            
        }
        
        currentAnimation += 1
        
        if currentAnimation > 1 {
            currentAnimation = 0
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
