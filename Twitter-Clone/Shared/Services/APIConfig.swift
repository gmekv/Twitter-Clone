//
//  APIConfig.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 06.01.26.
//

import Foundation

struct APIConfig {
    // MARK: - Base URL Configuration
    
    // Production URL (Render)
    static let baseURL = "https://twitter-api-3qt3.onrender.com"
    
    // Uncomment for local development:
    // static let baseURL = "http://localhost:3000"
    
    // MARK: - Endpoints
    
    struct Endpoints {
        // Auth endpoints
        static let login = "\(baseURL)/users/login"
        static let register = "\(baseURL)/users"
        
        // User endpoints
        static func user(id: String) -> String {
            return "\(baseURL)/users/\(id)"
        }
        
        static func userAvatar(id: String) -> String {
            return "\(baseURL)/users/\(id)/avatar"
        }
        
        static func updateUser(id: String) -> String {
            return "\(baseURL)/users/\(id)"
        }
        
        static func follow(id: String) -> String {
            return "\(baseURL)/users/\(id)/follow"
        }
        
        static func unfollow(id: String) -> String {
            return "\(baseURL)/users/\(id)/unfollow"
        }
        
        static let allUsers = "\(baseURL)/users"
        
        // Tweet endpoints
        static let tweets = "\(baseURL)/tweets"
        
        static func userTweets(userId: String) -> String {
            return "\(baseURL)/tweets/\(userId)"
        }
        
        static func likeTweet(id: String) -> String {
            return "\(baseURL)/tweets/\(id)/like"
        }
        
        static func unlikeTweet(id: String) -> String {
            return "\(baseURL)/tweets/\(id)/unlike"
        }
        
        // Notification endpoints
        static let notifications = "\(baseURL)/notifications"
        
        // Image upload paths (for ImageUploader)
        static func uploadAvatar() -> String {
            return "/users/me/avatar"
        }
        
        static func uploadTweetImage(tweetId: String) -> String {
            return "/uploadTweetImage/\(tweetId)"
        }
    }
}
