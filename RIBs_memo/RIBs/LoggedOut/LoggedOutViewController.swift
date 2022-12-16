//
//  LoggedOutViewController.swift
//  RIBs_memo
//
//  Created by BH on 2022/12/06.
//

import RIBs
import RxSwift
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
        bind()
        setNavigationBar()
        view.backgroundColor = .white
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "MintColor") ?? .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = "Simple Memo"
    }
    
    
    func bind() {
        Observable.combineLatest(emailTextField.rx.text.orEmpty, passwordTextField.rx.base.text.orEmp, resultSelector: <#T##(ObservableType.E, ObservableType.E) throws -> _#>)
    }
    
    @IBAction func tapLoginButton(_ sender: Any) {
        listener?.handleLogin(player1Name: emailTextField.text ?? "",
                              player2Name: passwordTextField.text ?? "")
    }
}
