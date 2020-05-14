//
//  Flashcard.swift
//  AlphaBeez
//
//  Created by Ivan Tilev on 14/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import Foundation
import UIKit

// This is the Model of our Data - we say that every Flashcard should have this properties
struct Flashcard {
    var name: String?
    var image: UIImage?
    var hapticPath: String?
    
    // Initializing, because we need in some places to just have empty Flashcard object!
    init(name: String? = nil, image: UIImage? = nil, hapticPath: String? = nil) {
        self.name = name
        self.image = image
        self.hapticPath = hapticPath
    }
}
