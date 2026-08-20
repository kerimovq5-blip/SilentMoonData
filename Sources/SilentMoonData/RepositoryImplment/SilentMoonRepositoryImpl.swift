//
//  SilentMoonApiService.swift
//  SilentMoonNetwork
//
//  Created by Kerimov Qehreman on 07.08.26.
//

import Foundation
import SilentMoonDomain
import SilentMoonNetwork

public struct EmptyResponse: Decodable {
    public init() {}
}

public final class SilentMoonRepositoryImpl: SilentMoonRepository, @unchecked Sendable {
    private let networkManager: NetworkManager<ApiErrorEnvelope>
    private let tokenStore: TokenStore

    private var isRefreshing = false
    private var refreshCallbacks: [(Bool) -> Void] = []

    public init(networkManager: NetworkManager<ApiErrorEnvelope>, tokenStore: TokenStore) {
        self.networkManager = networkManager
        self.tokenStore = tokenStore
    }
    
    private func requestWithRefresh<T: Decodable>(endPoint: EndPoint) async -> Result<T, Error> {
        let result: Result<T, Error> = await networkManager.request(endPoint: endPoint)
        
        guard case .failure(let error) = result,
              let appError = error as? AppError<ApiErrorEnvelope>,
              case .unauthorized = appError,
              endPoint.requiresAuth else {
            return result
        }
        
        let refreshResult = await refreshToken()
        switch refreshResult {
        case .success:
            return await networkManager.request(endPoint: endPoint)
        case .failure:
            return .failure(AppError<ApiErrorEnvelope>.unauthorized)
        }
    }

    public func register(name: String,email: String,password: String
    ) async -> Result<RegisterResponseEntity, Error> {
        let result: Result<RegisterResponse, Error> = await networkManager.request(
            endPoint: SilentMoonEndPoint.register(name: name, email: email, password: password)
        )
        return result.map { $0.toEntity() }
    }

    public func login(
        email: String,
        password: String
    ) async -> Result<AuthResponseEntity, Error> {
        let result: Result<AuthResponse, Error> = await networkManager.request(
            endPoint: SilentMoonEndPoint.login(email: email, password: password)
        )
        
        if case .success(let auth) = result {
            tokenStore.save(access: auth.accessToken ?? "", refresh: auth.refreshToken ?? "")
        }
        
        return result.map { $0.toEntity() }
    }

    public func verifyEmail(
        email: String,
        otp: String
    ) async -> Result<AuthResponseEntity, Error> {
        let result: Result<AuthResponse, Error> = await networkManager.request(
            endPoint: SilentMoonEndPoint.verifyEmail(email: email, otp: otp)
        )
        
        if case .success(let auth) = result {
            tokenStore.save(access: auth.accessToken ?? "", refresh: auth.refreshToken ?? "")
        }
        
        return result.map { $0.toEntity() }
    }

    public func resendOtp(
        email: String
    ) async -> Result<ResendOtpResponseEntity, Error> {
        let result: Result<ResendOtpResponse, Error> = await networkManager.request(
            endPoint: SilentMoonEndPoint.resendOtp(email: email)
        )
        return result.map { $0.toEntity() }
    }

    public func googleLogin(
        idToken: String
    ) async -> Result<AuthResponseEntity, Error> {
        let result: Result<AuthResponse, Error> = await networkManager.request(
            endPoint: SilentMoonEndPoint.googleLogin(idToken: idToken)
        )
        
        if case .success(let auth) = result {
            tokenStore.save(access: auth.accessToken ?? "", refresh: auth.refreshToken ?? "")
        }
        
        return result.map { $0.toEntity() }
    }

    public func forgotPassword(
        email: String
    ) async -> Result<SimpleMessageResponseEntity, Error> {
        let result: Result<SimpleMessageResponse, Error> = await networkManager.request(
            endPoint: SilentMoonEndPoint.forgotPassword(email: email)
        )
        return result.map { $0.toEntity() }
    }

    public func resetPassword(
        email: String,
        otp: String,
        newPassword: String
    ) async -> Result<SimpleMessageResponseEntity, Error> {
        let result: Result<SimpleMessageResponse, Error> = await networkManager.request(
            endPoint: SilentMoonEndPoint.resetPassword(email: email, otp: otp, newPassword: newPassword)
        )
        return result.map { $0.toEntity() }
    }

    public func refreshToken() async -> Result<AuthResponseEntity, Error> {
        guard let refreshToken = tokenStore.refreshToken else {
            return .failure(AppError<ApiErrorEnvelope>.unauthorized)
        }
        
        let result: Result<AuthResponse, Error> = await networkManager.request(
            endPoint: SilentMoonEndPoint.refresh(refreshToken: refreshToken)
        )
        
        switch result {
        case .success(let auth):
            tokenStore.save(access: auth.accessToken ?? "", refresh: auth.refreshToken ?? "")
        case .failure:
            tokenStore.clear()
        }
        
        return result.map { $0.toEntity() }
    }

    public func logout() async -> Result<Void, Error> {
        guard let refreshToken = tokenStore.refreshToken else {
            tokenStore.clear()
            return .success(())
        }
        
        let result: Result<EmptyResponse, Error> = await networkManager.request(
            endPoint: SilentMoonEndPoint.logout(refreshToken: refreshToken)
        )
        
        tokenStore.clear()
        
        switch result {
        case .success:
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func search(
        query: String,
        type: String? = nil,
        page: Int = 1,
        limit: Int = 20
    ) async -> Result<SearchResponseEntity, Error> {
        let result: Result<SearchResponse, Error> = await networkManager.request(
            endPoint: SilentMoonEndPoint.search(query: query, type: type, page: page, limit: limit)
        )
        return result.map { $0.toEntity() }
    }

    public func getTopics() async -> Result<[ChooseTopicEntity], Error> {
        let result: Result<[TopicsModelsDto], Error> = await requestWithRefresh(
            endPoint: SilentMoonEndPoint.getTopics
        )
        return result.map { dtos in dtos.map { $0.toEntity() } }
    }

    public func updateTopics(topicIds: [Int]) async -> Result<[ChooseTopicEntity], Error> {
        let result: Result<[TopicsModelsDto], Error> = await requestWithRefresh(
            endPoint: SilentMoonEndPoint.updateTopics(topicIds: topicIds)
        )
        return result.map { dtos in dtos.map { $0.toEntity() } }
    }
    
    public func getReminders() async -> Result<[ReminderResponseEntity], Error> {
        let result: Result<[ReminderResponse], Error> = await requestWithRefresh(
            endPoint: SilentMoonEndPoint.getReminders
        )
        return result.map { responses in responses.map { $0.toEntity() } }
    }

    public func setReminder(
        time: String,
        days: [Int],
        message: String
    ) async -> Result<ReminderResponseEntity, Error> {
        let result: Result<ReminderResponse, Error> = await requestWithRefresh(
            endPoint: SilentMoonEndPoint.setReminder(time: time, days: days, message: message)
        )
        return result.map { $0.toEntity() }
    }

    public func updateReminder(
        id: Int,
        time: String,
        days: [Int],
        message: String
    ) async -> Result<ReminderResponseEntity, Error> {
        let result: Result<ReminderResponse, Error> = await requestWithRefresh(
            endPoint: SilentMoonEndPoint.updateReminder(id: id, time: time, days: days, message: message)
        )
        return result.map { $0.toEntity() }
    }

    public func deleteReminder(id: Int) async -> Result<Void, Error> {
        let result: Result<EmptyResponse, Error> = await requestWithRefresh(
            endPoint: SilentMoonEndPoint.deleteReminder(id: id)
        )
        return result.map { _ in () }
    }
    
    public func getCourses(page: Int, limit: Int) async -> Result<CoursesResponseEntity, Error> {
            let result: Result<CoursesResponseDto, Error> = await requestWithRefresh(
                endPoint: SilentMoonEndPoint.getCourses(page: page, limit: limit)
            )
            return result.map { $0.toEntity() }
        }

        public func getCourseDetail(id: Int) async -> Result<CourseEntity, Error> {
            let result: Result<CourseDto, Error> = await requestWithRefresh(
                endPoint: SilentMoonEndPoint.getCourseDetail(id: id)
            )
            return result.map { $0.toEntity() }
        }
    }
