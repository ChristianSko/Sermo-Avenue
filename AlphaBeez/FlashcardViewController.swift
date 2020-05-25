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
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var puzzleButton: UIButton!
    
    // This is he Flashcard that is transferred from CategoryViewController (the one that the user tapped)
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
    //    To handle the reading and saving of data
        var audioRecorder : AVAudioRecorder?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating the HapticEngine
        creteEngine()

        // Set the image and the label of the selected Flashcard
        hapticButton.setImage(UIImage(named: selectedFlashcard.image!), for: .normal)
        cardNameLabel.text = selectedFlashcard.name
        
//        Disable play and stop button, in order to enable the record one
        playButton.isEnabled = false
        stopButton.isEnabled = false
               
//              Getting URL path for audio
               let directoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
               let docDirectory = directoryPath[0]
//        pass the url as a string
               let soundFilePath = (docDirectory as NSString).appendingPathComponent("sound.caf")
               let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
               print(soundFilePath)

               //Recording audio setting (quality, bit rate, chanels, frequency in hertz)
               let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
                   AVEncoderBitRateKey: 16,
                   AVNumberOfChannelsKey : 2,
                   AVSampleRateKey: 44100.0] as [String : Any] as [String : Any] as [String : Any] as [String : Any]
        
        
               var error : NSError?
               let audioSession = AVAudioSession.sharedInstance()
               do {
//                Set the category as playAndRecord
                   try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
                   audioRecorder = try AVAudioRecorder(url: soundFileURL as URL, settings: recordSettings as [String : AnyObject])
               } catch _ {
                   print("Error")
               }

               if let err = error {
                   print("audioSession error: \(err.localizedDescription)")
               }else{
                   audioRecorder?.prepareToRecord()
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
    
//    Record audio
    @IBAction func recordAudio(_ sender: Any) {
        if audioRecorder?.isRecording == false{
                    playButton.isEnabled = false
                    stopButton.isEnabled = true
                    audioRecorder?.record()
                }
    }
    
//    Stop the recording
    @IBAction func stopAudio(_ sender: Any) {
        stopButton.isEnabled = false
               playButton.isEnabled = true
               recordButton.isEnabled = true

               if audioRecorder?.isRecording == true{
                   audioRecorder?.stop()
               } else {
                   audioPlayer?.stop()
               }
    }
    
//    Playback the recording
    @IBAction func playAudio(_ sender: Any) {
        if audioRecorder?.isRecording == false{
                  stopButton.isEnabled = true
                  recordButton.isEnabled = false

                  var error : NSError?
                  do {
                      let player = try AVAudioPlayer(contentsOf: audioRecorder!.url)
                       audioPlayer = player
                   } catch {
                       print(error)
                   }

                  audioPlayer?.delegate = self

                  if let err = error{
                      print("audioPlayer error: \(err.localizedDescription)")
                  } else {
                      audioPlayer?.play()
                  }
              }
    }
    
    //    When the playback is finished, change the state of buttons
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        stopButton.isEnabled = false
    }
    
    //    MARK: To manage errors during record and playback (such as an incoming call)

//    Decoding error during playback
    private func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        print("Audio Play Decode Error")
    }

//    When a recording is stopped or has finished due to reaching its time limit.
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Recording is stopped due to reaching time limit")
    }

//    Encoding error during recording
    private func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        print("Audio Record Encode Error")
    }
    
    

    @IBAction func puzzleTouched(_ sender: UIButton) {

// sending to PuzzleViewController1s, PuzzleViewController2s or PuzzleViewController3s based on puzzleSyllableType
        
        if let syllables: Int = Int(selectedFlashcard.syllables) {
            print(syllables)
            if syllables == 1 {
                performSegue(withIdentifier: "puzzleOne", sender: self)
            } else if syllables == 2 {
                performSegue(withIdentifier: "puzzleTwo", sender: self)
            } else if syllables == 3 {
                performSegue(withIdentifier: "puzzleThree", sender: self)
            }
        }
    }
    
}
