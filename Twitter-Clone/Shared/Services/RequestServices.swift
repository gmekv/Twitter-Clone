//
//  RequestServices.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 28.11.25.
//

import Foundation


public class RequestServices {
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
}
