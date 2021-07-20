//
//  HomeViewConfiguration.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import Foundation
import UIKit


public final class HomeSceneBuilder {
    public func build() -> UIViewController {
        let configuration = Configuration.current
        let vc = HomeViewController()
        let homeViewConfiguration = HomeViewConfiguration(isShowMenu: configuration.isUserFlowEnable,
                                                          isShowSearch: configuration.isSearchEnable,
                                                          sortRules: configuration.sortRules,
                                                          isShowDetailEnable: configuration.isShowDetailEnable)
        vc.provideConfiguration(homeViewConfiguration)
        return vc.wrapInNavigationController()
    }
}

public struct HomeViewConfiguration {
    public var isShowMenu: Bool = false
    public var isShowSearch: Bool = false
    public var sortRules: [SortRule]? = nil
    public var isShowDetailEnable: Bool = false
}
