
import RIBs
import RxSwift

protocol RootInteractable: Interactable, LoggedOutListener  {
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
    
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedOutBuilder: LoggedOutBuildable) {
        self.loggedOutBuilder = loggedOutBuilder
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
    }
    
    override func didLoad() {
        super.didLoad()
        routeToLoggedOutRIB()
    }
}
