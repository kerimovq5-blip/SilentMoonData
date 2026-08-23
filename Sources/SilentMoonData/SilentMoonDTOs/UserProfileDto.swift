import Foundation
import SilentMoonDomain

public struct UserProfileDto: Decodable, Sendable {
    public let id: Int?
    public let firstName: String?
    public let lastName: String?
    public let userName: String?
    public let email: String?
    public let avatarUrl: String?

    public func toEntity() -> UserProfileEntity {
        UserProfileEntity(
            id: id ?? -1,
            firstName: firstName ?? "",
            lastName: lastName ?? "",
            userName: userName ?? "",
            email: email ?? "",
            avatarUrl: avatarUrl
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name" 
        case lastName = "last_name"
        case userName = "user_name"
        case email
        case avatarUrl = "avatar_url"
    }
}
