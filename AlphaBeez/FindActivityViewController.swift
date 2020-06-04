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
    
    // Outlets for the 3 buttons:
    @IBOutlet weak var shapeButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var textureButton: UIButton!
    
    // Will keep a record what of the 3 imageViews was tapped
    var whatButtonPressed = 0
    
    var imagePicker = UIImagePickerController()
    
    // Will hold the selectedFlashcard of the users
    var selectedFlashcard = Flashcard()
    
    // Back Button Image
    let backButton = UIImage(named: "back")
    
    // Find Activity background image
    var findBackground = UIImage()
    
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

        // Set find activity background
         let findBackgroundImage = UIImageView(frame: UIScreen.main.bounds)
         findBackgroundImage.image = findBackground
         findBackgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
         self.view.insertSubview(findBackgroundImage, at: 0)
        
        // Hiding the custom back button
        navigationItem.hidesBackButton = true
        
        // text label
        titleLabel.text = """
        You just learned \(selectedFlashcard.name!).
        Now, find something that has the same:
        """
        titleLabel.font = FontKit.roundedFont(ofSize: 30, weight: .regular)
        
        // Giving rounded corners and borders to the 3 imageViews
        shapeButton.layer.cornerRadius = 20
        colorButton.layer.cornerRadius = 20
        textureButton.layer.cornerRadius = 20
        
        if selectedFlashcard.category == "home" {
            shapeButton.backgroundColor = UIColor.homeColor
            colorButton.backgroundColor = UIColor.homeColor
            textureButton.backgroundColor = UIColor.homeColor
        } else if selectedFlashcard.category == "park" {
            shapeButton.backgroundColor = UIColor.parkColor
            colorButton.backgroundColor = UIColor.parkColor
            textureButton.backgroundColor = UIColor.parkColor
        } else {
            shapeButton.backgroundColor = UIColor.marketColor
            colorButton.backgroundColor = UIColor.marketColor
            textureButton.backgroundColor = UIColor.marketColor
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
        if whatButtonPressed == 1 {
            shapeButton.setImage(pickedImage, for: .normal)
            shapeButton.imageView?.contentMode = .scaleAspectFill
        } else if whatButtonPressed == 2 {
            colorButton.setImage(pickedImage, for: .normal)
            colorButton.imageView?.contentMode = .scaleAspectFill
        } else if whatButtonPressed == 3 {
            textureButton.setImage(pickedImage, for: .normal)
            colorButton.imageView?.contentMode = .scaleAspectFill
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func addPhoto(_ sender: UIButton) {
        // Checks which buttons is pressed
        let button = sender
        switch button {
        case shapeButton:
            whatButtonPressed = 1
        case colorButton:
            whatButtonPressed = 2
        case textureButton:
            whatButtonPressed = 3
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
    
    // MARK: - Action for the exit button
    @IBAction func exitButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
