//
//  FindActivityViewController.swift
//  AlphaBeez
//
//  Created by Nadia Ruocco on 25/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

class FindActivityViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var textureLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var shapeLabel: UILabel!
    
    var currentImageView: UIImageView? = nil
    
    var imagePicker = UIImagePickerController()
    
    var selectedFlashcard = Flashcard()
    
    // Back Button Image
    let backButton = UIImage(named: "back")

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Changing the native back button with our custom one
        self.navigationController?.navigationBar.backIndicatorImage = backButton
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    // MARK: - ViewDiLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        text label
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
        label.center = CGPoint(x: 414, y: 80)
        label.textAlignment = .center
        label.text = "You just learned \(selectedFlashcard.name!).      Now, find something that has the same:"
        label.numberOfLines = 2
        label.font = FontKit.roundedFont(ofSize: 25, weight: .regular)
        self.view.addSubview(label)
        
        print(selectedFlashcard.name!)
        //        show picker
        imagePicker.delegate = self
                
        //        enable the editing of picked image (Why? since the phrase cards are squared, the image should fits them)
                imagePicker.allowsEditing = true
        
//         set font
            shapeLabel   .font = FontKit.roundedFont(ofSize: 15, weight: .regular)
            colorLabel   .font = FontKit.roundedFont(ofSize: 15, weight: .regular)
            textureLabel .font = FontKit.roundedFont(ofSize: 15, weight: .regular)
    }
    
//    update the square image view with the image picked (from gallery or camera)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

          let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
          currentImageView?.image = pickedImage
          currentImageView?.layer.borderWidth = 20
          currentImageView?.layer.cornerRadius = 20
          dismiss(animated: true, completion: nil)
      }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        
            //        create the alert with two buttons
                       let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
               
           //        first button: choose photo from iPhone gallery
                           alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (button) in
                               self.imagePicker.sourceType = .photoLibrary
                               self.present(self.imagePicker, animated: true, completion: nil)
                           }))
           //
           //             second button: take photo with default camera
                           alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (button) in
                               self.imagePicker.sourceType = .camera
                               self.present(self.imagePicker, animated: true, completion: nil)
                           }))
               
           //        Cancel\leave action
                           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
               
                           present(alert, animated: true, completion: nil)
    }
    
}
