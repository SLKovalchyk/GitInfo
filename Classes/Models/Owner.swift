//
//  Owner.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 20.07.2021.
//

import Foundation

import ObjectMapper

final class Owner: Mappable {
    init?(map: Map) { }
    
    var id: Int = 0
    var name: String?
    var fullName: String?
    var avatarPath: String?
    var infoPath: String?
    
    func mapping(map: Map) {
        id <- map["id"]
        avatarPath <- map["avatar_url"]
        name <- map["login"]
        infoPath <- map["html_url"]
    }
}
