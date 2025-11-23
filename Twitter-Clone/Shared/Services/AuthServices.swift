
import Foundation
import SwiftUI

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct LoginRequestBody: Codable {
    let username: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}

public class AuthServices {
    public static var requestDomain = ""
    
    static func login(email: String, password: String, completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void) {
        let urlString = URL(string: "http://localhost:3000/users/login")!
        print(urlString)
        makeRequest(urlString: urlString, reqBody: ["email": email, "password": password]) { res in
            switch res {
                case .success(let data):
                    completion(.success(data))
            case .failure(let error):
                completion(.failure(.invalidCredentials))
                print(error.localizedDescription)
            }
        }
    }
    
    
    static func register(email: String, username: String, password: String, name: String, completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void) {
        let urlString = URL(string: "http://localhost:3000/users")!
        makeRequest(urlString: urlString, reqBody: ["email": email, "username": username, "name": name, "password": password, "avatar": nil]) { res in
            switch res {
                case .success(let data):
                    completion(.success(data))
                case .failure(.invalidURL):
                    completion(.failure(.custom(errorMessage: "The user couldn't be registered")))
                case .failure(.noData):
                    completion(.failure(.custom(errorMessage: "No Data")))
                case .failure(.decodingError):
                    completion(.failure(.invalidCredentials))
            }
        }
    }
    
    static func makeRequest(urlString: URL, reqBody: [String: Any], completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
//        let urlRequest = URLRequest(url: urlString)
//
//        let url = URL(string: requestDomain)!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: urlString)
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted)
        }
        catch let error {
            print(error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {
                
                return
                
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
                
            }
            
            completion(.success(data))
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    
                }
            }
            catch let error {
                completion(.failure(.decodingError))
                print(error)
            }
        }
        
        task.resume()
    }
    
    
    // Gotta change this
    
    static func makeRequestWithAuth(urlString: URL, reqBody: [String: Any], completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        
//        let urlRequest = URLRequest(url: urlString)
//
//        let url = URL(string: requestDomain)!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: urlString)
        
        request.httpMethod = "PATCH"
        
        let boundary = UUID().uuidString
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted)
        }
        catch let error {
            print(error)
        }
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        print("Bearer \(token)")
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        

        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {
                
                return
                
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
                
            }
            
            completion(.success(data))
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    
                }
                
//                guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data as! Data) else {
//                    print("erre")
//                    return
//                }
//
//                print(user)
                
            }
            catch let error {
                completion(.failure(.decodingError))
                print(error)
            }
        }
        
        task.resume()
    }
    
    static func makePatchRequestWithAuth(urlString: URL, reqBody: [String: Any], completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        
//        let urlRequest = URLRequest(url: urlString)
//
//        let url = URL(string: requestDomain)!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: urlString)
        
        request.httpMethod = "PATCH"
        
        let boundary = UUID().uuidString
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted)
        }
        catch let error {
            print(error)
        }
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        print("Bearer \(token)")
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        

        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {
                
                return
                
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
                
            }
            
            completion(.success(data))
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    
                }
                
//                guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data as! Data) else {
//                    print("erre")
//                    return
//                }
//
//                print(user)
                
            }
            catch let error {
                completion(.failure(.decodingError))
                print(error)
            }
        }
        
        task.resume()
    }
    
    
    static func fetchUser(id: String, completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void) {
        
        let urlString = URL(string: "http://localhost:3000/users/\(id)")!
        
        let urlRequest = URLRequest(url: urlString)
        
        let url = URL(string: requestDomain)!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
            
        request.httpMethod = "GET"
        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted)
//        }
//        catch let error {
//            print(error)
//        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {
                
                return
                
            }
            
            guard let data = data else {
                completion(.failure(.invalidCredentials))
                return
                
            }
            
            completion(.success(data))
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    
                }
                
            }
            catch let error {
                completion(.failure(.invalidCredentials))
                print(error)
            }
        }
        
        task.resume()
    }
    
    static func fetchUsers(completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void) {
        
        let urlString = URL(string: "http://localhost:3000/users")!
        
        let urlRequest = URLRequest(url: urlString)
        
        let url = URL(string: requestDomain)!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
            
        request.httpMethod = "GET"
        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted)
//        }
//        catch let error {
//            print(error)
//        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {
                
                return
                
            }
            
            guard let data = data else {
                completion(.failure(.invalidCredentials))
                return
                
            }
            
            completion(.success(data))
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    
                }
                
            }
            catch let error {
                completion(.failure(.invalidCredentials))
                print(error)
            }
        }
        
        task.resume()
    }
}

