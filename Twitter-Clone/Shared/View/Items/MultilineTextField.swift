//
//  MultilineTextField.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 04.11.25.
//

import SwiftUI


struct MultilineTextField: UIViewRepresentable {
    
    func makeCoordinator() -> MultilineTextField.Coordinator {
        return MultilineTextField.Coordinator(parent1: self)
    }
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let text = UITextView()
        text.allowsNumberPadPopover = true
        text.isEditable = true
        text.text = "Type Something"
        text.textColor = .gray
        text.isUserInteractionEnabled = true
        text.font = .systemFont(ofSize: 20)
        text.delegate = context.coordinator
        return text
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultilineTextField
        
        init(parent1: MultilineTextField) {
            parent = parent1
         }
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .black
        }
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }
    
    
}

