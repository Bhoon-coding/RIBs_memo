//
//  SignUpViewController.swift
//  SimpleMemo
//
//  Created by BH on 2022/12/20.
//  Copyright © 2022 eunjin. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol SignUpPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SignUpViewController: UIViewController, SignUpPresentable, SignUpViewControllable {

    weak var listener: SignUpPresentableListener?
}
