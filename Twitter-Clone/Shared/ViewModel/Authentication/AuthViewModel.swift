//
//  AuthViewModel.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 21.11.25.
//


import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?

    
    init() {
        print("AuthViewModel init called")
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: "jsonwebtoken")
        
        print("Token exists: \(token != nil)")
        
        if token != nil {
            isAuthenticated = true
            
            if let userId = defaults.object(forKey: "userid") {
                print("User ID found: \(userId)")
                fetchUser(userId: userId as! String)
                print("User fetched")
            } else {
                print("No user ID found in UserDefaults")
            }
            
        }
        else {
            print("No token found - user not authenticated")
            isAuthenticated = false
        }
    }
    
    static let shared = AuthViewModel()
        
    func login(email: String, password: String) {
        print("=== LOGIN STARTED ===")
        print("Email: \(email)")
        
        let defaults = UserDefaults.standard
        
        AuthServices.requestDomain = "http://localhost:3000/users/login"
        print("Request domain set to: \(AuthServices.requestDomain)")
        
        AuthServices.login(email: email, password: password) { res in
            print("Login response received")
            
            switch res {
                case .success(let data):
                    print("Login success! Data received")
                    
                    guard let data = data else {
                        print("❌ ERROR: Data is nil")
                        return
                    }
                    
                    print("Data size: \(data.count) bytes")
                    
                    // Try to print raw JSON
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Raw JSON response: \(jsonString)")
                    }
                    
                    guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data) else {
                        print("❌ ERROR: Failed to decode ApiResponse")
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("JSON that failed to decode: \(jsonString)")
                        }
                        return
                    }
                    
                    print("✅ Successfully decoded ApiResponse")
                    print("Token: \(user.token ?? "nil")")
                    print("User ID: \(user.user.id)")
                    print("User email: \(user.user.email)")
                    
                    DispatchQueue.main.async {
                        defaults.setValue(user.token, forKey: "jsonwebtoken")
                        defaults.setValue(user.user.id, forKey: "userid")
                        
                        print("Saved token to UserDefaults: \(user.token ?? "nil")")
                        print("Saved user ID to UserDefaults: \(user.user.id)")
                        
                        self.isAuthenticated = true
                        self.currentUser = user.user
                        
                        print("✅ Login complete - isAuthenticated: \(self.isAuthenticated)")
                        print("Current user: \(user.user.username)")
                    }
                    
                case .failure(let error):
                    print("❌ LOGIN FAILED")
                    print("Error: \(error.localizedDescription)")
                    if let authError = error as? AuthenticationError {
                        print("Authentication error type: \(authError)")
                    }
            }
            
        }
        
    }
    
    func register(name: String, username: String, email: String, password: String) {
        print("=== REGISTRATION STARTED ===")
        print("Name: \(name)")
        print("Username: \(username)")
        print("Email: \(email)")
        
        let defaults = UserDefaults.standard
        
        AuthServices.register(email: email, username: username, password: password, name: name) { res in
            print("Registration response received")
            
            switch res {
                case .success(let data):
                    print("Registration success! Data received")
                    
                    guard let data = data else {
                        print("❌ ERROR: Data is nil")
                        return
                    }
                    
                    print("Data size: \(data.count) bytes")
                    
                    // Try to print raw JSON
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Raw JSON response: \(jsonString)")
                    }
                    
                    guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data) else {
                        print("❌ ERROR: Failed to decode ApiResponse")
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("JSON that failed to decode: \(jsonString)")
                        }
                        return
                    }
                    
                    print("✅ Successfully decoded ApiResponse")
                    print("Token: \(user.token ?? "nil")")
                    print("User ID: \(user.user.id)")
                    print("User email: \(user.user.email)")
                    print("User username: \(user.user.username)")
                    
                    DispatchQueue.main.async {
                        defaults.setValue(user.token, forKey: "jsonwebtoken")
                        defaults.setValue(user.user.id, forKey: "userid")
                        
                        print("Saved token to UserDefaults: \(user.token ?? "nil")")
                        print("Saved user ID to UserDefaults: \(user.user.id)")
                        
                        self.isAuthenticated = true
                        self.currentUser = user.user
                        
                        print("✅ Registration complete - isAuthenticated: \(self.isAuthenticated)")
                        print("Current user: \(user.user.username)")
                    }
                    
                case .failure(let error):
                    print("❌ REGISTRATION FAILED")
                    print("Error: \(error.localizedDescription)")
                    if let authError = error as? AuthenticationError {
                        print("Authentication error type: \(authError)")
                    }
            }
        }
    }
    
    
    func fetchUser(userId: String) {
        print(userId)
        
        let defaults = UserDefaults.standard
        
        AuthServices.fetchUser(id: userId) { res in
            switch res {
                case .success(let data):
                    guard let user = try? JSONDecoder().decode(User.self, from: data as! Data) else {
                        return
                    }
                    DispatchQueue.main.async {
                        defaults.setValue(user.id, forKey: "userid")
                        self.isAuthenticated = true
                        self.currentUser = user
                        print(user)
                    }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func logout() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()

            dictionary.keys.forEach
            { key in   defaults.removeObject(forKey: key)
            }
        
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
}


