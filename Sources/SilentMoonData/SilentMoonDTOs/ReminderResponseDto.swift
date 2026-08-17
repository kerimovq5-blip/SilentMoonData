//
//  ReminderResponseDto.swift
//  SilentMoonNetwork
//
//  Created by Kerimov Qehreman on 14.08.26.
//

import Foundation
import SilentMoonDomain
 
public struct ReminderResponse: Decodable, Sendable {
    public let id: String
    public let time: String
    public let days: [Int]
    public let message: String
    
    public init (entity : ReminderResponseEntity) {
        self.id = entity.id
        self.time = entity.time
        self.days = entity.days
        self.message = entity.message
    }
    enum CodingKeys: String, CodingKey {
        case id, time, days, message
    }
    
}
