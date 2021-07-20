//
//  File.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import Foundation

public struct SortRule: Decodable {
    let title: String
    let sortKey: SortType
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case sortKey = "Key"
    }
    
    enum SortType: String {
        case none
        case stars
        case forks
        case updated
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        sortKey = SortType(rawValue: (try container.decode(String.self, forKey: .sortKey) )) ?? .none
    }
}

extension SortRule: Equatable {
    public static func == (lhs: SortRule, rhs: SortRule) -> Bool {
        return lhs.title == rhs.title
    }
}
