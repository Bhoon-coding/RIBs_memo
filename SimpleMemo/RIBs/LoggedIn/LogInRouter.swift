//
//  LogInRouter.swift
//  SimpleMemo
//
//  Created by BH on 2022/12/15.
//  Copyright © 2022 eunjin. All rights reserved.
//

import RIBs

protocol LogInInteractable: Interactable {
    var router: LogInRouting? { get set }
    var listener: LogInListener? { get set }
}

protocol LogInViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class LogInRouter: Router<LogInInteractable>, LogInRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LogInInteractable, viewController: LogInViewControllable) {
        self.viewController = viewController
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }

    // MARK: - Private

    private let viewController: LogInViewControllable
}
