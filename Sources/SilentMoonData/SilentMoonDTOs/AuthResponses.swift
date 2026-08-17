//
//  AuthResponses.swift
//  SilentMoonNetwork
//
//  Created by Kerimov Qehreman on 09.08.26.
//

import Foundation
import SilentMoonDomain

public struct SimpleMessageResponse: Decodable, Sendable {
    public let message: String
    
    public init(entity : SimpleMessageResponseEntity ) {
        self.message = entity.message
    }
}

public struct ResendOtpResponse: Decodable, Sendable {
    public let message: String
    public let otpExpiresAt: String
    
    public init(entity : ResendOtpResponseEntity) {
        self.message = entity.message
        self.otpExpiresAt = entity.otpExpiresAt
    }
}

public struct AuthResponse: Decodable, Sendable {
    public let accessToken: String
    public let refreshToken: String
    public let tokenType: String
    public let expiresIn: Int
    public let user: UserProfile
    
    public init(
        entity : AuthResponseEntity
    ) {
        self.accessToken = entity.accessToken
        self.refreshToken = entity.refreshToken
        self.tokenType = entity.tokenType
        self.expiresIn = entity.expiresIn
        self.user = UserProfile(entity: entity.user)
    }
}

public struct UserProfile: Decodable, Sendable {
    public let id: String
    public let name: String
    public let email: String
    public let emailVerified: Bool
    public let avatarUrl: String?
    public let createdAt: String
    
    public init(
        entity : UserProfileEntity
    ) {
        self.id = entity.id
        self.name = entity.name
        self.email = entity.email
        self.emailVerified = entity.emailVerified
        self.avatarUrl = entity.avatarUrl
        self.createdAt = entity.createdAt
    }
}
