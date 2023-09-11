//
//  imagePicker.swift
//  Proje
//
//  Created by MURAT BAŞER on 8.09.2023.
//

import SwiftUI

struct ImagePicker : UIViewControllerRepresentable {
    @Binding var selectedImage : UIImage?
    @Binding var isPicker : Bool
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}
class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var parent : ImagePicker
    init(_ picker : ImagePicker){
        self.parent = picker
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("selected image")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.parent.selectedImage = image
            }
        }
        parent.isPicker = false
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("image cancelled")
        parent.isPicker = false
    }
}


