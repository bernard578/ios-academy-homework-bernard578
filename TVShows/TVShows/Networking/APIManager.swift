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
    
    private let sessionManager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        return Alamofire.Session(configuration: configuration)
    }()
    
    // MARK: - Functions
    
    func makeLoginRequest(email: String, password: String, completionHandler: @escaping (Result<UserResponse, AFError>) -> ()) {
        sessionManager
            .request(UserRouter.login(email: email, password: password))
            .validate()
            .responseDecodable(of: UserResponse.self) {
            [weak self] dataResponse in
                completionHandler(dataResponse.result)
        }
    }
    
    func makeRegisterRequest(email: String, password: String, completionHandler: @escaping (Result<UserResponse, AFError>) -> ()) {
        sessionManager
            .request(UserRouter.register(email: email, password: password))
            .validate()
            .responseDecodable(of: UserResponse.self) {
            [weak self] dataResponse in
                completionHandler(dataResponse.result)
        }
    }
}
