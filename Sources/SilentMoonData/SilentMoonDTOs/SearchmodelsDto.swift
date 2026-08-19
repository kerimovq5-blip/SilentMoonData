//
//  Searchmodels.swift
//  SilentMoon
//
//  Created by Kerimov Qehreman on 02.08.26.
//

import Foundation
import SilentMoonDomain

public struct CourseSummary: Decodable, Sendable {
    public let id: Int?
    public let title: String?
    public let subtitle: String?
    public let type: String?
    public let categoryId: Int?
    public let imageUrl: String?
    public let durationSec: Int?
    public let isFeatured: Bool?
    public let narrators: [String]?
    
    public func toEntity() -> CourseSummaryEntity {
        
        .init(
            id: id ?? -1,
            title: title ?? "",
            subtitle: subtitle ?? "",
            type: type ?? "",
            categoryId: categoryId ?? -1,
            imageUrl: imageUrl ?? "",
            durationSec: durationSec ?? 0,
            isFeatured: isFeatured ?? false,
            narrators: narrators ?? []
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case type
        case categoryId = "category_id"
        case imageUrl = "image_url"
        case durationSec = "duration_sec"
        case isFeatured = "is_featured"
        case narrators
    }
}

public struct PaginationMeta: Decodable, Sendable {
    public let page: Int?
    public let limit: Int?
    public let total: Int?
    public let totalPages: Int?
    
    public func toEntity() -> PaginationMetaEntity {
        .init(
            page: page ?? 1,
            limit: limit ?? 10,
            total: total ?? 0,
            totalPages: totalPages ?? 0
        )
    }
    enum CodingKeys: String, CodingKey {
        case page
        case limit
        case total
        case totalPages = "total_pages"
    }
}

public struct SearchResponse: Decodable, Sendable {
    public let query: String?
    public let data: [CourseSummary]?
    public let meta: PaginationMeta?
    
    public func toEntity() -> SearchResponseEntity {
        .init(
            query: query ?? "",
            data: data?.map { $0.toEntity() } ?? [],
            meta: meta?.toEntity() ?? .init(page: 1, limit: 10, total: 0, totalPages: 0)
        )
    }
    enum CodingKeys: String, CodingKey {
        case query
        case data
        case meta
    }
}
