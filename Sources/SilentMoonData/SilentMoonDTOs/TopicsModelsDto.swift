//
//  TopicsModelsDto.swift
//  SilentMoonData
//
//  Created by Kerimov Qehreman on 20.08.26.
//

import Foundation
import SilentMoonDomain

public struct TopicsModelsDto: Decodable, Sendable {
    public let topicsId: Int?
    public let title: String?
    
    enum CodingKeys: String, CodingKey {
        case topicsId = "topicsId"
        case title = "title"
    }
    
    public func toEntity() -> ChooseTopicEntity {
        ChooseTopicEntity(
            topicsId: topicsId ?? 0,
            title: title ?? ""
        )
    }
}

public struct UpdateTopicsRequestDto: Decodable, Sendable {
    public let topicIds: [Int]
    
    public init(topicIds: [Int]) {
        self.topicIds = topicIds
    }
    
    enum CodingKeys: String, CodingKey {
        case topicIds = "topicIds"
    }
}
