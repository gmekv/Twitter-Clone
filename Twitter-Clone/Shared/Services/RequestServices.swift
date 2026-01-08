//
//  RequestServices.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 28.11.25.
//

import Foundation
import OSLog

public class RequestServices {
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.app", category: "RequestServices")
    public static var requestDomain = ""
    public static func postTweet(text: String, user: String, username: String, userId: String, completion: @escaping(_ result: [String: Any]?) -> Void) {
        
        let params = ["text": text, "userId": userId, "user": user, "username": username] as [String: Any]
        let url = URL(string: requestDomain)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }
        catch let error {
            print(error)
        }
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
        
        request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                completion(json)
            }
            catch let error {
                
            }
        }
        task.resume()
    }
    
    static func fetchTweets() async throws -> [Tweet] {
        logger.info("🔄 Starting to fetch tweets")
        
        guard let url = URL(string: APIConfig.Endpoints.tweets) else {
            logger.error("❌ Failed to create URL for tweets endpoint")
            throw(URLError(.badURL))
        }
        
        logger.debug("📍 URL created: \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
        guard let validatedtoken = token else {
            logger.error("❌ No authentication token found in UserDefaults")
            throw(URLError(.userAuthenticationRequired))
        }
        
        logger.debug("🔐 Adding authentication token to request")
        request.addValue("Bearer \(validatedtoken)", forHTTPHeaderField: "Authorization")
        
        logger.info("📤 Sending GET request to fetch tweets")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        logger.debug("📥 Received response, data size: \(data.count) bytes")
        
        guard let httpResponse = response as? HTTPURLResponse else {
            logger.error("❌ Response is not an HTTPURLResponse")
            throw URLError(.badServerResponse)
        }
        
        logger.info("📊 HTTP Status Code: \(httpResponse.statusCode)")
        
        guard httpResponse.statusCode == 200 else {
            logger.error("❌ Bad server response with status code: \(httpResponse.statusCode)")
            
            // Log response body for debugging
            if let responseString = String(data: data, encoding: .utf8) {
                logger.debug("Response body: \(responseString)")
            }
            
            throw URLError(.badServerResponse)
        }
        
        logger.debug("📝 Attempting to decode JSON response")
        
        do {
            let tweets = try JSONDecoder().decode([Tweet].self, from: data)
            logger.info("✅ Successfully decoded \(tweets.count) tweets")
            return tweets
        } catch {
            logger.error("❌ Failed to decode tweets: \(error.localizedDescription)")
            
            // Log raw JSON for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                logger.debug("Raw JSON: \(jsonString)")
            }
            
            throw error
        }
    }
    static func fetchData(completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
            
            let url = URL(string: requestDomain)!
            
            let session = URLSession.shared
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
           
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            let task = session.dataTask(with: request) { data, res, err in
                guard err == nil else {
                    completion(.failure(.noData))
                    return
                    
                }
                
                guard let data = data else { return }
                
                completion(.success(data))
            }
            
            task.resume()
    }
    
    public static func likeTweet(id: String, completion: @escaping (_ result: [String:Any]?) -> Void) {
        
            let params = ["id" : id] as [String : Any]
            
            let url = URL(string: requestDomain)!
            
            let session = URLSession.shared
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "PUT"
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
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
                guard err == nil else { return }
                
                guard let data = data else { return }
                
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        completion(json)
                    }
                }
                catch let error {
                    print(error)
                }
            }
            
            task.resume()
    }
    
    public static func followingProcess(id: String, completion: @escaping (_ result: [String:Any]?) -> Void) {
        
            let params = ["id" : id] as [String : Any]
            
            let url = URL(string: requestDomain)!
            
            let session = URLSession.shared
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "PUT"
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
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
                guard err == nil else { return }
                
                guard let data = data else { return }
                
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        completion(json)
                    }
                }
                catch let error {
                    print(error)
                }
            }
            
            task.resume()
    }
    
    public static func sendNotification(username: String, notSenderId: String, notReceiverId: String, notificationType: String, postText: String, completion: @escaping (_ result: [String:Any]?) -> Void) {
        
        
            var params : [String: Any] {
                return postText.isEmpty ? ["username": username, "notSenderId": notSenderId, "notReceiverId": notReceiverId, "notificationType": notificationType] as [String : Any] : ["username": username, "notSenderId": notSenderId, "notReceiverId": notReceiverId, "notificationType": notificationType, "postText": postText] as [String : Any]
            }
            
            let url = URL(string: requestDomain)!
            
            let session = URLSession.shared
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
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
                guard err == nil else { return }
                
                guard let data = data else { return }
                
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        completion(json)
                    }
                }
                catch let error {
                    print(error)
                }
            }
            
            task.resume()
    }

}
