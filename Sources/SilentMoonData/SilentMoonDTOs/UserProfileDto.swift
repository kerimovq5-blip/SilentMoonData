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
    
    
}
