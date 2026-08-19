//
//  TopicsModelsDto.swift
//  SilentMoonData
//
//  Created by Kerimov Qehreman on 20.08.26.
//

import Foundation
import SilentMoonDomain


public struct TopicsModelsDto: Decodable , Sendable {
    public let id : Int?
    public let title : String?
    
   public func toEntity() -> TopicsModelsEntity{
       .init (
        id: id ?? 0,
        title: title ?? ""
       )
        
    }
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}

public struct UpdateTopicsRequestDto: Encodable, Sendable {
    public let topicIds: UpdateTopicEntity
    
    public init(entity: UpdateTopicEntity) {
        self.topicIds = entity.topicIds
    }
    enum CodingKeys: String, CodingKey {
        case topicIds
    }
}
