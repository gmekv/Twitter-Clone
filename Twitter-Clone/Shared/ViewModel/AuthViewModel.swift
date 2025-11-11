//
//  AuthViewModel.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 21.11.25.
//

import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    
    func login() {
        print("[AuthViewModel] login() called")
    }
    
    func register(reqBody: [String: Any]) {
        print("[AuthViewModel] register() called with body: \(reqBody)")
        guard let url = URL(string: "http://localhost:3000/users") else {
            print("[AuthViewModel] Failed to build URL for registration endpoint")
            return
        }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        print("[AuthViewModel] Configured request: URL=\(url.absoluteString), method=POST")
        
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted)
            request.httpBody = bodyData
            let bodyString = String(data: bodyData, encoding: .utf8) ?? "<non-UTF8 body>"
            print("[AuthViewModel] Encoded HTTP body (\(bodyData.count) bytes):\n\(bodyString)")
        } catch let error {
            print("[AuthViewModel] Failed to encode request body: \(error)")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        print("[AuthViewModel] Request headers set: Content-Type=application/json, Accept=application/json")
        let task = session.dataTask(with: request) { data, res, err in
            print("[AuthViewModel] register() response received")
            if let err = err {
                print("[AuthViewModel] Network error: \(err)")
                return
            }
            if let httpRes = res as? HTTPURLResponse {
                print("[AuthViewModel] HTTP status: \(httpRes.statusCode)")
                print("[AuthViewModel] Response headers: \(httpRes.allHeaderFields)")
            } else {
                print("[AuthViewModel] Response was not an HTTPURLResponse")
            }
            guard let data = data else {
                print("[AuthViewModel] No data in response")
                return
            }
            let rawString = String(data: data, encoding: .utf8) ?? "<non-UTF8 response>"
            print("[AuthViewModel] Raw response body:\n\(rawString)")
            do {
                let obj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                print("[AuthViewModel] Parsed JSON: \(obj)")
            } catch let error {
                print("[AuthViewModel] JSON parsing error: \(error)")
            }
        }
        task.resume()
        print("[AuthViewModel] Registration request started")
    }
    func logout() {
        print("[AuthViewModel] logout() called")
    }
}

