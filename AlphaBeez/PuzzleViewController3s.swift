//
//  PuzzleViewController3s.swift
//  AlphaBeez
//
//  Created by Christian Skorobogatow on 22/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

class PuzzleViewController3s: UIViewController {
    
    var puzzle3Button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // This simply adds a button that helps me see if it was sent to viewcontroller I wanted it to go
        puzzle3Button = UIButton(type: .system)
        puzzle3Button.setTitle("this is puzzle3", for: .normal)
        puzzle3Button.tintColor = .red
        puzzle3Button.frame = CGRect(x: 400, y: 200, width: 200, height: 200)
        view.addSubview(puzzle3Button)
        
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
