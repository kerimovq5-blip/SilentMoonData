//
//  RegisterRequest.swift
//  SilentMoon
//
//  Created by Kerimov Qehreman on 30.07.26.
//

import Foundation
import SilentMoonDomain
   public struct RegisterRequest: Encodable {
       public let name: String
       public let email: String
       public let password: String
       
       public init(entity : RegisterRequestEntity) {
           self.name = entity.name
           self.email = entity.email
           self.password = entity.password
       }
     
      public  enum CodingKeys: String, CodingKey {
            case name = "name"
            case email = "email"
            case password = "password"
        }
    }


