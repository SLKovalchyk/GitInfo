//
//  UserProfileSnapshotTests.swift
//  GitInfoUITests
//
//  Created by Sergey Kovalchyk on 20.07.2021.
//

import XCTest
@testable import GitInfo

class UserProfileSnapshotTests: XCTestCase {
    func testUserProfile() {
        let worker = UserProfileSnapshotTestsWorker()
        let vc = UserInfoViewController(user: worker.user!)
        assertSnapshot(viewController: vc, isRecording: true)
    }
}

private class UserProfileSnapshotTestsWorker {
    var user: Owner? {
        return createCustomer()
    }
    
    private func createCustomer() -> Owner {
        let user = Owner(JSON: ["id": 1, "name": "Owner name"])
        XCTAssertTrue(user != nil)
        return user!
    }
}
