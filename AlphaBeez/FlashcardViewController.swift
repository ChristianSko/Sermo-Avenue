//
//  FlashcardViewController.swift
//  AlphaBeez
//
//  Created by Ivan Tilev on 13/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit
import CoreHaptics
import AVFoundation

class FlashcardViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    // Outlets
    @IBOutlet weak var hapticButton: UIButton!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var puzzleButton: UIButton!
    
    // This is he Flashcard that is transferred from CategoryViewController (the one that the user tapped)
    var selectedFlashcard = Flashcard()
    
    // Image that will replace the back button on the NavigationBar
    let backImage = UIImage(named: "world")
    
    // A haptic engine manages the connection to the haptic server.
    var engine: CHHapticEngine!
    
    // Maintain a variable to check for Core Haptics compatibility on device.
    lazy var supportsHaptics: Bool = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.supportsHaptics
    }()
    
    // Back Button Image
    let backButton = UIImage(named: "back")
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Changing the native back button with our custom one
        self.navigationController?.navigationBar.backIndicatorImage = backButton
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        // Creating the HapticEngine
        creteEngine()

        // Set the image and the label of the selected Flashcard
        hapticButton.setImage(UIImage(named: selectedFlashcard.image!), for: .normal)
        cardNameLabel.text = selectedFlashcard.name
        cardNameLabel.font = FontKit.roundedFont(ofSize: 58, weight: .regular)
 //        cardNameLabel.text = cardNameLabel.text?.uppercased()
        
        if selectedFlashcard.category == "home" {
            puzzleButton.tintColor = .purple
            cameraButton.tintColor = .purple
        } else if selectedFlashcard.category == "park" {
             puzzleButton.tintColor = .red
             cameraButton.tintColor = .red
        } else {
            puzzleButton.tintColor = .orange
            cameraButton.tintColor = .orange
        }
    }
    
    // MARK: - CreteEngine for Haptics
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
    
    // MARK: - PlayAHAP
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
    
    //MARK: HapticButtonPressed:
    // Will play the haptic, based on the selectedFlashcard.hapticPath passed inside the function
    @IBAction func hapticButtonPressed(_ sender: UIButton) {
        // Will play haptics of the selected flashcard
        playHapticsFile(name: selectedFlashcard.hapticPath!)
    }

    
    // Prepare for the segue and passing the selected Flashcard to one of the three puzzles
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "camera" {
            
            let vc = segue.destination as! FindActivityViewController
            vc.selectedFlashcard = selectedFlashcard
        } else {
            
            let syllables: Int = Int(selectedFlashcard.syllables)
            print(syllables)
            if syllables == 1 {
                let vcOne = segue.destination as! PuzzleViewController1s
                vcOne.selectedFlashcard = selectedFlashcard
            } else if syllables == 2 {
                let vcTwo = segue.destination as! PuzzleViewController2s
                vcTwo.selectedFlashcard = selectedFlashcard
            } else if syllables == 3 {
                let vcThree = segue.destination as! PuzzleViewController3s
                vcThree.selectedFlashcard = selectedFlashcard
            }
        }
    }


    @IBAction func puzzleTouched(_ sender: UIButton) {
// sending to PuzzleViewController1s, PuzzleViewController2s or PuzzleViewController3s based on puzzleSyllableType
        let syllables: Int = Int(selectedFlashcard.syllables)
        
            print(syllables)
            if syllables == 1 {
                performSegue(withIdentifier: "puzzleOne", sender: self)
            } else if syllables == 2 {
                performSegue(withIdentifier: "puzzleTwo", sender: self)
            } else if syllables == 3 {
                performSegue(withIdentifier: "puzzleThree", sender: self)
            }
    }
    
    @IBAction func cameraTouched(_ sender: UIButton) {
        performSegue(withIdentifier: "camera", sender: self)
    }
    
}
