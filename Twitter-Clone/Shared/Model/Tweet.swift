//
//  Tweet.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 28.11.25.
//

import SwiftUI

struct Tweet: Identifiable, Decodable {
    let _id: String
    let text: String
    let userId: String
    let username: String
    let user: String
    var id: String {
        return _id
    }
    let image: String?
    var likes : [String]
    var didLike: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case _id
        case text
        case userId = "userID"  // Maps backend's "userID" to Swift's "userId"
        case username
        case user
        case image
        case likes
    }
}

