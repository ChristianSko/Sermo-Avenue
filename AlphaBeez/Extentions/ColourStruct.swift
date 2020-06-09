//
//  ColourStruct.swift
//  AlphaBeez
//
//  Created by Nadia Ruocco on 26/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

public extension UIColor {
    
//    market = blue
    static var marketColor: UIColor {
        return UIColor(red:38/255, green:184/255, blue:255/255, alpha:1.00)
    }

//    park = red
    static var parkColor: UIColor {
        return UIColor(red:242/255, green:46/255, blue:37/255, alpha:1.00)
    }
    
//    home = purple
    static var homeColor: UIColor {
        return UIColor(red:128/255, green:48/255, blue:255/255, alpha:1.00)
    }
    
//    Info Alert Border & Restart puzzle Button
    static var greenElements: UIColor {
        return UIColor(red:70/255, green:190/255, blue:102/255, alpha:1.00)
    }
    
// for the X and the back button
    static var redElements: UIColor {
        return UIColor(red:245/255, green:94/255, blue:87/255, alpha:1.00)
    }
    
}

