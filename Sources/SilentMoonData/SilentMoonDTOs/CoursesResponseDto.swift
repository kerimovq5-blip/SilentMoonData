//
//  CoursesResponseDto.swift
//  SilentMoonData
//
//  Created by Kerimov Qehreman on 19.08.26.
//

import Foundation
import SilentMoonDomain

public struct CourseDto: Decodable, Sendable {
    public let id: Int?
    public let title: String?
    public let description: String?
    public let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case imageUrl = "image_url"
    }

    public func toDomain() -> CourseEntity {
        CourseEntity(
            id: id ?? 0,
            title: title ?? "",
            description: description,
            imageUrl: imageUrl
        )
    }
}

public struct CoursesResponseDto: Decodable, Sendable {
    public let items: [CourseDto]?
    public let page: Int?
    public let limit: Int?
    public let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case items = "courses" 
        case page
        case limit
        case totalPages = "total_pages"
    }
    
    public func toDomain() -> CoursesResponseEntity {
        CoursesResponseEntity(
            items: items?.map { $0.toDomain() } ?? [],
            page: page ?? 1,
            limit: limit ?? 10,
            totalPages: totalPages
        )
    }
}
