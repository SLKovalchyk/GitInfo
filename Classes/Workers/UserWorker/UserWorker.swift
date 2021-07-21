//
//  UserWorker.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 20.07.2021.
//

import Foundation

final class UserWorker {
    static let shared = UserWorker()
    
    var currentUser : Owner?
    var sessionToken: String?
    
    func getUserInfo(completion: @escaping Completions.ModelResult<Owner>) {
        guard let sessionToken = sessionToken else { return }
        NetworkWorker.shared.sessionToken = sessionToken
        NetworkWorker.shared.networkRequest(path: UserAPI.fullInfo.path,
                                            params: UserAPI.fullInfo.params,
                                            method: UserAPI.fullInfo.method,
                                            withLoadingView: true) { result, error in
            if let json = result as? [String: Any],
               let user = Owner(JSON: json) {
                completion(user, nil)
            } else {
                let error = NSError(domain: "generalErrors",
                                    code: 600,
                                    userInfo: [NSLocalizedDescriptionKey: "Response error"]) as Error
                completion(nil, error)
            }
        }
    }
}
