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
    @IBOutlet weak var titleLabel: UILabel!
    
    // Outlets for the imageViews
    @IBOutlet weak var shapeImageView: UIImageView!
    @IBOutlet weak var colorImageView: UIImageView!
    @IBOutlet weak var textureImageView: UIImageView!
    
    // Outlets for the 3 buttons:
    @IBOutlet weak var shapeButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var textureButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
        
    
    // Will keep a record what of the 3 imageViews was tapped
    var whatButtonPressed = 0
    
    var imagePicker = UIImagePickerController()
    
    // Will hold the selectedFlashcard of the users
    var selectedFlashcard = Flashcard()
    
    // Back Button Image
    let backButton = UIImage(named: "back")
    
    // Configuration and name of the SF Symbols
    let configurator = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
    
    // Find Activity background image
    var findBackground = UIImage()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Changing the native back button with our custom one
        let systemButton = UIImage(systemName: "arrow.left.circle", withConfiguration: configurator)?.withTintColor(UIColor.blackElement, renderingMode: .alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage = systemButton
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = systemButton
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
        
        // text label
        titleLabel.text = """
        You just learned \(selectedFlashcard.name!). Now, find something that has the same:
        """
        titleLabel.font = FontKit.roundedFont(ofSize: 30, weight: .regular)
        
        // Giving rounded corners and borders to the 3 imageViews
        shapeButton.layer.cornerRadius = 20
        colorButton.layer.cornerRadius = 20
        textureButton.layer.cornerRadius = 20
        
//        shapeButton.layer.masksToBounds = true
//        colorButton.layer.masksToBounds = true
//        textureButton.layer.masksToBounds = true
        
        // Adding a feedback and shadow to the three buttons
        shapeButton.applyShadowAndVisualFeedback()
        colorButton.applyShadowAndVisualFeedback()
        textureButton.applyShadowAndVisualFeedback()
        
        // Adding a feedback to the info button
        infoButton.showsTouchWhenHighlighted = true
        
        if selectedFlashcard.category == "home" {
            shapeButton.setImage(UIImage(named:"home-shape"), for: .normal)
            colorButton.setImage(UIImage(named:"home-color"), for: .normal)
            textureButton.setImage(UIImage(named:"home-texture"), for: .normal)
        } else if selectedFlashcard.category == "park" {
            shapeButton.setImage(UIImage(named:"park-shape"), for: .normal)
            colorButton.setImage(UIImage(named:"park-color"), for: .normal)
            textureButton.setImage(UIImage(named:"park-texture"), for: .normal)
        } else {
            shapeButton.setImage(UIImage(named:"market-shape"), for: .normal)
            colorButton.setImage(UIImage(named:"market-color"), for: .normal)
            textureButton.setImage(UIImage(named:"market-texture"), for: .normal)
        }
        
        // show picker
        imagePicker.delegate = self
        
        // enable the editing of picked image (Why? since the phrase cards are squared, the image should fits them)
        imagePicker.allowsEditing = true
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
    
    // MARK: - Action for the info button
    @IBAction func infoButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "findAlert", sender: sender)
    }
}
