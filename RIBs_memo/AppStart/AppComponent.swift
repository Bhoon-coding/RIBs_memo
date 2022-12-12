//
//  AppComponent.swift
//  RIBs_memo
//
//  Created by BH on 2022/12/08.
//

import RIBs

//public protocol Empty

class AppComponent: Component<EmptyDependency>, RootDependency {
    init() {
        super.init(dependency: EmptyComponent())
    }
}
