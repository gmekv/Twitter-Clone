
import Foundation
 
struct ApiResponse: Codable {
    let token: String?
    let user: User
}

struct User: Codable {
    let id: String
    let name: String
    let username: String
    let email: String
    let followers: [String]
    let following: [String]
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case username
        case email
        case followers
        case following
        case createdAt
        case updatedAt
    }
}
