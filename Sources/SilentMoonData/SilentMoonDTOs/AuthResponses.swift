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
    public let user: UserProfileDto? 
    
    public func toEntity() -> AuthResponseEntity {
        .init(
            accessToken: accessToken ?? "",
            refreshToken: refreshToken ?? "",
            tokenType: tokenType ?? "",
            expiresIn: expiresIn ?? -1,
            user: user?.toEntity() ?? .init(
                id: -1,
                firstName: "",
                lastName: "",
                userName: "",
                email: "",
                avatarUrl: nil
            )
        )
    }
}

