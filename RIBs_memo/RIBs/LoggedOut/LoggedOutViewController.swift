//
//  LoggedOutViewController.swift
//  RIBs_memo
//
//  Created by BH on 2022/12/06.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol LoggedOutPresentableListener: AnyObject {
    func handleLogin(player1Name: String, player2Name: String)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    weak var listener: LoggedOutPresentableListener?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.combineLatest(emailTextField.rx.text.orEmpty, passwordTextField.rx.text.orEmpty) {
            email, password -> Bool in
            return LoginTextInputManager.isValidEmail(email) && LoginTextInputManager.isValidPassword(password)
        }
        .subscribe(onNext: { [weak self] isValid in
            self?.loginButton.isEnabled = isValid
        }).disposed(by: disposeBag)
        
        loginButton.rx.tap.map { [weak self] _ in
            return (self?.emailTextField.text ?? "", self?.passwordTextField.text ?? "")
        }.subscribe(onNext: { email, password in
            
        }).disposed(by: disposeBag)
        
    }
    
    @IBAction func tapLoginButton(_ sender: Any) {
        listener?.handleLogin(player1Name: emailTextField.text ?? "",
                              player2Name: passwordTextField.text ?? "")
    }
}
