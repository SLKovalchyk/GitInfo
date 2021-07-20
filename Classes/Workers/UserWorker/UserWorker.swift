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
}
