//
//  PuzzleViewController3s.swift
//  AlphaBeez
//
//  Created by Christian Skorobogatow on 22/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

class PuzzleViewController3s: UIViewController {
    
    
     //Image Outlets
    @IBOutlet weak var rightPuzzlePiece: UIImageView!
    @IBOutlet weak var upperLeftPuzzlePiece: UIImageView!
    @IBOutlet weak var bottomLeftPuzzlePiece: UIImageView!
    @IBOutlet weak var fullImagePuzzleThree: UIImageView!
    
    
    var upperLeftPuzzlePieceButton: UIButton!
    var bottomLeftPuzzlePieceButton: UIButton!
    var rightPuzzlePieceButton: UIButton!
    var currentAnimation = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Properties for centered blurred image of puzzle 1
        fullImagePuzzleThree.image = UIImage(named: "apple")
        fullImagePuzzleThree.alpha = 0.2
        fullImagePuzzleThree.layer.borderWidth = 1
        fullImagePuzzleThree.layer.borderColor =  UIColor.blue.cgColor
        
        // Image for right puzzle Piece
        rightPuzzlePiece.image = UIImage(named: "apple")
        let maskRight = UIImageView(image: UIImage(named: "puzzle-1"))
        rightPuzzlePiece.mask = maskRight
        
        // Image for upper left puzzle Piece
        upperLeftPuzzlePiece.image = UIImage(named: "apple")
        let maskTop = UIImageView(image: UIImage(named: "puzzle-2"))
        upperLeftPuzzlePiece.mask = maskTop
        
        
        // Image for bottom left puzzle Piece
        bottomLeftPuzzlePiece.image = UIImage(named: "apple")
        let maskLeft = UIImageView(image: UIImage(named: "puzzle-3"))
        bottomLeftPuzzlePiece.mask = maskLeft
    
        
        
        //Invisible Buttton behind the right puzzle Piece that triggers animation
        rightPuzzlePieceButton = UIButton()
        rightPuzzlePieceButton.frame.size.width = rightPuzzlePiece.frame.size.width
        rightPuzzlePieceButton.frame.size.height = rightPuzzlePiece.frame.size.height
        rightPuzzlePieceButton.center = rightPuzzlePiece.center
        rightPuzzlePieceButton.layer.borderWidth = 3
        rightPuzzlePieceButton.layer.borderColor = UIColor.blue.cgColor
        rightPuzzlePieceButton.addTarget(self, action: #selector(self.tappedRightPuzzlePiece(sender:)), for: .touchUpInside)
        view.addSubview(rightPuzzlePieceButton)
        
        //Invisible Buttton behind the upper left puzzle Piece that triggers animation
        upperLeftPuzzlePieceButton = UIButton()
        upperLeftPuzzlePieceButton.frame.size.width = upperLeftPuzzlePiece.frame.size.width
        upperLeftPuzzlePieceButton.frame.size.height = upperLeftPuzzlePiece.frame.size.height
        upperLeftPuzzlePieceButton.center = upperLeftPuzzlePiece.center
        upperLeftPuzzlePieceButton.layer.borderWidth = 3
        upperLeftPuzzlePieceButton.layer.borderColor = UIColor.blue.cgColor
        upperLeftPuzzlePieceButton.addTarget(self, action: #selector(self.tappedUpperLeftPuzzlePiece(sender:)), for: .touchUpInside)
        view.addSubview(upperLeftPuzzlePieceButton)
        
         //Invisible Buttton behind the right puzzle Piece that triggers animation
        bottomLeftPuzzlePieceButton = UIButton()
        bottomLeftPuzzlePieceButton.frame.size.width = bottomLeftPuzzlePiece.frame.size.width
        bottomLeftPuzzlePieceButton.frame.size.height = bottomLeftPuzzlePiece.frame.size.height
        bottomLeftPuzzlePieceButton.center = bottomLeftPuzzlePiece.center
        bottomLeftPuzzlePieceButton.layer.borderWidth = 3
        bottomLeftPuzzlePieceButton.layer.borderColor = UIColor.blue.cgColor
        bottomLeftPuzzlePieceButton.addTarget(self, action: #selector(self.tappedBotttomLeftPuzzlePiece(sender:)), for: .touchUpInside)
        view.addSubview(bottomLeftPuzzlePieceButton)
        
    }
    
        @objc func tappedRightPuzzlePiece(sender: UIButton) {
                        
                        sender.isHidden = true
                    
                        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:  {

                        switch self.currentAnimation {
                        case 0:
                            
                            var concatinatedAnimation = CGAffineTransform.identity
                            concatinatedAnimation = concatinatedAnimation.scaledBy(x: 2, y: 2)
                            concatinatedAnimation = concatinatedAnimation.translatedBy(x: -131, y: -6)
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
    
    
        @objc func tappedUpperLeftPuzzlePiece(sender: UIButton) {
                            
                            sender.isHidden = true
                        
                            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:  {

                            switch self.currentAnimation {
                            case 0:
                                
                                var concatinatedAnimation = CGAffineTransform.identity
                                concatinatedAnimation = concatinatedAnimation.scaledBy(x: 2, y: 2)
                                concatinatedAnimation = concatinatedAnimation.translatedBy(x: 131, y: 30)
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
    
    @objc func tappedBotttomLeftPuzzlePiece(sender: UIButton) {
                        
                        sender.isHidden = true
                    
                        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:  {

                        switch self.currentAnimation {
                        case 0:
                            
                            var concatinatedAnimation = CGAffineTransform.identity
                            concatinatedAnimation = concatinatedAnimation.scaledBy(x: 2, y: 2)
                            concatinatedAnimation = concatinatedAnimation.translatedBy(x: 131, y: -42)
                            self.bottomLeftPuzzlePiece.transform = concatinatedAnimation

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
