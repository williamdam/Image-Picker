//
//  ViewController.swift
//  Image Picker
//
//  Created by william dam on 1/3/21.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var imagePreview: UIImageView!
    
    // Instantiate image picker controller and set var
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegate function
        imagePicker.delegate = self
        
        // Check permission to access photos
        checkPermissions()
    }

    // Action Sheet popup camera or photo library
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let useCamera = UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            
            self.getFromCamera()
            
        })
        
        let usePhotoLibrary = UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            
            self.getFromPhotoLibrary()
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(useCamera)
        optionMenu.addAction(usePhotoLibrary)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
        
        
    }
    
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
    
    func getFromPhotoLibrary() {
        
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
        
    }
    
    // Get authorization at startup
    func checkPermissions() {
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in ()
            })
        }
        
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
        } else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationhandler)
        }
    }
    
    func requestAuthorizationhandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            print("Access granted to use Photo Library")
        } else {
            print("We don't have access to your Photos.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imagePreview?.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage

        picker.dismiss(animated: true, completion: nil)
        
    }
}

