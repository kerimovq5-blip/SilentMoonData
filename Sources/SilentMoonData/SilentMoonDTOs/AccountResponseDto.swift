////
////  AccountResponseDto.swift
////  SilentMoonData
////
////  Created by Kerimov Qehreman on 22.08.26.
////
//
//import Foundation
//
//// MARK: - AccountResponse
//public struct AccountResponseDto: Codable {
//    public let id: Int?
//    public let firstName: String?
//    public let lastName: String?
//    public let userName: String?
//    public let email: String?
//    public let avatarUrl: String?
//    
//    
//    public func toEntity() -> AccountResponseEntity {
//        .init(
//            id: id,
//            firstName: firstName,
//            lastName: lastName,
//            userName: userName,
//            email: email,
//            avatarUrl: avatarUrl
//        )
//    }
//
//    public enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case firstName = "firstName"
//        case lastName = "lastName"
//        case userName = "userName"
//        case email = "email"
//        case avatarUrl = "avatarUrl"
//    }
//}
