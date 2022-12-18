
import RIBs
import RxSwift

protocol RootInteractable: Interactable, LoggedOutListener, LoggedInListener  {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
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
    
    override func didLoad() {
        super.didLoad()
        routeToLoggedOutRIB()
    }
    
    func routeToLoggedOutRIB() {
        if let loggedOutRouting = loggedOutRouting {
            detachChild(loggedOutRouting)
            self.loggedOutRouting = nil
        }
        
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
        
        let loggedInRouting = loggedInBuilder.build(withListener: interactor)
        
        attachChild(loggedInRouting)
        /// view-less RIB으로 present 생략
    }
}
