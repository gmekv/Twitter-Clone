//
//  Profile.swift
//  twitter-clone (iOS)
//
//  Created by cem on 9/18/21.
//

import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var tweets = [Tweet]()
    @Published var user: User
    
    init(user: User) {
        self.user = user
//        let defaults = UserDefaults.standard
//        let token = defaults.object(forKey: "jsonwebtoken")
//
//        if token != nil {
//            if let userId = defaults.object(forKey: "userid") {
//                fetchUser(userId: userId as! String)
//            }
//        }
        fetchTweets()
        checkIfIsCurrentUser()
        checkIfUserIsFollowed()
    }
    
    func fetchTweets() {
        
        RequestServices.requestDomain = APIConfig.Endpoints.userTweets(userId: self.user.id)
        
        RequestServices.fetchData { res in
            switch res {
                case .success(let data):
                    guard let tweets = try? JSONDecoder().decode([Tweet].self, from: data as! Data) else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.tweets = tweets
                    }

                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func uploadProfileImage(text: String, image: UIImage?) {
        
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        if let image = image {
            ImageUploader.upload(paramName: "avatar", fileName: "image1", image: image, urlPath: "/users/me/avatar")
        }
    }
    
    func follow() {
        guard let authedUser = AuthViewModel.shared.currentUser else { return }
        
        RequestServices.requestDomain = APIConfig.Endpoints.follow(id: self.user.id)
        
        RequestServices.followingProcess(id: self.user.id) { result in
            print(result)
            print("Followed")
        }
        RequestServices.requestDomain = APIConfig.Endpoints.notifications
        RequestServices.sendNotification(username: authedUser.username, notSenderId: authedUser.id, notReceiverId: self.user.id, notificationType: NotificationType.follow.rawValue, postText: "") { result in
            print("FOLLOWED")
            print(result)
        }
        print("Followed")
        self.user.isFollowed = true
    }
    
    func unfollow() {
        RequestServices.requestDomain = APIConfig.Endpoints.unfollow(id: self.user.id)
        
        RequestServices.followingProcess(id: self.user.id) { result in
            print(result)
            print("Unfollowed")
        }
        print("Unfollowed")
        self.user.isFollowed = false
    }
    
    func checkIfUserIsFollowed() {
//        if (self.tweet.likes.contains(self.currentUser.id)) {
//            self.tweet.didLike = true
//        }
//        else {
//            self.tweet.didLike = false
//        }
        
        if (self.user.followers.contains(AuthViewModel.shared.currentUser!._id)) {
            self.user.isFollowed = true
        }
        else {
            self.user.isFollowed = false
        }
    }
    
    func checkIfIsCurrentUser() {
        if (self.user._id == AuthViewModel.shared.currentUser?._id) {
//            AuthViewModel.shared.currentUser?.isCurrentUser = true
            self.user.isCurrentUser = true
        }
    }
    
    func fetchUser(userId: String) {
        print(userId)
        
        let defaults = UserDefaults.standard
        AuthServices.requestDomain = APIConfig.Endpoints.user(id: userId)
        
        AuthServices.fetchUser(id: userId) { res in
            switch res {
                case .success(let data):
                    guard let user = try? JSONDecoder().decode(User.self, from: data as! Data) else {
                        return
                    }
                    DispatchQueue.main.async {
                        defaults.setValue(user.id, forKey: "userid")
                        self.user = user
                        print(user)
                    }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
