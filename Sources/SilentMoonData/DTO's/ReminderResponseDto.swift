//
//  ReminderResponseDto.swift
//  SilentMoonNetwork
//
//  Created by Kerimov Qehreman on 14.08.26.
//

import Foundation
import SilentMoonDomain
 
public struct ReminderResponse: Decodable, Sendable {
    public let id: Int?
    public let time: String?
    public let days: [Int]?
    public let message: String?
    
    public func toEntity () -> ReminderResponseEntity {
        .init(
            id: id ?? -1,
            time: time ?? "",
            days: days ?? [],
            message: message ?? ""
        )
    }
    enum CodingKeys: String, CodingKey {
        case id, time, days, message
    }
    
}
