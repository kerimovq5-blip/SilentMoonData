//
//  Searchmodels.swift
//  SilentMoon
//
//  Created by Kerimov Qehreman on 02.08.26.
//

import Foundation
import SilentMoonDomain

public struct CourseSummary: Decodable {
    public let id: String
    public let title: String
    public let subtitle: String?
    public let type: String
    public let categoryId: String?
    public let imageUrl: String?
    public let durationSec: Int
    public let isFeatured: Bool?
    public let narrators: [String]?
    
    public init(entity: CourseSummaryEntity){
        self.id = entity.id
        self.title = entity.title
        self.subtitle = entity.subtitle
        self.type = entity.type
        self.categoryId = entity.categoryId
        self.imageUrl = entity.imageUrl
        self.durationSec = entity.durationSec
        self.isFeatured = entity.isFeatured
        self.narrators = entity.narrators
    }
    public enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case type
        case categoryId
        case imageUrl
        case durationSec
        case isFeatured
        case narrators
    }
}
    public struct PaginationMeta: Decodable {
        public let page: Int
        public let limit: Int
        public let total: Int
        public let totalPages: Int
        
        public init (entity : PaginationMetaEntity) {
            self.page = entity.page
            self.limit = entity.limit
            self.total = entity.total
            self.totalPages = entity.totalPages
        }
        public enum CodingKeys: String, CodingKey {
            case page
            case limit
            case total
            case totalPages
        }
    }
    
    public struct SearchResponse: Decodable {
        public let query: String
        public let data: [CourseSummary]
        public let meta: PaginationMeta
        
        public init (entity : SearchResponseEntity) {
            self.query = entity.query
            self.data = entity.data.map(CourseSummary.init)
            self.meta = .init(entity: entity.meta)
        }
        public enum CodingKeys: String, CodingKey {
            case query
            case data
            case meta
        }
    }

