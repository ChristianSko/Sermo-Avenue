//
//  PuzzleViewController2s.swift
//  AlphaBeez
//
//  Created by Christian Skorobogatow on 22/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

class PuzzleViewController2s: UIViewController {
    
    //Image Outlets
    @IBOutlet weak var fullImagePuzzleTwo: UIImageView!
    @IBOutlet weak var rightPuzzlePiece: UIImageView!
    @IBOutlet weak var leftPuzzlePiece: UIImageView!
    
    var leftPuzzlePieceButton: UIButton!
    var rightPuzzlePieceButton: UIButton!
    var currentAnimation = 0
    
    // The Flashcard that the user have picked from the collectionView
    var selectedFlashcard = Flashcard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Properties for centered blurred image of puzzle 1
        fullImagePuzzleTwo.image = UIImage(named: "apple")
        fullImagePuzzleTwo.alpha = 0.2
        fullImagePuzzleTwo.layer.borderWidth = 1
        fullImagePuzzleTwo.layer.borderColor =  UIColor.blue.cgColor
        
        // Image for right puzzle Piece
        rightPuzzlePiece.image = UIImage(named: "apple")
        let maskRight = UIImageView()
//        maskRight.contentMode = .scaleAspectFit
        maskRight.image = UIImage(named: "puzzle-2pc-2")
        maskRight.frame = rightPuzzlePiece.bounds
        rightPuzzlePiece.mask = maskRight
        
        // Image for left puzzle Piece
        leftPuzzlePiece.image = UIImage(named: "apple")
        let maskLeft = UIImageView()
        maskLeft.contentMode = .scaleToFill
        maskLeft.image = UIImage(named: "puzzle-2pc-1")
        maskLeft.frame = leftPuzzlePiece.bounds
        leftPuzzlePiece.mask = maskLeft
        
        //Invisible Buttton behind the right puzzle Piece that triggers animation
        rightPuzzlePieceButton = UIButton()
        rightPuzzlePieceButton.frame.size.width = rightPuzzlePiece.frame.size.width
        rightPuzzlePieceButton.frame.size.height = rightPuzzlePiece.frame.size.height
        rightPuzzlePieceButton.center = rightPuzzlePiece.center
        //Adding Border for testing purpose, uncomment for testing size
//        rightPuzzlePieceButton.layer.borderWidth = 3
//        rightPuzzlePieceButton.layer.borderColor = UIColor.blue.cgColor
        rightPuzzlePieceButton.addTarget(self, action: #selector(self.tappedRightPuzzlePiece(sender:)), for: .touchUpInside)
        view.addSubview(rightPuzzlePieceButton)
        
        //Invisible Buttton behind the left puzzle Piece that triggers animation
        leftPuzzlePieceButton = UIButton()
        leftPuzzlePieceButton.frame.size.width = leftPuzzlePiece.frame.size.width
        leftPuzzlePieceButton.frame.size.height = leftPuzzlePiece.frame.size.height
        leftPuzzlePieceButton.center = leftPuzzlePiece.center
        //Adding Border for testing purpose, uncomment for testing size
//        leftPuzzlePieceButton.layer.borderWidth = 3
//        leftPuzzlePieceButton.layer.borderColor = UIColor.blue.cgColor
        leftPuzzlePieceButton.addTarget(self, action: #selector(self.tappedLeftPuzzlePiece(sender:)), for: .touchUpInside)
        view.addSubview(leftPuzzlePieceButton)
        


    }
//       Animation function for right puzzle piece get triggered en tapping button
        @objc func tappedRightPuzzlePiece(sender: UIButton) {
                        
                        sender.isHidden = true
                    
                        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:  {

                        switch self.currentAnimation {
                        case 0:
                            
                            var concatinatedAnimation = CGAffineTransform.identity
                            concatinatedAnimation = concatinatedAnimation.scaledBy(x: 2, y: 2)
                            concatinatedAnimation = concatinatedAnimation.translatedBy(x: -132, y: -6)
                            self.rightPuzzlePiece.transform = concatinatedAnimation

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
    
        // Animation function for left puzzle piece get triggered en tapping button
        @objc func tappedLeftPuzzlePiece(sender: UIButton) {
                        
                        sender.isHidden = true
                    
                        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:  {

                        switch self.currentAnimation {
                        case 0:
                            
                            var concatinatedAnimation = CGAffineTransform.identity
                            concatinatedAnimation = concatinatedAnimation.scaledBy(x: 2, y: 2)
                            concatinatedAnimation = concatinatedAnimation.translatedBy(x: 132, y: -6)
                            self.leftPuzzlePiece.transform = concatinatedAnimation

                        case 1:
                            self.leftPuzzlePiece.transform = .identity
                            
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
