//
//  UserAPI.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 21.07.2021.
//

import Foundation

import Alamofire

enum UserAPI {
    case fullInfo
}

extension UserAPI {
    var path: String {
        switch self {
        case .fullInfo: return "user"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fullInfo: return .get
        }
    }
    
    var params: Parameters {
        let params: Parameters = ["accept": "application/vnd.github.v3+json" ]
        switch self {
        case .fullInfo: return params
        }
    }
}

