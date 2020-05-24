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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Properties for centered blurred image of puzzle 1
        fullImagePuzzleTwo.image = UIImage(named: "apple")
        fullImagePuzzleTwo.alpha = 0.2
        
        // Image for right puzzle Piece
        rightPuzzlePiece.image = UIImage(named: "apple")
        
        // Image for left puzzle Piece
        leftPuzzlePiece.image = UIImage(named: "apple")
        
        //Invisible Buttton behind the right puzzle Piece that triggers animation
        rightPuzzlePieceButton = UIButton()
        rightPuzzlePieceButton.frame.size.width = rightPuzzlePiece.frame.size.width
        rightPuzzlePieceButton.frame.size.height = rightPuzzlePiece.frame.size.height
        rightPuzzlePieceButton.center = rightPuzzlePiece.center
        rightPuzzlePieceButton.layer.borderWidth = 3
        rightPuzzlePieceButton.layer.borderColor = UIColor.blue.cgColor
        rightPuzzlePieceButton.addTarget(self, action: #selector(self.tappedRightPuzzlePiece(sender:)), for: .touchUpInside)
        view.addSubview(rightPuzzlePieceButton)
        
        //Invisible Buttton behind the left puzzle Piece that triggers animation
        leftPuzzlePieceButton = UIButton()
        leftPuzzlePieceButton.frame.size.width = leftPuzzlePiece.frame.size.width
        leftPuzzlePieceButton.frame.size.height = leftPuzzlePiece.frame.size.height
        leftPuzzlePieceButton.center = leftPuzzlePiece.center
        leftPuzzlePieceButton.layer.borderWidth = 3
        leftPuzzlePieceButton.layer.borderColor = UIColor.blue.cgColor
        leftPuzzlePieceButton.addTarget(self, action: #selector(self.tappedLeftPuzzlePiece(sender:)), for: .touchUpInside)
        view.addSubview(leftPuzzlePieceButton)
        


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
    
        @objc func tappedLeftPuzzlePiece(sender: UIButton) {
                        
                        sender.isHidden = true
                    
                        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:  {

                        switch self.currentAnimation {
                        case 0:
                            
                            var concatinatedAnimation = CGAffineTransform.identity
                            concatinatedAnimation = concatinatedAnimation.scaledBy(x: 2, y: 2)
                            concatinatedAnimation = concatinatedAnimation.translatedBy(x: 131, y: -6)
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
