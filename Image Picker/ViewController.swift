//
//  ViewController.swift
//  Image Picker
//
//  Created by william dam on 1/3/21.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Image view to display user selected photo
    @IBOutlet weak var imagePreview: UIImageView!
    
    // Instantiate image picker controller and assign var imagePicker
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegate function
        imagePicker.delegate = self
        
    }

    // Function: addPhotoButtonPressed()
    // Args: IBAction
    // Returns: None
    // Description: When "Add Photo" button pressed, present photo
    // source options in action sheet.
    // Dependencies: getFromCamera(), getFromPhotoLibrary()
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
        
        // Instantiate action sheet
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        // Option 1: Camera
        let useCamera = UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            
            self.getFromCamera()
            
        })
        
        // Option 2: Photo Library
        let usePhotoLibrary = UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            
            self.getFromPhotoLibrary()
            
        })
        
        // Option 3: Cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // Add all options to action sheet
        optionMenu.addAction(useCamera)
        optionMenu.addAction(usePhotoLibrary)
        optionMenu.addAction(cancelAction)
        
        // Display action sheet
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    // Function: getFromCamera()
    // Args: None
    // Returns: Void
    // Description: Open camera if available.
    func getFromCamera() {
        
        // Run if camera available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            self.imagePicker.delegate = self
            present(self.imagePicker, animated: true)
        }
        
        // Print message if camera not available
        else {
            print("Camera not available.")
        }
    }
    
    // Function: getFromPhotoLibrary()
    // Args: None
    // Returns: Void
    // Description: Open photo library
    func getFromPhotoLibrary() {
        
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
        
    }
    
    // Function: imagePickerController()
    // Args: None
    // Returns: Void
    // Description: Delegate function sets imagePreview.image
    // to image returned from UIImagePickerController()
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imagePreview?.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage

        picker.dismiss(animated: true, completion: nil)
        
    }
}

