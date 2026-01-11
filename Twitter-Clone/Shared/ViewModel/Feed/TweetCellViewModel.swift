//
//  TweetCellViewModel.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 06.12.25.
//

import Foundation
import SwiftUI
import Combine

class TweetCellViewModel: ObservableObject {
    
    @Published var tweet: Tweet
    @Published var user: User?
    let currentUser: User
    @State var liked = false
    
    
    init(tweet: Tweet, currentUser: User) {
        self.tweet = tweet
        self.currentUser = currentUser
        
        self.fetchUser(userId: tweet.userId)     
        checkIfUserLikedPost()
        
    }
    
    func fetchUser(userId: String) {
        AuthServices.requestDomain = APIConfig.Endpoints.user(id: userId)
        
        AuthServices.fetchUser(id: userId) { res in
            switch res {
                case .success(let data):
                    guard let user = try? JSONDecoder().decode(User.self, from: data as! Data) else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.user = user
                        print(user)
                    }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func likeTweet() {
        RequestServices.requestDomain = APIConfig.Endpoints.likeTweet(id: self.tweet.id)
        
        RequestServices.likeTweet(id: self.tweet.id) { result in
            print("Tweet has been liked")
            print("Console log: \(result)")
            
        }
        RequestServices.requestDomain = APIConfig.Endpoints.notifications
        RequestServices.sendNotification(username: self.currentUser.username, notSenderId: self.currentUser.id, notReceiverId: self.tweet.userId, notificationType: NotificationType.like.rawValue, postText: self.tweet.text) { result in
            print(result)
        }
        self.tweet.didLike = true
    }
    
    func unlikeTweet() {
        RequestServices.requestDomain = APIConfig.Endpoints.unlikeTweet(id: self.tweet.id)
        
        RequestServices.likeTweet(id: self.tweet.id) { result in
            print("Tweet has been unliked")
            
            
        }
        self.tweet.didLike = false
    }
    
    func checkIfUserLikedPost() {
        if (self.tweet.likes.contains(self.currentUser.id)) {
            self.tweet.didLike = true
        }
        else {
            self.tweet.didLike = false
        }
    }
}
