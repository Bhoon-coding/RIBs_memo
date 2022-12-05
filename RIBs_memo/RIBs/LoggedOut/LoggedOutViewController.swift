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
    
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    
    @IBOutlet weak var player1NameTF: UITextField!
    @IBOutlet weak var player2NameTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    weak var listener: LoggedOutPresentableListener?
    
    @IBAction func tapLoginButton(_ sender: Any) {
        
    }
}
