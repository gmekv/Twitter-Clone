//
//  ImageUploader.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 05.12.25.
//

import SwiftUI
import OSLog

struct ImageUploader {
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.app", category: "ImageUploader")
    
    static func upload(paramName: String, fileName: String, image: UIImage, urlPath: String)  {
        
        logger.info("🚀 Image Upload: Starting image upload")
        logger.debug("Image Upload: Parameters - paramName: \(paramName), fileName: \(fileName), urlPath: \(urlPath)")
        
        let url = URL(string: "\(APIConfig.baseURL)\(urlPath)")
        let boundary = UUID().uuidString
        let session = URLSession.shared
        
        guard let url = url else {
            logger.error("❌ Image Upload: Failed to create URL from path: \(urlPath)")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        // Authentication
        guard let token = UserDefaults.standard.string(forKey: "jsonwebtoken") else {
            logger.error("❌ Image Upload: No authentication token found in UserDefaults")
            return
        }
        
        logger.debug("🔐 Image Upload: Adding authentication token")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        
        guard let imageData = image.pngData() else {
            logger.error("❌ Image Upload: Failed to convert image to PNG data")
            return
        }
        
        logger.info("📦 Image Upload: Image data size: \(imageData.count) bytes")
        data.append(imageData)
        
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        logger.info("📤 Image Upload: Uploading image (total data size: \(data.count) bytes)")
        
        session.uploadTask(with: urlRequest, from: data) { responseData, response, error in
            if let error = error {
                logger.error("❌ Image Upload: Upload failed with error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                logger.info("📥 Image Upload: Received response with status code: \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                    logger.info("✅ Image Upload: Upload successful")
                } else {
                    logger.warning("⚠️ Image Upload: Upload completed with non-success status code: \(httpResponse.statusCode)")
                }
            }
            
            if let responseData = responseData {
                logger.debug("Image Upload: Response data size: \(responseData.count) bytes")
                
                if let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
                    if let json = jsonData as? [String: Any] {
                        logger.debug("Image Upload: Response JSON: \(String(describing: json))")
                    }
                } else if let responseString = String(data: responseData, encoding: .utf8) {
                    logger.debug("Image Upload: Response string: \(responseString)")
                }
            } else {
                logger.warning("⚠️ Image Upload: No response data received")
            }
        }.resume()
    }
    
    static func changeImage(paramName: String, fileName: String, image: UIImage, urlPath: String) {
        logger.info("🔄 Image Change: Starting image change")
        logger.debug("Image Change: Parameters - paramName: \(paramName), fileName: \(fileName), urlPath: \(urlPath)")
        
        let url = URL(string: "\(APIConfig.baseURL)\(urlPath)")
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString

        let session = URLSession.shared

        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "PATCH"

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        print("Bearer \(token)")
        
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            }
        }).resume()
    }
    
    static func deleteImage(paramName: String, fileName: String, image: UIImage, urlPath: String) {
        logger.info("🗑️ Image Delete: Starting image deletion")
        logger.debug("Image Delete: Parameters - paramName: \(paramName), fileName: \(fileName), urlPath: \(urlPath)")
        
        let url = URL(string: "\(APIConfig.baseURL)\(urlPath)")
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString

        let session = URLSession.shared

        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "DELETE"

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!
        print("Bearer \(token)")
        
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            }
        }).resume()
    }

}
