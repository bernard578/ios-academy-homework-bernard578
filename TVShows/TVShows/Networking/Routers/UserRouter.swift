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
    case shows(authInfo: AuthInfo)
    
    var path: String {
        switch self {
        case .login:
            return "/users/sign_in"
        case .register:
            return "/users"
        case .shows:
            return "/shows"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .register:
            return .post
        case .shows:
            return .get
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
        case .shows:
            return [
                "page": "1",
                "items": "100"
            ]
        }
    }
    
    // MARK: - private functions
    
    func asURLRequest() throws -> URLRequest {
        let url = try URL(string: Constants.baseURL
                            .asURL()
                            .appendingPathComponent(path)
                            .absoluteString.removingPercentEncoding!)
        print(url)
        var request = URLRequest.init(url: url!)
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10*1000)
        switch self {
        case .shows(let authInfo):
            request.headers = HTTPHeaders(authInfo.headers)
        default:
            break
        }
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
