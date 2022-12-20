import RIBs

protocol LoggedInDependency: Dependency {
    /// view-less 라서 아래와 같이 추가
    var LoggedInViewController: LoggedInViewControllable { get }
}

final class LoggedInComponent: Component<LoggedInDependency>, MemosDependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var LoggedInViewController: LoggedInViewControllable {
        return dependency.LoggedInViewController
    }
    
    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {
    
    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener) -> LoggedInRouting
    {
        let component = LoggedInComponent(dependency: dependency)
        let interactor = LoggedInInteractor()
        interactor.listener = listener
        
        let memosBuilder = MemosBuilder(dependency: component)
        return LoggedInRouter(interactor: interactor,
                              viewController: component.LoggedInViewController,
                              memosBuilder: memosBuilder)
    }
}
