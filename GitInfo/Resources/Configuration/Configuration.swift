//
//  Configuration.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import UIKit

public struct Configuration {

    //disable/enable user flow. Also enable swipe menu
    let isUserFlowEnable: Bool
    
    // disable/enable search
    let isSearchEnable: Bool
    
    //sort rules: Stars/Forks/Updated etc.
    let sortRules: [SortRule]?
    
    //show git details
    let isShowDetailEnable: Bool
    
    public static var current: Configuration = {
        guard let fileName = Bundle.main.infoDictionary?["ConfigurationFileName"] as? String,
              Bundle.main.path(forResource: fileName, ofType: "plist") != nil else {
            preconditionFailure("Can't load configuration")
        }
        return PlistParser.parse(fileName: fileName, to: Configuration.self)
    }()
}

extension Configuration: Decodable {
    private enum CodingKeys: String, CodingKey {
        case isUserFlowEnabled = "UserFlowEnable"
        case isSearchEnable = "SearchEnable"
        case sortRules = "SortRules"
        case isShowDetailEnable = "ShowDetailEnable"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        isUserFlowEnable = try container.decode(Bool.self, forKey: .isUserFlowEnabled)
        isSearchEnable = try container.decode(Bool.self, forKey: .isSearchEnable)
        sortRules = try container.decode([SortRule].self, forKey: .sortRules)
        isShowDetailEnable = try container.decode(Bool.self, forKey: .isShowDetailEnable)
    }
}
