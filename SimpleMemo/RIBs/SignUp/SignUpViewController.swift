//
//  SignUpViewController.swift
//  SimpleMemo
//
//  Created by BH on 2022/12/20.
//  Copyright © 2022 eunjin. All rights reserved.
//

import RIBs
import RxCocoa
import RxSwift
import UIKit

protocol SignUpPresentableListener: AnyObject {
    func navigationBackDidTap()
    func signupDidTap(email: String, password: String)
}

final class SignUpViewController: UIViewController, SignUpPresentable, SignUpViewControllable {

    weak var listener: SignUpPresentableListener?
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    private func bindUI() {
        Observable.combineLatest(emailTextField.rx.text.orEmpty, passwordTextField.rx.text.orEmpty) { email, password -> Bool in
            return LoginTextInputManager.isValidEmail(email) && LoginTextInputManager.isValidPassword(password)
        }
        .subscribe(onNext: { [weak self] isValid in
            self?.signupButton.isEnabled = isValid
        }).disposed(by: disposeBag)
        
        signupButton.rx.tap.map { [weak self] _ in
            return (self?.emailTextField.text ?? "", self?.passwordTextField.text ?? "")
        }.subscribe(onNext: { [weak self] email, password in
            self?.listener?.signupDidTap(email: email, password: password)
        }).disposed(by: disposeBag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            listener?.navigationBackDidTap()
        }
    }
}
