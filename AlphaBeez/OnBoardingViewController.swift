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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        for x in 0..<4 {
            
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
            
            //makes sure the buttton of the 4th screen is
            if x == 3 {
                button = UIButton(frame: CGRect(x: pageView.frame.size.width-160, y: pageView.frame.size.height-60, width: 140, height: 50))
                nextImage = UIImage(named: "play")
                button.setBackgroundImage(nextImage, for: .normal)
                button.applyShadowAndVisualFeedback()
    
            }
            //Adding 1 extra to each tag so we can track if the flow was completed in didTapButton
            button.tag = x + 1
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            pageView.addSubview(button)
        }
        
        // This should make the view scrollable -> Currently not working, trying to fix
        scrollView.contentSize = CGSize(width: holderView.frame.size.width, height: 0)
        scrollView.isPagingEnabled =  true
    }
    
    
    @objc func didTapButton(_ button: UIButton) {

        
        // Makes sure onboarding is only shown if it has never been completed before.
        guard button.tag < 4 else {
            
            Core.shared.setIsNotNewUser()
            dismiss(animated: true, completion: nil)
            return
        }
        
        // Scrolls to next page
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
        
    }
}
