//
//  UserRouter.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 21.07.2021..
//

import Foundation
import Alamofire

enum UserRouter: URLRequestConvertible {
        case login(email: String, password: String)
    case register(email: String, password: String)
    
    var path: String {
        switch self {
        case .login:
            return "/users/sign_in"
        case .register:
            return "/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .register:
            return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        case .register(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try URL(string: Constants.baseURL.asURL().appendingPathComponent(path).absoluteString.removingPercentEncoding!)
        print(url)
        var request = URLRequest.init(url: url!)
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10*1000)
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
}
