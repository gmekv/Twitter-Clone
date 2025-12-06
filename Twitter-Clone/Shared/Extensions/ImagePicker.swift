//
//  ImagePicker.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 02.12.25.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    @Binding var image: UIImage?
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
    }
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate    {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            self.parent.image = image
            self.parent.mode.wrappedValue.dismiss()
        }
    }
}
