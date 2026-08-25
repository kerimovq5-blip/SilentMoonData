//
//  ErrorModel.swift
//  SilentMoonData
//
//  Created by Kerimov Qehreman on 15.08.26.
//
import Foundation
import SilentMoonDomain

public struct ErrorModel : Decodable  ,Error {
   private(set) var statuscode: Int?
    let statusmessage: String?
    let success: Bool?
    
    public func toEntity() -> ErrorEntity {
        .init(
            statuscode: statuscode ?? -1,
            statusmessage: localizedDescription ,
            success: success ?? false
        )
    }
    enum CodingKeys: String, CodingKey {
        case statuscode = "status_code"
        case statusmessage = "status_message"
        case success = "success"

    }
    mutating func setStatusCode(statusCode: Int) {
        if self.statuscode == nil {
            self.statuscode = statusCode
        }
    }
    var localizedDescription: String {
        if let statusmessage = statusmessage {
            return statusmessage
        }else if let statuscode = statuscode {
           return  "Error with status code : \(statuscode)"

        }
        return " Unknown Error"

    }
}


