//
//  RepositoryAPI.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 20.07.2021.
//

import Alamofire

enum RepositoryAPI {
    case list
    case fullInfo(ownerID: String, repoID: String)
    case search(query: String?, sortBy: String?)
}

extension RepositoryAPI {
    var path: String {
        switch self {
        case .list: return "repositories"
        case .fullInfo(let ownerID, let repoID): return "repos/\(ownerID)/\(repoID)"
        case .search: return "search/repositories"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .list, .fullInfo, .search: return .get
        }
    }
    
    var params: Parameters {
        var params: Parameters = ["accept": "application/vnd.github.v3+json",
                                  "per_page": 100]
        switch self {
        case .list: return params
        case .fullInfo(let ownerID, let repoID):
            params["owner"] = ownerID
            params["repo"] = repoID
            return params
        case .search(let query, let sortBy):
            params["q"] = "q=\(query ?? "")"
            params["sort"] = sortBy ?? ""
            return params
        }
    }
}
