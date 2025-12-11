
import Foundation
 
struct ApiResponse: Codable {
    let token: String?
    let user: User
}

struct User: Codable {
    var _id: String

    var id: String {
        return _id
    }
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
    var avatarExists: Bool?
    var isCurrentUser: Bool? = false
    var isFollowed: Bool? = false
    
}
