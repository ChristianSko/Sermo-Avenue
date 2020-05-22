//
//  PuzzleViewController2s.swift
//  AlphaBeez
//
//  Created by Christian Skorobogatow on 22/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

class PuzzleViewController2s: UIViewController {
    
    var puzzle2Button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // This simply adds a button that helps me see if it was sent to viewcontroller I wanted it to go
        puzzle2Button = UIButton(type: .system)
        puzzle2Button.setTitle("this is puzzle2", for: .normal)
        puzzle2Button.tintColor = .red
        puzzle2Button.frame = CGRect(x: 400, y: 200, width: 200, height: 200)
        view.addSubview(puzzle2Button)
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
