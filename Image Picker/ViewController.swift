//
//  ViewController.swift
//  Image Picker
//
//  Created by william dam on 1/3/21.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var cameraPreview: UIImageView!
    
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var photoPreview: UIImageView!
    
    // Instantiate image picker controller and set var
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegate function
        imagePicker.delegate = self
        
        // Check permission to access photos
        checkPermissions()
    }

    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        
        self.imagePicker.sourceType = .camera
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
        present(self.imagePicker, animated: true)
        
    }
    
    @IBAction func photoButtonPressed(_ sender: UIButton) {
        
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
        
    }
    
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
        
        if picker.sourceType == .photoLibrary {
            photoPreview?.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        } else {
            cameraPreview?.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        }

        picker.dismiss(animated: true, completion: nil)
        
    }
}

