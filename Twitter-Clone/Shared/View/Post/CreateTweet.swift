//
//  CreateTweetView.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 04.11.25.
//

import SwiftUI

struct CreateTweet: View {
    @Binding var show: Bool
    
    @State var text = ""
    @ObservedObject var viewModel = CreateTweetViewModel()
    
    @State var imagePickerPresented: Bool = false
    @State var selectedImage: UIImage?
    @State var postImage: Image?
    @State var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.show.toggle()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button {
                    if text != "" {
                        self.viewModel.uploadPost(text: text, image: selectedImage)
                    }
                    self.show.toggle()
                } label: {
                    Text("Tweet").padding()
                }
                .background(Color(.blue))
                .foregroundStyle(.white)
                .clipShape(Capsule())
            }
            MultilineTextField(text: $text)
            if postImage == nil {
                Button {
                    self.imagePickerPresented.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipped()
                        .padding(.top)
                        .foregroundStyle(.black)
                }
                .sheet(isPresented: $imagePickerPresented) {
                    loadImage()
                } content: {
                    ImagePicker(image: $selectedImage)
                }
            }
    
            if let image = postImage {
                VStack {
                    HStack(alignment: .top) {
                        image
                            .resizable()
                            .scaledToFill()
                            .padding(.horizontal)
                            .frame(width: width * 0.9)
                            .cornerRadius(16)
                            .clipped()
                    }
                    Spacer()
                }
            }
        }
        .padding()
    }
}

extension CreateTweet {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }
}
