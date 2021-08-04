//
//  APIManager.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 25.07.2021..
//

import Foundation
import Alamofire

final class APIManager {
    
    // MARK: - Properties
    
    static let shared = APIManager()
    var authInfo: AuthInfo?
    private let sessionManager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        return Alamofire.Session(configuration: configuration)
    }()
    
    // MARK: - Functions
    
    func makeLoginRequest(email: String, password: String, completionHandler: @escaping (Result<UserResponse, AFError>) -> ()) {
        sessionManager
            .request(UserRouter.login(email: email, password: password))
            .validate()
            .responseDecodable(of: UserResponse.self) { dataResponse in
                let headers = dataResponse.response?.headers.dictionary ?? [:]
                if let authInfo = try? AuthInfo(headers: headers) {
                    APIManager.shared.authInfo = authInfo
                }
                completionHandler(dataResponse.result)
        }
    }
    
    func makeRegisterRequest(email: String, password: String, completionHandler: @escaping (Result<UserResponse, AFError>) -> ()) {
        sessionManager
            .request(UserRouter.register(email: email, password: password))
            .validate()
            .responseDecodable(of: UserResponse.self) { dataResponse in
                let headers = dataResponse.response?.headers.dictionary ?? [:]
                if let authInfo = try? AuthInfo(headers: headers) {
                    APIManager.shared.authInfo = authInfo
                }
                completionHandler(dataResponse.result)
        }
    }
    
    func makeShowsRequest(completionHandler: @escaping (Result<ShowResponse, AFError>) -> ()) {
        sessionManager
            .request(UserRouter.shows(authInfo: (KeychainAccess.shared.retrieve())!))
            .validate()
            .responseDecodable(of: ShowResponse.self) { dataResponse in
                let headers = dataResponse.response?.headers.dictionary ?? [:]
                if let authInfo = try? AuthInfo(headers: headers) {
                    APIManager.shared.authInfo = authInfo
                }
                completionHandler(dataResponse.result)
        }
    }
    
    func makeReviewsRequest(showId: String, completionHandler: @escaping (Result<ReviewResponse, AFError>) -> ()) {
        sessionManager
            .request(UserRouter.reviews(showId: showId, authInfo: APIManager.shared.authInfo!))
            .validate()
            .responseDecodable(of: ReviewResponse.self) { dataResponse in
                let headers = dataResponse.response?.headers.dictionary ?? [:]
                if let authInfo = try? AuthInfo(headers: headers) {
                    APIManager.shared.authInfo = authInfo
                }
                completionHandler(dataResponse.result)
        }
    }
    
    func makePostReviewRequest(showId: String, comment: String, rating: Int, completionHandler: @escaping (Result<ReviewPostResponse, AFError>) -> ()) {
        sessionManager
            .request(UserRouter.postAReview(showId: showId, comment: comment, rating: rating, authInfo: APIManager.shared.authInfo!))
            .validate()
            .responseDecodable(of: ReviewPostResponse.self) { dataResponse in
                let headers = dataResponse.response?.headers.dictionary ?? [:]
                if let authInfo = try? AuthInfo(headers: headers) {
                    APIManager.shared.authInfo = authInfo
                }
                completionHandler(dataResponse.result)
        }
    }
    
    func makeUserRequest(completionHandler: @escaping (Result<UserResponse, AFError>) -> ()) {
        sessionManager.request(UserRouter.user(authInfo: APIManager.shared.authInfo!)).validate().responseDecodable(of: UserResponse.self) { dataResponse in
            completionHandler(dataResponse.result)
        }
    }
    
    func makeUserPutRequest(email: String, requestData: MultipartFormData, completionHandler: @escaping (Result<UserResponse, AFError>) -> ()) {
        sessionManager.upload(multipartFormData: requestData, with: UserRouter.userPutRequest(email: email, requestData: requestData, authInfo: APIManager.shared.authInfo!))
            .validate()
            .responseDecodable(of: UserResponse.self) { dataResponse in
                let headers = dataResponse.response?.headers.dictionary ?? [:]
                if let authInfo = try? AuthInfo(headers: headers) {
                    APIManager.shared.authInfo = authInfo
                }
                completionHandler(dataResponse.result)
        }
    }
}
