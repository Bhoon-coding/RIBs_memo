//
//  LogInInteractor.swift
//  SimpleMemo
//
//  Created by BH on 2022/12/15.
//  Copyright © 2022 eunjin. All rights reserved.
//

import RIBs
import RxSwift

protocol LogInRouting: Routing {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LogInListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LogInInteractor: Interactor, LogInInteractable {

    weak var router: LogInRouting?
    weak var listener: LogInListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
}
