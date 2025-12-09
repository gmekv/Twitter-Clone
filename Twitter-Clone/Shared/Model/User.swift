
import Foundation
 
struct ApiResponse: Codable {
    let token: String?
    let user: User
}

struct User: Codable {
    let id: String
    var name: String
    let username: String
    var email: String
    var followers: [String]
    var following: [String]
    let createdAt: String
    let updatedAt: String
    var bio: String?
    var website: String?
    var location: String?
    
    
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
