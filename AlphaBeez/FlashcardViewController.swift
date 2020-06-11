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
    let backImage = UIImage(named: "back")
    
    let systemButton = UIImage(systemName: "arrow.left.circle")!
    
    // Flashcard background image
    var flashcardBackground = UIImage()

    // Array of find activity background images
    var findBackgroundImage : [UIImage] = [
        UIImage(named: "backgroundmixfind-home")!,
        UIImage(named: "backgroundmixfind-park")!,
        UIImage(named: "backgroundmixfind-market")!
    ]
    
    // Array of find activity background images
      var puzzleBackgroundImage : [UIImage] = [
          UIImage(named: "backgroundpuzzle-home")!,
          UIImage(named: "backgroundpuzzle-park")!,
          UIImage(named: "backgroundpuzzle-market")!
      ]
    
    
    // Back Button Image
    let backButton = UIImage(named: "back")
    
    // Configuration and name of the SF Symbols
    let configurator = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Changing the native back button with our custom one
        let systemButton = UIImage(systemName: "arrow.left.circle", withConfiguration: configurator)?.withTintColor(UIColor.blackElement, renderingMode: .alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage = systemButton
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = systemButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        // Set flashcard background
        let flashcardBackgroundImage = UIImageView(frame: UIScreen.main.bounds)
        flashcardBackgroundImage.image = flashcardBackground
        flashcardBackgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(flashcardBackgroundImage, at: 0)
        
        // Creating the HapticEngine;
        HapticEngine.shared.creteEngine()
        
        // Provide a visual feedback when the buttons are pressed
        hapticButton.applyShadowAndVisualFeedback()
        cameraButton.applyShadowAndVisualFeedback()
        puzzleButton.applyShadowAndVisualFeedback()
        
        // Set the image and the label of the selected Flashcard
        flashcardImage.image = UIImage(named: selectedFlashcard.image!)
        hapticButton.setTitle(selectedFlashcard.name?.uppercased(), for: .normal)
        hapticButton.titleLabel?.font = FontKit.roundedFont(ofSize: 30, weight: .bold)
        
        // Giving rounder corners to the buttons
        hapticButton.layer.cornerRadius = 50
        cameraButton.layer.cornerRadius = cameraButton.frame.height * 0.40
        puzzleButton.layer.cornerRadius = puzzleButton.frame.height * 0.40
        
        
        // Properties for the border and corner of the Flashcards
        flashcardImage.layer.borderWidth = 5
        flashcardImage.layer.cornerRadius = 10
        flashcardImage.contentMode = .scaleAspectFill
        
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
    
    //MARK: HapticButtonPressed:
    // Will play the haptic, based on the selectedFlashcard.hapticPath passed inside the function
    @IBAction func hapticButtonPressed(_ sender: UIButton) {
        // Will play haptics of the selected flashcard
        HapticEngine.shared.playHapticsFile(name: selectedFlashcard.hapticPath!)
    }
    
    
    // Prepare for the segue and passing the selected Flashcard to one of the three puzzles
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "camera" {
            
            let vc = segue.destination as! FindActivityViewController
            vc.selectedFlashcard = selectedFlashcard
                            
            if selectedFlashcard.category == "home" {
                vc.findBackground = findBackgroundImage[0]
                      } else if selectedFlashcard.category == "park" {
                       vc.findBackground = findBackgroundImage[1]
                        } else if selectedFlashcard.category == "market" {
                         vc.findBackground = findBackgroundImage[2]
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
            
            let category = selectedFlashcard.category as String?
            
            if let pv1 = segue.destination as? PuzzleViewController1s {
            switch category {
            case "home":
                pv1.puzzle1Background = puzzleBackgroundImage[0]
            case "park":
                pv1.puzzle1Background = puzzleBackgroundImage[1]
            case "market":
                pv1.puzzle1Background = puzzleBackgroundImage[2]
            default:
                break
            }
            }
            
            if let pv2 = segue.destination as? PuzzleViewController2s {
            switch category {
            case "home":
                pv2.puzzle2Background = puzzleBackgroundImage[0]
            case "park":
                pv2.puzzle2Background = puzzleBackgroundImage[1]
            case "market":
                pv2.puzzle2Background = puzzleBackgroundImage[2]
            default:
                break
            }
            }
            
            if let pv3 = segue.destination as? PuzzleViewController3s {
            switch category {
            case "home":
            pv3.puzzle3Background = puzzleBackgroundImage[0]
            case "park":
            pv3.puzzle3Background = puzzleBackgroundImage[1]
            case "market":
            pv3.puzzle3Background = puzzleBackgroundImage[2]
            default:
            break
            }
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

