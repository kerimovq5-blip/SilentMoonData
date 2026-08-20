//
//  UseCaseImplmentation.swift
//  SilentMoonData
//
//  Created by Kerimov Qehreman on 20.08.26.
//


import Foundation
import SilentMoonDomain
import SilentMoonNetwork

public final class UseCasesImplemantation: SilentMoonUseCases , @unchecked Sendable {
    
        private let networkManager: NetworkManager<ApiErrorEnvelope>
        private let tokenStore: TokenStore
        private let usecases: SilentMoonUseCases
    
        private var isRefreshing = false
        private var refreshCallbacks: [(Bool) -> Void] = []

        public init(networkManager: NetworkManager<ApiErrorEnvelope>, tokenStore: TokenStore , usecases: SilentMoonUseCases) {
            self.networkManager = networkManager
            self.tokenStore = tokenStore
            self.usecases = usecases
        }
    
    
   public func register(name: String, email: String, password: String) async -> Result<RegisterResponseEntity, any Error> {
        await usecases.register(name: name, email: email, password: password)
    }

    public func login(email: String, password: String) async -> Result<AuthResponseEntity, any Error> {
        await usecases.login(email: email, password: password)
    }

    public func verifyEmail(email: String, otp: String) async -> Result<AuthResponseEntity, any Error> {
        await usecases.verifyEmail(email: email, otp: otp)
    }

    public func resendOtp(email: String) async -> Result<ResendOtpResponseEntity, any Error> {
        await usecases.resendOtp(email: email)
    }

    public func googleLogin(idToken: String) async -> Result<AuthResponseEntity, any Error> {
        await usecases.googleLogin(idToken: idToken)
    }

    public func forgotPassword(email: String) async -> Result<SimpleMessageResponseEntity, any Error> {
        await usecases.forgotPassword(email: email)
    }

    public func resetPassword(email: String, otp: String, newPassword: String) async -> Result<SimpleMessageResponseEntity, any Error> {
        await usecases.resetPassword(email: email, otp: otp, newPassword: newPassword)
    }

    public func refreshToken() async -> Result<AuthResponseEntity, any Error> {
        await usecases.refreshToken()
    }

    public func logout() async -> Result<Void, any Error> {
        await usecases.logout()
    }

    public func search(query: String, type: String?, page: Int, limit: Int) async -> Result<SearchResponseEntity, any Error> {
        await usecases.search(query: query, type: type, page: page, limit: limit)
    }

    public func getTopics() async -> Result<[ChooseTopicEntity], any Error> {
        await usecases.getTopics()
    }

    public func updateTopics(topicIds: [Int]) async -> Result<[ChooseTopicEntity], any Error> {
        await usecases.updateTopics(topicIds: topicIds)
    }

    public func getReminders() async -> Result<[ReminderResponseEntity], any Error> {
        await usecases.getReminders()
    }

    public func setReminder(time: String, days: [Int], message: String) async -> Result<ReminderResponseEntity, any Error> {
        await usecases.setReminder(time: time, days: days, message: message)
    }

    public func updateReminder(id: Int, time: String, days: [Int], message: String) async -> Result<ReminderResponseEntity, any Error> {
        await usecases.updateReminder(id: id, time: time, days: days, message: message)
    }

    public  func deleteReminder(id: Int) async -> Result<Void, any Error> {
        await usecases.deleteReminder(id: id)
    }

    public func getCourses(page: Int, limit: Int) async -> Result<CoursesResponseEntity, any Error> {
        await usecases.getCourses(page: page, limit: limit)
    }

    public func getCourseDetail(id: Int) async -> Result<CourseEntity, any Error> {
        await usecases.getCourseDetail(id: id)
    }

    
}
