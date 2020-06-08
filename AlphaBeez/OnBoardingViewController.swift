//
//  OnBoardingViewController.swift
//  AlphaBeez
//
//  Created by Christian Skorobogatow on 04/06/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {

// UIView Outlet for the Scrollview
    @IBOutlet var holderView: UIView!
    var scrollView = UIScrollView()
    
    
    // Maintain a variable to check for Core Haptics compatibility on device.
       lazy var supportsHaptics: Bool = {
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           return appDelegate.supportsHaptics
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Presents an alert Controller if device is not supported
        if !supportsHaptics {
        let ac = UIAlertController(title: "Unsupported Device", message: "The Custom Vibrations used in this app are only supported by iPhone 8 and up.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
        }
        
        
        // Creating the HapticEngine
        HapticEngine.shared.creteEngine()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        //This creates the whole onboarding
        configureOnBoarding()
    }

    // Function creating all setup for setting 4 onboarding screens with respective button
    private func configureOnBoarding() {
        
        //Sets  frame of scrollview to be equal to its holder
        scrollView.frame = holderView.frame
        holderView.addSubview(scrollView)
        
        for x in 0..<5 {
            
            // x is multiplied to set the starting point of each pageview
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            
            //Set bounds of each image inside of each page view
            let imageView = UIImageView(frame: holderView.bounds)
            imageView.contentMode = .scaleToFill
            imageView.image = UIImage(named: "onboarding_\(x+1)")
            pageView.addSubview(imageView)
    
            //adds a button to each page
            var nextImage = UIImage(named: "next")
            var button = UIButton(frame: CGRect(x: pageView.frame.size.width-110, y: pageView.frame.size.height-60, width: 50, height: 50))
            button.setBackgroundImage(nextImage, for: .normal)
            button.applyShadowAndVisualFeedback()
            
            let bananaImage = UIImage(named: "banana-button")

            let bananaButton = UIButton(frame: CGRect(x: pageView.frame.size.width / 2, y: pageView.frame.height / 6 , width: 280, height: 140))
            bananaButton.contentMode = .scaleToFill
            bananaButton.setImage(bananaImage, for: .normal)
            bananaButton.isHidden = true
            
            let walkImage = UIImage(named: "walk-button")
            let walkButton = UIButton(frame: CGRect(x: pageView.center.y - 100, y: pageView.frame.height / 3 , width: 280, height: 140))
            walkButton.setImage(walkImage, for: .normal)
            walkButton.isHidden = true
            
            
            
            let wallImage = UIImage(named: "wall-button")
            let wallButton =  UIButton()
            wallButton.frame.size.width = walkButton.frame.size.width
            wallButton.frame.size.height = walkButton.frame.size.height
            wallButton.center.x = walkButton.center.x + 280
            wallButton.center.y = walkButton.center.y
            wallButton.setImage(wallImage, for: .normal)
            wallButton.isHidden = true
            
            
            // Shows the haptic banana button for onboarding screen 2
            if x == 2 {
                bananaButton.isHidden = false
            }
            
            if x == 3 {
                bananaButton.isHidden = true
                wallButton.isHidden = false
                walkButton.isHidden = false
                
            }
            
            //makes sure the play button appears on the last onboarding screen
            if x == 4 {
                
                button = UIButton(frame: CGRect(x: pageView.frame.size.width-160, y: pageView.frame.size.height-60, width: 140, height: 50))
                nextImage = UIImage(named: "play")
                button.setBackgroundImage(nextImage, for: .normal)
                button.applyShadowAndVisualFeedback()
    
            }
            
            //Adding 1 extra to each tag so we can track if the flow was completed in didTapButton
            button.tag = x + 1
            
            //Actions for all Buttons
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            bananaButton.addTarget(self, action: #selector(didTapBananaButton(_:)), for: .touchUpInside)
            walkButton.addTarget(self, action:  #selector(didTapWalkButton(_:)), for: .touchUpInside)
            wallButton.addTarget(self, action:  #selector(didTapWallButton), for: .touchUpInside)
            
            //Adding buttons
            pageView.addSubview(button)
            pageView.addSubview(bananaButton)
            pageView.addSubview(walkButton)
            pageView.addSubview(wallButton)
        }
        
        // This should make the view scrollable -> Currently not working, trying to fix
        scrollView.contentSize = CGSize(width: holderView.frame.size.width, height: 0)
        scrollView.isPagingEnabled =  true
    }
    
    
    @objc func didTapButton(_ button: UIButton) {

        
        // Makes sure onboarding is only shown if it has never been completed before.
        guard button.tag < 5 else {
            
            Core.shared.setIsNotNewUser()
            dismiss(animated: true, completion: nil)
            return
        }
        
        // Scrolls to next page
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
        
    }
    
    //This should play the Banana Haptic file
    @objc func didTapBananaButton(_ sender: UIButton) {
        print("PLease say BANANAAAA")
        HapticEngine.shared.playHapticsFile(name: "banana")
    }
    
    @objc func didTapWalkButton(_ sender: UIButton){
        print("Walk it off dawg!")
        
    }
    
    @objc func didTapWallButton(_ sender: UIButton){
        print("Did I just hit wall?")
    }
    
    
}
