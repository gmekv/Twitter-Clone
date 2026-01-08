//
//  EditProfileViewModel.swift
//  twitter-clone (iOS)
//
//  Created by cem on 12/7/21.
//

import SwiftUI
import Combine

class EditProfileViewModel: ObservableObject {
    
    var user: User
    @Published var uploadComplete = false
    
    init(user: User) {
        self.user = user
    }
    
    func save(name: String?, bio: String?, website: String?, location: String?) {
        
        guard let userNewName = name else { return }
        guard let userNewWebsite = website else { return }
        guard let userNewLocation = location else { return }
        self.user.name = userNewName
        self.user.bio = bio
        self.user.website = userNewWebsite
        self.user.location = userNewLocation
    
    }
    
    func uploadProfileImage(text: String, image: UIImage?) {
        
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        let urlPath = APIConfig.Endpoints.uploadAvatar()
        
        if let image = image {
            print("There is an image")
            ImageUploader.upload(paramName: "avatar", fileName: "image1", image: image, urlPath: urlPath)
        }
    }
    
    func uploadUserData(name: String?, bio: String?, website: String?, location: String?) {
        
        let userId = user.id 
        
        let url = URL(string: APIConfig.Endpoints.updateUser(id: userId))!
        
        AuthServices.makePatchRequestWithAuth(urlString: url, reqBody: ["name": name, "bio": bio, "website": website, "location": location]) { res in
        
            
            DispatchQueue.main.async {
                self.save(name: name, bio: bio, website: website, location: location)
                self.uploadComplete = true

            }
            
//            switch res {
//                case .success(let data):
//                    completion(.success(data))
//                case .failure(.invalidURL):
//                    completion(.failure(.custom(errorMessage: "The user couldn't be registered")))
//                case .failure(.noData):
//                    completion(.failure(.custom(errorMessage: "No Data")))
//                case .failure(.decodingError):
//                    completion(.failure(.invalidCredentials))
//            }
        }
    }
}
