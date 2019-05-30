//
//  MemosVM.swift
//  SimpleMemo
//
//  Created by eunjin Jo on 26/05/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct MemosViewModel {
    
    struct State {
        var memos: BehaviorRelay<[Memo]> = BehaviorRelay.init(value: [])
    }
    
    struct Action {
        let deleteMemo = PublishSubject<Memo>()
        let changeMemo = PublishSubject<Memo>()
    }
    
    let state = State()
    let action = Action()
    private let bag = DisposeBag()
    
    init() {
        action.deleteMemo.subscribe(onNext: { memo in
            FirebaseManager.delete(key: memo.ID)
        }).disposed(by: bag)
        
        action.changeMemo.subscribe(onNext: { memo in
            FirebaseManager.change(key: memo.ID, to: memo)
        }).disposed(by: bag)

        FirebaseManager.fetchAll()
            .bind(to: state.memos)
            .disposed(by: bag)
    }
}
