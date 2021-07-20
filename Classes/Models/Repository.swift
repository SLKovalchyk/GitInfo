//
//  Repository.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import Foundation
import ObjectMapper

final class Repository: Mappable {
    var id: Int = 0
    var imagePath: String?
    var name: String = ""
    var createdAt: Date?
    var updateAt: Date?
    var description: String?
    
    var stars: Int = 0
    var watchers: Int = 0
    var fork: Int = 0
    
    var owner: Owner?
    var infoPath: String?
    
    required init?(map: Map) { }

    func mapping(map: Map) {
        id <- map["id"]
        imagePath <- map[""]
        name <- map["name"]
        owner <- map["owner"]
        description <- map["description"]
       
        if let _updated_at = map["updated_at"].currentValue as? String,
           let date = Date(iso8601String: _updated_at) {
            updateAt = date
        }
        if let _created_at = map["created_at"].currentValue as? String,
           let date = Date(iso8601String: _created_at) {
            createdAt = date
        }
        
        stars <- map["stargazers_count"]
        fork <- map["forks_count"]
        watchers <- map["watchers_count"]
        infoPath <- map["html_url"]
    }
}
