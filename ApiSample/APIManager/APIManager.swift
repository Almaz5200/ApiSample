//
//  APIManager.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 Artem Trubacheev. All rights reserved.
//

import Moya

fileprivate var accessKey = "f9291919a92e02889863edf20e963cc9"

enum APIManager {
    // MARK: Auth
    case checkEmail(email: String)
}

extension APIManager: TargetType {
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL { return URL(string: "http://apilayer.net")! }
    var path: String {
        switch self {
        // MARK: Auth
        case .checkEmail:
            return "/api/check"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var parameters: [String: Any]? {
        switch self {
        case .checkEmail(let email):
            return ["email": email, "smtp": 1, "format": 1, "access_key": accessKey]
        }
    }
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .checkEmail(let email):
            return .requestParameters(parameters: ["email": email, "smtp": 1, "format": 1, "access_key": accessKey], encoding: URLEncoding.default)
        }
    }
}

