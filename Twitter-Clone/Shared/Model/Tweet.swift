//
//  Tweet.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 28.11.25.
//

import SwiftUI

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
}

