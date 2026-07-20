//
//  ImagePicker.swift
//  SwiftUIFirebaseChatApp
//
//  Created by MiteshKumar Patel on 20/07/26.
//

import Foundation
import UIKit
import SwiftUI

//Created Image picker for below ios 16, we have to import swiftUI and UIKIt
//Create struct for ImagePicker , Confirm by UIViewControllerRepresentable
//Import 2 method MakeUIViewController and updateViewController
struct ImagePicker: UIViewControllerRepresentable {
    
    //We need image save here but we need to provide their so we use bindind
    @Binding var image: UIImage?
    
    //We use dismiss environment so created here
    @Environment(\.dismiss) private var dismiss
    
    //MARK: - Create object of sourceType and pass
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    //We first here we return imagePickerController
    // 1. Create the UIViewController
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        
        //MARK: - To return ImagePickerController create object of it
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = sourceType
        imagePickerVC.allowsEditing = true
        imagePickerVC.delegate = context.coordinator // Link to Coordinator
        return imagePickerVC
        
    }
    // 2. Update the UIViewController (Not needed for this use case)
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    // 3. Create the coordinator to bridge uikit delegate to swiftUI
    // We use makeCoordinator, we are passign self means image Picker so we have to create initiliser so it can accept
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // 4. Create class Coordinator where we confirm UIImagePickerControllerDelegate and UINavigationControllerDelegate, also confri to NSObject
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate
    {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // Get the edited or original image
            if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
                parent.image = selectedImage
            }
            parent.dismiss() // Close the picker
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss() // Close the picker on cancel
        }
    }
    
}



//import SwiftUI
//import UIKit
//
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//    @Environment(\.dismiss) private var dismiss
//    var sourceType: UIImagePickerController.SourceType = .photoLibrary
//
//    // 1. Create the UIViewController
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.allowsEditing = true
//        picker.sourceType = sourceType
//        picker.delegate = context.coordinator // Link to Coordinator
//        return picker
//    }
//
//    // 2. Update the UIViewController (Not needed for this use case)
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//
//    // 3. Create the Coordinator to bridge UIKit delegates to SwiftUI
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//        let parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            // Get the edited or original image
//            if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
//                parent.image = selectedImage
//            }
//            parent.dismiss() // Close the picker
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            parent.dismiss() // Close the picker on cancel
//        }
//    }
//}
