import RIBs
import RxSwift

protocol AddMemoRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AddMemoPresentable: Presentable {
    var listener: AddMemoPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol AddMemoListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func navigationBack()
}

final class AddMemoInteractor: PresentableInteractor<AddMemoPresentable>, AddMemoInteractable {
    
    weak var router: AddMemoRouting?
    weak var listener: AddMemoListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: AddMemoPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func navigationBackDidTap() {
        listener?.navigationBack()
    }
}

extension AddMemoInteractor: AddMemoPresentableListener {
    func saveMemo(_ memo: Memo) {
        FirebaseManager.add(memo: memo)
    }
}
