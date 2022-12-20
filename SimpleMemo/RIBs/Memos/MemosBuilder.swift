//
//  MemosBuilder.swift
//  SimpleMemo
//
//  Created by BH on 2022/12/20.
//  Copyright © 2022 eunjin. All rights reserved.
//

import RIBs

protocol MemosDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MemosComponent: Component<MemosDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MemosBuildable: Buildable {
    func build(withListener listener: MemosListener) -> MemosRouting
}

final class MemosBuilder: Builder<MemosDependency>, MemosBuildable {

    override init(dependency: MemosDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MemosListener) -> MemosRouting {
        let component = MemosComponent(dependency: dependency)
        let viewController = MemosViewController()
        let interactor = MemosInteractor(presenter: viewController)
        interactor.listener = listener
        return MemosRouter(interactor: interactor, viewController: viewController)
    }
}
