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
    case reviews(showId: String, authInfo: AuthInfo)
    case postAReview(showId: String, comment: String, rating: Int, authInfo: AuthInfo)
    case user(authInfo: AuthInfo)
    
    var path: String {
        switch self {
        case .login:
            return "/users/sign_in"
        case .register:
            return "/users"
        case .shows:
            return "/shows"
        case .reviews(let showId):
            //print("/shows/\(showId.showId)/reviews")
            return "/shows/\(showId.showId)/reviews"
        case .postAReview:
            return "/reviews"
        case .user:
            return "/users/me"
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
        case .reviews:
            return .get
        case .postAReview:
            return .post
        case .user:
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
        case .reviews(let showId):
            return [
                "showId": showId
            ]
        case .postAReview(let showId, let comment, let rating, _):
            return [
                "show_id": showId,
                "comment": comment,
                "rating": rating,
            ]
        case .user(let authInfo):
            return [
                "authInfo": authInfo
            ]
        }
    }
    
    // MARK: - private functions
    
    func asURLRequest() throws -> URLRequest {
        let url = try URL(string: Constants.baseURL
                            .asURL()
                            .appendingPathComponent(path)
                            .absoluteString.removingPercentEncoding!)
        //print(url)
        var request = URLRequest.init(url: url!)
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10*1000)
        switch self {
        case .shows(let authInfo):
            request.headers = HTTPHeaders(authInfo.headers)
        case .reviews(_, let authInfo):
            request.headers = HTTPHeaders(authInfo.headers)
        case .postAReview(_, _, _, let authInfo):
            request.headers = HTTPHeaders(authInfo.headers)
        case .user(let authInfo):
            request.headers = HTTPHeaders(authInfo.headers)
        default:
            break
        }
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
