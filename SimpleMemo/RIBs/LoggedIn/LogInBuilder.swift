//
//  LogInBuilder.swift
//  SimpleMemo
//
//  Created by BH on 2022/12/15.
//  Copyright © 2022 eunjin. All rights reserved.
//

import RIBs

protocol LogInDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var LogInViewController: LogInViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class LogInComponent: Component<LogInDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var LogInViewController: LogInViewControllable {
        return dependency.LogInViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LogInBuildable: Buildable {
    func build(withListener listener: LogInListener) -> LogInRouting
}

final class LogInBuilder: Builder<LogInDependency>, LogInBuildable {

    override init(dependency: LogInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LogInListener) -> LogInRouting {
        let component = LogInComponent(dependency: dependency)
        let interactor = LogInInteractor()
        interactor.listener = listener
        return LogInRouter(interactor: interactor, viewController: component.LogInViewController)
    }
}
