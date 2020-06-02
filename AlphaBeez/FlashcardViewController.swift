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
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var puzzleButton: UIButton!
    @IBOutlet weak var flashcardImage: UIImageView!
    @IBOutlet weak var flashcardStackView: UIStackView!
    @IBOutlet weak var innerViewForFlashcard: UIView!
    
    // This is he Flashcard that is transferred from CategoryViewController (the one that the user tapped)
    var selectedFlashcard = Flashcard()
    
    // Image that will replace the back button on the NavigationBar
    let backImage = UIImage(named: "world")
    
    // A haptic engine manages the connection to the haptic server and state
    var engine: CHHapticEngine!
    
    // Maintain a variable to check for Core Haptics compatibility on device.
    lazy var supportsHaptics: Bool = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.supportsHaptics
    }()
    
    // Flashcard background image
    var flashcardBackground = UIImage()

    // Array of find activity background images
    var findBackgroundImage : [UIImage] = [
        UIImage(named: "backgroundmixfind-home")!,
        UIImage(named: "backgroundmixfind-park")!,
        UIImage(named: "backgroundmixfind-market")!
        
    ]
    // Back Button Image
    let backButton = UIImage(named: "back")
        
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Changing the native back button with our custom one
        self.navigationController?.navigationBar.backIndicatorImage = backButton
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        // Set flashcard background
        let flashcardBackgroundImage = UIImageView(frame: UIScreen.main.bounds)
        flashcardBackgroundImage.image = flashcardBackground
        flashcardBackgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(flashcardBackgroundImage, at: 0)
        
        // Creating the HapticEngine and adding the observers;
        creteEngine()
        
        // Set the image and the label of the selected Flashcard
        flashcardImage.image = UIImage(named: selectedFlashcard.image!)
        hapticButton.setTitle(selectedFlashcard.name?.uppercased(), for: .normal)
        hapticButton.titleLabel?.font = FontKit.roundedFont(ofSize: 30, weight: .bold)
        // Giving rounder corners to the buttons
        hapticButton.layer.cornerRadius = 50
        puzzleButton.layer.cornerRadius = puzzleButton.frame.height * 0.40
        cameraButton.layer.cornerRadius = cameraButton.frame.height * 0.40
        
        // Properties for the border and corner of the Flashcards
        flashcardImage.layer.borderWidth = 5
        flashcardImage.contentMode = .scaleAspectFill
        
        puzzleButton.tintColor = .white
        cameraButton.tintColor = .white
        
        // Giving the inner view inside the flashcard a border and a color
        innerViewForFlashcard.layer.cornerRadius = 10
        innerViewForFlashcard.layer.borderWidth = 10
        if selectedFlashcard.category == "home" {
            innerViewForFlashcard.layer.borderColor = UIColor.homeColor.cgColor
        } else if selectedFlashcard.category == "park" {
            innerViewForFlashcard.layer.borderColor = UIColor.parkColor.cgColor
        } else if selectedFlashcard.category == "market" {
            innerViewForFlashcard.layer.borderColor = UIColor.marketColor.cgColor
        }
        
        
        if selectedFlashcard.category == "home" {
            puzzleButton.backgroundColor = .homeColor
            cameraButton.backgroundColor = .homeColor
            hapticButton.backgroundColor = .homeColor
            flashcardImage.layer.borderColor = UIColor.homeColor.cgColor
        } else if selectedFlashcard.category == "park" {
            puzzleButton.backgroundColor = .parkColor
            cameraButton.backgroundColor = .parkColor
            hapticButton.backgroundColor = .parkColor
            flashcardImage.layer.borderColor = UIColor.parkColor.cgColor
        } else {
            puzzleButton.backgroundColor = .marketColor
            cameraButton.backgroundColor = .marketColor
            hapticButton.backgroundColor = .marketColor
            flashcardImage.layer.borderColor = UIColor.marketColor.cgColor
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
            }
            
            do {
                try engine.start()
            } catch {
                print("Failed to restart the engine: \(error)")
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
            
            let destination = segue.destination as? FindActivityViewController
                
            if selectedFlashcard.category == "home" {
                
                destination?.findBackground = findBackgroundImage[0]
                
                      } else if selectedFlashcard.category == "park" {
                       destination?.findBackground = findBackgroundImage[1]
                
                        } else if selectedFlashcard.category == "market" {
                         destination?.findBackground = findBackgroundImage[2]
                        }
            
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

