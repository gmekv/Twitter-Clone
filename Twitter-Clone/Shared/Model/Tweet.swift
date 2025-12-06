//
//  Tweet.swift
//  Twitter-Clone
//
//  Created by Giorgi Mekvabishvili on 28.11.25.
//

import SwiftUI


struct Tweet: Identifiable, Decodable {
    let _id: String
    var id: String {
        return _id
    }
    
    let text: String
    let userId: String
    let username: String
    let user: String
}


