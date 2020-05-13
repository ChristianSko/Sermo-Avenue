//
//  GreenCarouselCollectionView.swift
//  AlphaBeez
//
//  Created by Nadia Ruocco on 13/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

import UIKit

class GreenCarouselCollectionView: UIViewController {

    @IBOutlet weak var iCarouselGreenView: iCarousel!
    
    let allImages: [UIImage] = [
        UIImage(named: "dog")!,
        UIImage(named: "food")!,
        UIImage(named: "juice")!,
        UIImage(named: "read")!,
        UIImage(named: "real")!,
        UIImage(named: "talk")!
    ]
    
override func viewDidLoad() {
    super.viewDidLoad()
    
//    how to display the images
    iCarouselGreenView.type = .rotary
//    or aspect to fill
    iCarouselGreenView.contentMode = .center
//    iCarouselGreenView.isPagingEnabled = true
    }
}

extension GreenCarouselCollectionView: iCarouselDelegate, iCarouselDataSource {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return allImages.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var imageView: UIImageView!
        if view == nil {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 250))
            imageView.contentMode = .scaleAspectFit
        } else {
            imageView = view as? UIImageView
        }
        
        imageView.image = allImages[index]
        
        return imageView
}
}
