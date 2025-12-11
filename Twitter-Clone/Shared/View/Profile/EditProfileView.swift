//
//  EditProfileView.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 07.12.25.
//


import SwiftUI
import Kingfisher

struct EditProfileView: View {
    
    @Environment(\.presentationMode) var mode
    @ObservedObject var viewModel: EditProfileViewModel
    @Binding var user: User
    
    @State var name: String
    @State var location: String
    @State var bio: String
    @State var website: String
    
    @State private var selectedImage: UIImage?
    @State var profileImage: Image?
    @State var imagePickerRepresented = false
    
    
    @State var editProfileShow = false

    init(user: Binding<User>) {
        self._user = user
        self.viewModel = EditProfileViewModel(user: self._user.wrappedValue)
        self._name = State(initialValue: _user.name.wrappedValue)
        self._website = State(initialValue: _user.website.wrappedValue ?? "")
        self._bio = State(initialValue: _user.bio.wrappedValue ?? "")
        self._location = State(initialValue: _user.location.wrappedValue ?? "")
    }
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.black)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        
                        if (selectedImage != nil) {
                            print("With image")
                            self.viewModel.uploadProfileImage(text: "text", image: selectedImage)
                            self.viewModel.uploadUserData(name: name, bio: bio, website: website, location: location)
                            
                            let avatarURLString = "http://localhost:3000/users/\(self.viewModel.user.id)/avatar"
                            KingfisherManager.shared.cache.removeImage(forKey: avatarURLString)
                        }
                        else {
                            print("Without image")
                            self.viewModel.uploadUserData(name: name, bio: bio, website: website, location: location)
                        }
                        
                        
                    }, label: {
                        Text("Save")
                            .foregroundColor(.black)
                    })
                    
                }.padding()
                
                HStack {
                    Spacer()
                    Text("Edit profile")
                        .fontWeight(.heavy)
                    Spacer()
                }
            }
            
            
            VStack {
                
                Image("banner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRect().width, height: 180, alignment: .center)
                    .cornerRadius(0)
                
                HStack {
                    
                    if profileImage == nil {
                        
                        Button {
                            self.imagePickerRepresented.toggle()
                        } label: {
                            KFImage(URL(string: "http://localhost:3000/users/\(self.viewModel.user.id)/avatar"))
                                .resizable()
                                .placeholder({
                                    Image("blankpp")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 75, height: 75)
                                        .clipShape(Circle())
                                })
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(8)
                                .background(Color.white)
                                .clipShape(Circle())
                                .offset(y: -20)
                                .padding(.leading, 12)
                        }.sheet(isPresented: $imagePickerRepresented) {
                            loadImage()
                        } content: {
                            ImagePicker(image: $selectedImage)
                        }
                        
                    }
                    
                    else if let image = profileImage {
                        VStack {
                            HStack(alignment: .top) {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                                    .padding(8)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .offset(y: -20)
                                
                            }
                            .padding()
                            
                            
                        }.padding(.leading, 12)
                    }
                    Spacer()
                    
                }
                .onAppear {
                    KingfisherManager.shared.cache.clearCache()
                }
                .padding(.top, -25)
                .padding(.bottom, -10)

                
                VStack {
                    Divider()
                    HStack {
                        ZStack {
                            HStack {
                                Text("Name")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            CustomProfileTextField(message: $name, placeholder: "Add your name")
                                .padding(.leading, 90)
                        }
                    }
                    .padding(.horizontal)
                    Divider()
                    HStack {
                        ZStack {
                            HStack {
                                Text("Location")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            CustomProfileTextField(message: $location, placeholder: "Add your location")
                                .padding(.leading, 90)
                        }
                    }
                    .padding(.horizontal)
                    Divider()
                    HStack {
                        ZStack(alignment: .topLeading) {
                            HStack {
                                Text("Bio")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            CustomProfileBioTextField(bio: $bio)
                                .padding(.leading, 86)
                                .padding(.top, -6)
                        }
                    }
                    .padding(.horizontal)
                    Divider()
                    HStack {
                        ZStack(alignment: .topLeading) {
                            HStack {
                                Text("Website")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            CustomProfileTextField(message: $website, placeholder: "Add your website")
                                .padding(.leading, 90)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer()
        }
        .onReceive(viewModel.$uploadComplete) { complete in
            if complete {
                self.mode.wrappedValue.dismiss()
                
                self.user.name = viewModel.user.name
                self.user.website = viewModel.user.website
                self.user.location = viewModel.user.location
                self.user.bio = viewModel.user.bio
                
            }
        }
    }
}

extension EditProfileView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}
