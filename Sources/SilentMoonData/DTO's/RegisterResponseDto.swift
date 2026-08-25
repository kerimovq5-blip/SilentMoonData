//
//  RegisterResponse.swift
//  SilentMoon
//
//  Created by Kerimov Qehreman on 30.07.26.
//

import Foundation
import SilentMoonDomain
public struct RegisterResponse: Decodable {
    public let message: String?
    public let email: String?
    public let otpExpiresAt: String?
    
    public func toEntity() -> RegisterResponseEntity {
        .init(
            message: message ?? "",
            email: email ?? "",
            otpExpiresAt: otpExpiresAt ?? ""
        )
    }
 
    enum CodingKeys: String, CodingKey {
        case message
        case email
        case otpExpiresAt
    }
    
}
