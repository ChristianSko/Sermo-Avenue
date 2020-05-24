//
//  PuzzleViewController1s.swift
//  AlphaBeez
//
//  Created by Christian Skorobogatow on 22/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

class PuzzleViewController1s: UIViewController {

    
    var oneSyllablePuzzleButton: UIButton!
    var currentAnimation = 0
    var selectedFlashcard = Flashcard()
    
    @IBOutlet weak var fullImagePuzzleOne: UIImageView!
    @IBOutlet weak var oneSyllablePuzzle: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Properties for centered blurred image of puzzle 1
        fullImagePuzzleOne.image = UIImage(named: "bench")
        fullImagePuzzleOne.alpha = 0.2
        fullImagePuzzleOne.layer.borderWidth = 1
        fullImagePuzzleOne.layer.borderColor =  UIColor.blue.cgColor
        
        // Properties of puzzle Piece
        oneSyllablePuzzle.image = UIImage(named: "bench")
        
        //Invisible Buttton behind the Puzzle Piece that triggers animation
        oneSyllablePuzzleButton = UIButton()
        oneSyllablePuzzleButton.frame.size.width = oneSyllablePuzzle.frame.size.width
        oneSyllablePuzzleButton.frame.size.height = oneSyllablePuzzle.frame.size.height
        oneSyllablePuzzleButton.center = oneSyllablePuzzle.center
        oneSyllablePuzzleButton.addTarget(self, action: #selector(self.oneSyllablePuzzleTapped(sender:)), for: .touchUpInside)
        view.addSubview(oneSyllablePuzzleButton)
                
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
                        self.oneSyllablePuzzle.transform = concatinatedAnimation

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
