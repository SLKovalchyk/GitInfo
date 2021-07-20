//
//  PlistParser.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import Foundation

public enum PlistParser {
    public static func parse<T: Decodable>(fileName: String, to: T.Type, bundle: Bundle = .main) -> T {
        guard let url = bundle.url(forResource: fileName, withExtension: "plist") else {
            preconditionFailure("Can't load \(fileName).plist file.")
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            return try decoder.decode(T.self, from: data)
        } catch let error {
            let message = "[parse] Can't decode \(fileName).plist file, Error: \(error.localizedDescription)"
            preconditionFailure(message)
        }
    }
}
