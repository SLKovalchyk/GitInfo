//
//  RepositoryWorker.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 20.07.2021.
//

import Foundation
import ObjectMapper

final class RepositoryWorker {
    static let shared = RepositoryWorker()
    
    func getRepositoryList(query: String?,
                           sort: String?,
                           completion: @escaping Completions.ArrayResult<Repository>) {
        NetworkWorker.shared.networkRequest(path: RepositoryAPI.search(query: query, sortBy: sort).path,
                                            params: RepositoryAPI.search(query: query, sortBy: sort).params,
                                            method: RepositoryAPI.search(query: query, sortBy: sort).method,
                                            withLoadingView: true) { result, error in
            if let error = error {
                completion(nil, error)
            } else if let response = result as? Dictionary<String, Any>,
                      let list = response["items"] as? [Dictionary<String,Any>] {
                completion(Mapper<Repository>().mapArray(JSONArray: list), nil)
            }
        }
    }
}
