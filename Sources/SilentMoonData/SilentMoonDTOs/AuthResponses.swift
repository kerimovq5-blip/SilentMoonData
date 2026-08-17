//
//  AuthResponses.swift
//  SilentMoonNetwork
//
//  Created by Kerimov Qehreman on 09.08.26.
//

import Foundation
import SilentMoonDomain

public struct SimpleMessageResponse: Decodable, Sendable {
    public let message: String?
    
    public func toEntity()-> SimpleMessageResponseEntity {
        .init(message: message ?? "")
    }
}

public struct ResendOtpResponse: Decodable, Sendable {
    public let message: String?
    public let otpExpiresAt: String?
    
    public func toEntity()-> ResendOtpResponseEntity {
        .init(
            message: message ?? "",
            otpExpiresAt: otpExpiresAt ?? ""
        )
    }
}

public struct AuthResponse: Decodable, Sendable {
    public let accessToken: String?
    public let refreshToken: String?
    public let tokenType: String?
    public let expiresIn: Int?
    public let user: UserProfile?
    
    public func toEntity() -> AuthResponseEntity {
        .init(
            accessToken: accessToken ?? "",
            refreshToken: refreshToken ?? "",
            tokenType: tokenType ?? "",
            expiresIn: expiresIn ?? -1,
            user: user?.toEntity() ?? .init(id: "", name: "", email: "", emailVerified: false, avatarUrl: nil, createdAt: "")
        )
    }
}

public struct UserProfile: Decodable, Sendable {
    public let id: String?
    public let name: String?
    public let email: String?
    public let emailVerified: Bool?
    public let avatarUrl: String?
    public let createdAt: String?
    
    public func toEntity() -> UserProfileEntity {
        .init(
            id: id ?? "",
            name: name ?? "",
            email: email ?? "",
            emailVerified: emailVerified ?? false,
            avatarUrl: avatarUrl,
            createdAt: createdAt ?? ""
        )
    }
}
