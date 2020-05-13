//
//  CategoryViewController.swift
//  AlphaBeez
//
//  Created by Ivan Tilev on 12/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//
// This is the CategoryViewController that will show all the flashcard for it
import UIKit
import CoreHaptics

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let allImages: [UIImage] = [
        UIImage(named: "dog")!,
        UIImage(named: "food")!,
        UIImage(named: "juice")!,
        UIImage(named: "read")!,
        UIImage(named: "real")!,
        UIImage(named: "talk")!
    ]
    
    let hapticsPaths: [String] = [
        "AHAP/Dog",
        "AHAP/Food",
        "AHAP/Juice",
        "AHAP/Read",
        "AHAP/Real",
        "AHAP/Talk"
    ]
    
    // CollectionView Outlets, so I can add the custom FlowLayout
    @IBOutlet weak var collectionView: UICollectionView!
    
    // CustomFlowLayOut that will determine the
    let layout = UICollectionViewFlowLayout()
    
    // A haptic engine manages the connection to the haptic server.
    var engine: CHHapticEngine!
    
    // Maintain a variable to check for Core Haptics compatibility on device.
    lazy var supportsHaptics: Bool = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.supportsHaptics
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        creteEngine()
        // Defining the custom layout and then adding it to the collectionView
        layout.itemSize = CGSize(width: 250, height: 250)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
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
    
    // MARK: - Required methods for the UICollectionViewDataSourcer
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        let image = allImages[indexPath.row]
        cell.imageView.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hapticSound = hapticsPaths[indexPath.row]
        playHapticsFile(name: hapticSound)
    }

}
