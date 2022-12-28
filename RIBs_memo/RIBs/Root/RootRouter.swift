//
//  RootRouter.swift
//  RIBs_memo
//
//  Created by BH on 2022/12/08.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener, LoggedInListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let loggedOutBuilder: LoggedOutBuildable
    private var loggedOutRouting: ViewableRouting?
    
    private let loggedInBuilder: LoggedInBuildable
    
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedOutBuilder: LoggedOutBuildable,
         loggedInBuilder: LoggedInBuildable) {
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToLoggedOutRIB() {
        let loggedOutRouting = loggedOutBuilder.build(withListener: interactor)
        self.loggedOutRouting = loggedOutRouting
        attachChild(loggedOutRouting)
        viewController.present(viewController: loggedOutRouting.viewControllable)
    }
    
    func routeToLoggedInRIB(email: String, password: String) {
        if let loggedOutRouting = loggedOutRouting {
            detachChild(loggedOutRouting)
            viewController.dismiss(viewController: loggedOutRouting.viewControllable)
            self.loggedOutRouting = nil
        }
        
        let loggedInRouting = loggedInBuilder.build(withListener: interactor,
                                                    email: email,
                                                    password: password)
        attachChild(loggedInRouting)
    }
    
    override func didLoad() {
        super.didLoad()
        routeToLoggedOutRIB()
    }
}
