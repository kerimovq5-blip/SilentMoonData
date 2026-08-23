//
//  SilentMoonEndPoint.swift
//  SilentMoonData
//
//  Created by Kerimov Qehreman on 07.08.26.
//

import Foundation
import SilentMoonDomain
import SilentMoonNetwork

public enum SilentMoonEndPoint: EndPoint {
    
    case register(name: String, email: String, password: String)
    case login(email: String, password: String)
    case verifyEmail(email: String, otp: String)
    case resendOtp(email: String)
    case refresh(refreshToken: String)
    case logout(refreshToken: String)
    case googleLogin(idToken: String)
    case forgotPassword(email: String)
    case resetPassword(email: String, otp: String, newPassword: String)

    case getProfile
    case updateProfile(firstName: String?, lastName: String?, avatarUrl: String?)
    case getHome

    case getCourses(page: Int, limit: Int)
    case getCourseDetail(id: Int)
    
    case search(query: String, type: String? = nil, page: Int, limit: Int)
    case getTopics
    case updateTopics(topicIds: [Int])
    case setReminder(time: String, days: [Int], message: String)
    case getReminders
    case updateReminder(id: Int, time: String, days: [Int], message: String)
    case deleteReminder(id: Int)

    public var path: String {
        switch self {
        case .register:
            return "/account/register"
        case .login:
            return "/account/login"
        case .verifyEmail:
            return "/account/verify-email"
        case .resendOtp:
            return "/account/resend-otp"
        case .refresh:
            return "/account/refresh-token"
        case .logout:
            return "/account/logout"
        case .googleLogin:
            return "/account/google-login"
        case .forgotPassword:
            return "/account/forgot-password"
        case .resetPassword:
            return "/account/reset-password"
        case .getProfile, .updateProfile:
            return "me"
        case .getHome:
            return "me/home"
        case .search:
            return "search"
        case .getTopics, .updateTopics:
            return "onboarding/topics"
        case .setReminder:
            return "onboarding/reminders"
        case .getReminders:
            return "onboarding/reminders"
        case .updateReminder(let id, _, _, _):
            return "onboarding/reminders/\(id)"
        case .deleteReminder(let id):
            return "onboarding/reminders/\(id)"
        case .getCourses:
            return "courses/"
        case .getCourseDetail(let id):
            return "courses/\(id)"
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .register, .login, .verifyEmail, .resendOtp, .logout, .refresh, .googleLogin, .forgotPassword, .resetPassword, .setReminder:
            return .post
        case .search, .getTopics, .getReminders, .getCourses, .getCourseDetail, .getProfile, .getHome:
            return .get
        case .updateTopics:
            return .put
        case .updateReminder, .updateProfile:
            return .patch
        case .deleteReminder:
            return .delete
        }
    }

    public var queryItems: [URLQueryItem] {
        switch self {
        case .search(let query, let type, let page, let limit):
            var items = [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "limit", value: "\(limit)")
            ]
            if let type {
                items.append(URLQueryItem(name: "type", value: type))
            }
            return items
        case .getCourses(let page, let limit):
            return [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "limit", value: "\(limit)")
            ]
        default:
            return []
        }
    }

    public var requestBody: RequestBody? {
        switch self {
        case .register(let name, let email, let password):
            let entity = RegisterRequestEntity(
                name: name,
                email: email,
                password: password
            )
            return .encodable(RegisterRequest(entity: entity))
        case .login(let email, let password):
            return .dictionary(["email": email, "password": password])
        case .verifyEmail(let email, let otp):
            return .dictionary(["email": email, "otp": otp])
        case .resendOtp(let email):
            return .dictionary(["email": email])
        case .refresh(let refreshToken):
            return .dictionary(["refreshToken": refreshToken])
        case .logout(let refreshToken):
            return .dictionary(["refreshToken": refreshToken])
        case .googleLogin(let idToken):
            return .dictionary(["idToken": idToken])
        case .forgotPassword(let email):
            return .dictionary(["email": email])
        case .resetPassword(let email, let otp, let newPassword):
            return .dictionary(["email": email, "otp": otp, "newPassword": newPassword])
        case .updateProfile(let firstName, let lastName, let avatarUrl):
            var body: [String: Encodable] = [:]
            if let firstName { body["firstName"] = firstName }
            if let lastName { body["lastName"] = lastName }
            if let avatarUrl { body["avatarUrl"] = avatarUrl }
            return .dictionary(body)
        case .updateTopics(let topicIds):
            return .dictionary(["topicIds": topicIds])
        case .setReminder(let time, let days, let message):
            return .dictionary(["time": time, "days": days, "message": message])
        case .updateReminder(_, let time, let days, let message):
            return .dictionary(["time": time, "days": days, "message": message])
        case .search, .getTopics, .getReminders, .deleteReminder, .getCourses, .getCourseDetail, .getProfile, .getHome:
            return nil
        }
    }

    public var requiresAuth: Bool {
        switch self {
        case .logout, .getTopics, .updateTopics, .setReminder, .getReminders, .updateReminder,
             .deleteReminder, .getCourses, .getCourseDetail, .getProfile, .updateProfile, .getHome:
            return true
        default:
            return false
        }
    }
}
