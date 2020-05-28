//
//  FindActivityViewController.swift
//  AlphaBeez
//
//  Created by Nadia Ruocco on 25/05/2020.
//  Copyright © 2020 Ivan Tilev. All rights reserved.
//

import UIKit

class FindActivityViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Outlets for the label
    @IBOutlet weak var textureLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var shapeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // Outlets for the imageViews
    @IBOutlet weak var shapeImageView: UIImageView!
    @IBOutlet weak var colorImageView: UIImageView!
    @IBOutlet weak var textureImageView: UIImageView!
    
    // Outlets of the Gesture regonizers
    @IBOutlet var shapeGesture: UITapGestureRecognizer!
    @IBOutlet var colorGesture: UITapGestureRecognizer!
    @IBOutlet var textureGesture: UITapGestureRecognizer!
    
    // Will keep a record what of the 3 imageViews was tapped
    var whatImageView = 0
    
    var imagePicker = UIImagePickerController()
    
    // Will hold the selectedFlashcard of the users
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
        
        // text label
        titleLabel.text = """
        You just learned \(selectedFlashcard.name!).
        Now, find something that has the same:
        """
        titleLabel.font = FontKit.roundedFont(ofSize: 25, weight: .regular)
        
        // Giving rounded corners and borders to the 3 imageViews
        shapeImageView.layer.cornerRadius = 20
        colorImageView.layer.cornerRadius = 20
        textureImageView.layer.cornerRadius = 20
        shapeImageView.layer.borderWidth = 5
        colorImageView.layer.borderWidth = 5
        textureImageView.layer.borderWidth = 5
        
        if selectedFlashcard.category == "home" {
            shapeImageView.layer.borderColor = UIColor.purple.cgColor
            colorImageView.layer.borderColor = UIColor.purple.cgColor
            textureImageView.layer.borderColor = UIColor.purple.cgColor
        } else if selectedFlashcard.category == "park" {
            shapeImageView.layer.borderColor = UIColor.red.cgColor
            colorImageView.layer.borderColor = UIColor.red.cgColor
            textureImageView.layer.borderColor = UIColor.red.cgColor
        } else {
            shapeImageView.layer.borderColor = UIColor.orange.cgColor
            colorImageView.layer.borderColor = UIColor.orange.cgColor
            textureImageView.layer.borderColor = UIColor.orange.cgColor
        }
        
        // show picker
        imagePicker.delegate = self
        
        // enable the editing of picked image (Why? since the phrase cards are squared, the image should fits them)
        imagePicker.allowsEditing = true
        
        // set font
        shapeLabel   .font = FontKit.roundedFont(ofSize: 15, weight: .regular)
        colorLabel   .font = FontKit.roundedFont(ofSize: 15, weight: .regular)
        textureLabel .font = FontKit.roundedFont(ofSize: 15, weight: .regular)
    }
    
    // update the square image view with the image picked (from gallery or camera)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        if whatImageView == 1 {
            shapeImageView.image = pickedImage
        } else if whatImageView == 2 {
            colorImageView.image = pickedImage
        } else if whatImageView == 3 {
            textureImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        
        // Will switch to check after tap, which of the 3 imageViews was tapped
        let gesture = sender
        switch gesture {
        case shapeGesture:
            whatImageView = 1
        case colorGesture:
            whatImageView = 2
        case textureGesture:
            whatImageView = 3
        default:
            break
        }
        
        
        // create the alert with two buttons
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // first button: choose photo from iPhone gallery
        alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (button) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        // second button: take photo with default camera
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (button) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        // Cancel\leave action
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}
