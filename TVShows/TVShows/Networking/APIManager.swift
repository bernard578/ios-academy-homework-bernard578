//
//  APIManager.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 25.07.2021..
//

import Foundation
import Alamofire

class APIManager {
    
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
            .request(UserRouter.shows(authInfo: APIManager.shared.authInfo!))
            .validate()
            .responseDecodable(of: ShowResponse.self) { dataResponse in
                completionHandler(dataResponse.result)
        }
    }
}
