//
//  OnBoardingViewController.swift
//  AlphaBeez
//
//  Created by Christian Skorobogatow on 04/06/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet var holderView: UIView!


    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }

    private func configure() {
        
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        
        
        for x in 0..<4 {
            
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * (holderView.frame.size.width), y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            
//            Title, image,
            let imageView = UIImageView(frame: UIScreen.main.bounds)
            let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height-60, width: pageView.frame.size.width-20, height: 50))
              
            imageView.contentMode = .scaleAspectFill
            imageView.image = UIImage(named: "onboarding_\(x+1)")
            pageView.addSubview(imageView)
            
            
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.setTitle( "Continue", for: .normal)
            if x == 3 {
                button.setTitle( "Get Started", for: .normal)
            }
            button.tag = x + 1
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            pageView.addSubview(button)
        }
        
        scrollView.contentSize = CGSize(width: holderView.frame.size.width, height: 0)
        scrollView.isPagingEnabled = true
        
    }
    
    
    @objc func didTapButton(_ button: UIButton) {
        
        guard button.tag < 4 else {
            
            Core.shared.setIsNotNewUser()
            dismiss(animated: true, completion: nil)
            return
        }
        
//        scroll to next page
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
        
    }
}
