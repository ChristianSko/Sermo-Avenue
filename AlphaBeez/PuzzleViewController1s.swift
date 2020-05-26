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
    @IBOutlet weak var oneSyllablePuzzle: UIImageView!
    
    
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
        fullImagePuzzleOne.image = UIImage(named: selectedFlashcard.image!)
        fullImagePuzzleOne.alpha = 0.2
        fullImagePuzzleOne.layer.borderWidth = 1
        fullImagePuzzleOne.layer.borderColor =  UIColor.blue.cgColor
        
        // Properties of puzzle Piece
        oneSyllablePuzzle.image = UIImage(named: selectedFlashcard.image!)
        
        //Invisible Buttton behind the Puzzle Piece that triggers animation set programtically
        oneSyllablePuzzleButton = UIButton()
        oneSyllablePuzzleButton.frame.size.width = oneSyllablePuzzle.frame.size.width
        oneSyllablePuzzleButton.frame.size.height = oneSyllablePuzzle.frame.size.height
        oneSyllablePuzzleButton.center = oneSyllablePuzzle.center
        oneSyllablePuzzleButton.addTarget(self, action: #selector(self.oneSyllablePuzzleTapped(sender:)), for: .touchUpInside)
        view.addSubview(oneSyllablePuzzleButton)
        
    }
    
    // CreateEngine for Haptics
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
    
    //  Animation function for right puzzle piece get triggered en tapping button
    @objc func oneSyllablePuzzleTapped(sender: UIButton) {
        sender.isHidden = true
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:  {
            
            switch self.currentAnimation {
            case 0:
                // This merges two animations scale & move
                var concatinatedAnimation = CGAffineTransform.identity
                concatinatedAnimation = concatinatedAnimation.scaledBy(x: 2, y: 2)
                concatinatedAnimation = concatinatedAnimation.translatedBy(x: -131, y: -6)
                
                //Calls animation + haptic sound
                self.oneSyllablePuzzle.transform = concatinatedAnimation
                self.playHapticsFile(name: self.selectedFlashcard.hapticPath!)
                
            // For Testing and repeating, only possible when sender isnt hidden
            case 1:
                self.oneSyllablePuzzle.transform = .identity
                
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
