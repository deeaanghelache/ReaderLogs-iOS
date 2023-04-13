//
//  ProfileIconView.swift
//  ReaderLogs
//
//  Created by Andreea Anghelache on 11.04.2023.
//

import UIKit

class ProfileIconView: UIImageView {
    var parentViewController: ProfileViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        showImagePicker()
    }
    
    private func showImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        // Check if the device has a camera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // If the device has a camera, allow the user to choose between library and camera
            let alertController = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Library", style: .default, handler: { _ in
                imagePickerController.sourceType = .photoLibrary
                self.presentImagePicker(imagePickerController)
            }))
            alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                imagePickerController.sourceType = .camera
                self.presentImagePicker(imagePickerController)
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.parentViewController?.present(alertController, animated: true, completion: nil)
        } else {
            // If the device does not have a camera, show library directly
            imagePickerController.sourceType = .photoLibrary
            self.presentImagePicker(imagePickerController)
        }
    }
    
    private func presentImagePicker(_ imagePickerController: UIImagePickerController) {
        self.parentViewController?.present(imagePickerController, animated: true, completion: nil)
        }
}

extension ProfileIconView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            // Update the profile icon view with the picked image
            self.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
