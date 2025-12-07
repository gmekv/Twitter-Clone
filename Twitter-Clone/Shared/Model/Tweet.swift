//
//  Tweet.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 28.11.25.
//

import SwiftUI

struct Tweet: Identifiable, Decodable {
    let id: String
    let text: String
    let user: String
    let username: String
    let userID: String
    let image: String?
    let likes: [String]
    let createdAt: String
    let updatedAt: String
    var didLike: Bool? = false

    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case text
        case user
        case username
        case userID
        case image
        case likes
        case createdAt
        case updatedAt
    }
}
