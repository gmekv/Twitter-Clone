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
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: "jsonwebtoken")
        
        if token != nil {
            isAuthenticated = true
            
            if let userId = defaults.object(forKey: "userid") {
                fetchUser(userId: userId as! String)
                print("User fetched")
            }
            
        }
        else {
            isAuthenticated = false
        }
    }
    
    static let shared = AuthViewModel()
        
    func login(email: String, password: String) {
        
        let defaults = UserDefaults.standard
        
        AuthServices.requestDomain = "http://localhost:3000/users/login"
        AuthServices.login(email: email, password: password) { res in
            
            switch res {
                case .success(let data):
                    guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data as! Data) else {
                        return
                    }
                    DispatchQueue.main.async {
                        defaults.setValue(user.token, forKey: "jsonwebtoken")
                        defaults.setValue(user.user.id, forKey: "userid")
                        self.isAuthenticated = true
                        self.currentUser = user.user
                    }
                    print(user.user.email)
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
        }
        
    }
    
    func register(name: String, username: String, email: String, password: String) {
        
        let defaults = UserDefaults.standard
        
        AuthServices.register(email: email, username: username, password: password, name: name) { res in
            switch res {
                case .success(let data):
                    guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data as! Data) else {
                        return
                    }
                    DispatchQueue.main.async {
                        defaults.setValue(user.token, forKey: "jsonwebtoken")
                        defaults.setValue(user.user.id, forKey: "userid")
                        self.isAuthenticated = true
                        self.currentUser = user.user
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                
                
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


