//
//  MemosInteractor.swift
//  SimpleMemo
//
//  Created by BH on 2022/12/20.
//  Copyright © 2022 eunjin. All rights reserved.
//

import RIBs
import RxSwift

protocol MemosRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MemosPresentable: Presentable {
    var listener: MemosPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol MemosListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MemosInteractor: PresentableInteractor<MemosPresentable>, MemosInteractable, MemosPresentableListener {

    weak var router: MemosRouting?
    weak var listener: MemosListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: MemosPresentable) {
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
}
