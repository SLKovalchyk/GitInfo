//
//  NetworkWorker.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import Alamofire
import SVProgressHUD

final class NetworkWorker {

    var baseURLPath = ""

    static let shared: NetworkWorker = {
        let instance = NetworkWorker()
        instance.baseURLPath = "https://api.github.com/"
        return instance
    }()

    func headers() -> HTTPHeaders {
        return [.init(name: "Content-Type", value: "application/json"),
                .init(name: "accept", value: "application/vnd.github.v3+json")]
    }

    func networkRequest(path: String,
                        params: Parameters?,
                        method: HTTPMethod!,
                        withLoadingView: Bool,
                        completion: @escaping Completions.ModelResult<Any>) {
        if withLoadingView {
            SVProgressHUD.show()
        }
        
        AF.request(baseURLPath + path,
                   method: method,
                   parameters: params,
                   encoding: URLEncoding.queryString,
                   headers: headers())
            .responseJSON { (response) in
                SVProgressHUD.dismiss()
                switch response.result {
                case .success(let responseValue):
                    completion(responseValue, nil)
                case .failure(let error):
                    completion(nil, error)
                    break
                }
            }
    }
}

private extension NetworkWorker {
    func error(code: Int,
               description: String) -> Error {
        return NSError(domain: "generalErrors",
                       code: code,
                       userInfo: [NSLocalizedDescriptionKey: description]) as Error
    }
}
