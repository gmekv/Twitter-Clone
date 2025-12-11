
import Foundation
import SwiftUI

enum AuthenticationError: Error, LocalizedError {
    case invalidCredentials
    case custom(errorMessage: String)
    case networkError
    case serverError(statusCode: Int)
    case invalidResponse
    case noData
    case decodingError
    case unauthorized
    case timeout
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid email or password. Please try again."
        case .custom(let message):
            return message
        case .networkError:
            return "Network connection failed. Please check your internet connection."
        case .serverError(let statusCode):
            return "Server error occurred (Code: \(statusCode)). Please try again later."
        case .invalidResponse:
            return "Invalid response from server."
        case .noData:
            return "No data received from server."
        case .decodingError:
            return "Failed to process server response."
        case .unauthorized:
            return "Your session has expired. Please log in again."
        case .timeout:
            return "Request timed out. Please try again."
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case networkUnavailable
    case timeout
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode response"
        case .serverError(let statusCode):
            return "Server error: \(statusCode)"
        case .networkUnavailable:
            return "Network unavailable"
        case .timeout:
            return "Request timed out"
        }
    }
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
        guard let urlString = URL(string: "http://localhost:3000/users/login") else {
            completion(.failure(.custom(errorMessage: "Invalid URL configuration")))
            return
        }
        
        print("Login request to: \(urlString)")
        
        makeRequest(urlString: urlString, reqBody: ["email": email, "password": password]) { res in
            switch res {
            case .success(let data):
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                completion(.success(data))
            case .failure(let error):
                print("Login error: \(error.localizedDescription)")
                
                // Map network errors to authentication errors
                switch error {
                case .noData:
                    completion(.failure(.noData))
                case .decodingError:
                    completion(.failure(.decodingError))
                case .serverError(let statusCode):
                    if statusCode == 401 || statusCode == 403 {
                        completion(.failure(.invalidCredentials))
                    } else {
                        completion(.failure(.serverError(statusCode: statusCode)))
                    }
                case .networkUnavailable:
                    completion(.failure(.networkError))
                case .timeout:
                    completion(.failure(.timeout))
                default:
                    completion(.failure(.custom(errorMessage: error.localizedDescription)))
                }
            }
        }
    }
    
    
    static func register(email: String, username: String, password: String, name: String, completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void) {
        let urlString = URL(string: "http://localhost:3000/users")!
        print("Register request to: \(urlString)")
        print("Registration details - email: \(email), username: \(username), name: \(name)")
        
        makeRequest(urlString: urlString, reqBody: ["email": email, "username": username, "name": name, "password": password, "avatar": nil]) { res in
            switch res {
                case .success(let data):
                    print("Registration successful")
                    completion(.success(data))
                case .failure(.invalidURL):
                    print("Registration failed: Invalid URL")
                    completion(.failure(.custom(errorMessage: "The user couldn't be registered")))
                case .failure(.noData):
                    print("Registration failed: No data")
                    completion(.failure(.custom(errorMessage: "No Data")))
                case .failure(.decodingError):
                    print("Registration failed: Decoding error")
                    completion(.failure(.invalidCredentials))
                case .failure(.serverError(let statusCode)):
                    print("Registration failed: Server error \(statusCode)")
                    completion(.failure(.serverError(statusCode: statusCode)))
                case .failure(.networkUnavailable):
                    print("Registration failed: Network unavailable")
                    completion(.failure(.networkError))
                case .failure(.timeout):
                    print("Registration failed: Timeout")
                    completion(.failure(.timeout))
            }
        }
    }
    
    static func makeRequest(urlString: URL, reqBody: [String: Any], completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
//        let urlRequest = URLRequest(url: urlString)
//
//        let url = URL(string: requestDomain)!
        
        print("Making request to: \(urlString)")
        print("Request body: \(reqBody)")
        
        let session = URLSession.shared
        
        var request = URLRequest(url: urlString)
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted)
        }
        catch let error {
            print("Error serializing request body: \(error)")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = session.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Request error: \(err.localizedDescription)")
                return
            }
            
            if let httpResponse = res as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(.noData))
                return
            }
            
            print("Data received: \(data.count) bytes")
            
            completion(.success(data))
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("Response JSON: \(json)")
                }
            }
            catch let error {
                print("JSON parsing error: \(error)")
                completion(.failure(.decodingError))
            }
        }
        
        print("Starting request task...")
        task.resume()
    }
    
    
    // Gotta change this
    
    static func makeRequestWithAuth(urlString: URL, reqBody: [String: Any], completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        
//        let urlRequest = URLRequest(url: urlString)
//
//        let url = URL(string: requestDomain)!
        
        print("Making authenticated request to: \(urlString)")
        print("Request body: \(reqBody)")
        
        let session = URLSession.shared
        
        var request = URLRequest(url: urlString)
        
        request.httpMethod = "PATCH"
        
        let boundary = UUID().uuidString
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted)
        }
        catch let error {
            print("Error serializing request body: \(error)")
        }
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        print("Bearer \(token)")
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        

        let task = session.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Authenticated request error: \(err.localizedDescription)")
                return
            }
            
            if let httpResponse = res as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("No data received from authenticated request")
                completion(.failure(.noData))
                return
            }
            
            print("Authenticated request data received: \(data.count) bytes")
            
            completion(.success(data))
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("Response JSON: \(json)")
                }
                
//                guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data as! Data) else {
//                    print("erre")
//                    return
//                }
//
//                print(user)
                
            }
            catch let error {
                print("JSON parsing error: \(error)")
                completion(.failure(.decodingError))
            }
        }
        
        print("Starting authenticated request task...")
        task.resume()
    }
    
    static func makePatchRequestWithAuth(urlString: URL, reqBody: [String: Any], completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        
//        let urlRequest = URLRequest(url: urlString)
//
//        let url = URL(string: requestDomain)!
        
        print("Making PATCH request with auth to: \(urlString)")
        print("Request body: \(reqBody)")
        
        let session = URLSession.shared
        
        var request = URLRequest(url: urlString)
        
        request.httpMethod = "PATCH"
        
        let boundary = UUID().uuidString
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted)
        }
        catch let error {
            print("Error serializing request body: \(error)")
        }
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        print("Bearer \(token)")
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        

        let task = session.dataTask(with: request) { data, res, err in
            if let err = err {
                print("PATCH request error: \(err.localizedDescription)")
                return
            }
            
            if let httpResponse = res as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("No data received from PATCH request")
                completion(.failure(.noData))
                return
            }
            
            print("PATCH request data received: \(data.count) bytes")
            
            completion(.success(data))
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("Response JSON: \(json)")
                }
                
//                guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data as! Data) else {
//                    print("erre")
//                    return
//                }
//
//                print(user)
                
            }
            catch let error {
                print("JSON parsing error: \(error)")
                completion(.failure(.decodingError))
            }
        }
        
        print("Starting PATCH request task...")
        task.resume()
    }
    
    
    static func fetchUser(id: String, completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void) {
        
        let urlString = URL(string: "http://localhost:3000/users/\(id)")!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: urlString)
            
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = session.dataTask(with: request) { data, res, err in
            if let err = err {
                print("❌ Fetch user error occurred:")
                print("  - Error description: \(err.localizedDescription)")
                print("  - Error domain: \((err as NSError).domain)")
                print("  - Error code: \((err as NSError).code)")
                print("  - Underlying error: \((err as NSError).userInfo)")
                
                // Map specific NSURLError codes to AuthenticationError
                let nsError = err as NSError
                if nsError.domain == NSURLErrorDomain {
                    switch nsError.code {
                    case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost:
                        completion(.failure(.networkError))
                    case NSURLErrorTimedOut:
                        completion(.failure(.timeout))
                    case NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost:
                        completion(.failure(.custom(errorMessage: "Cannot connect to server at \(urlString.absoluteString)")))
                    default:
                        completion(.failure(.custom(errorMessage: "Network error: \(err.localizedDescription)")))
                    }
                } else {
                    completion(.failure(.custom(errorMessage: err.localizedDescription)))
                }
                return
            }
            
            if let httpResponse = res as? HTTPURLResponse {
                print("Fetch user response status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("No data received for user fetch")
                completion(.failure(.invalidCredentials))
                return
            }
            
            print("User data received: \(data.count) bytes")
            
            completion(.success(data))
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("User JSON: \(json)")
                }
                
            }
            catch let error {
                print("User JSON parsing error: \(error)")
                completion(.failure(.invalidCredentials))
            }
        }
        
        print("Starting fetch user task...")
        task.resume()
    }
    
    static func fetchUsers(completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void) {
        
        let urlString = URL(string: "http://localhost:3000/users")!
        
        print("Fetching all users")
        print("Request URL: \(urlString)")
        
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
            if let err = err {
                print("Fetch users error: \(err.localizedDescription)")
                return
            }
            
            if let httpResponse = res as? HTTPURLResponse {
                print("Fetch users response status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("No data received for users fetch")
                completion(.failure(.invalidCredentials))
                return
            }
            
            print("Users data received: \(data.count) bytes")
            
            completion(.success(data))
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("Users JSON: \(json)")
                }
                
            }
            catch let error {
                print("Users JSON parsing error: \(error)")
                completion(.failure(.invalidCredentials))
            }
        }
        
        print("Starting fetch users task...")
        task.resume()
    }
}

