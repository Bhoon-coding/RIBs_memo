//
//  Navigator.swift
//  SimpleMemo
//
//  Created by eunjin Jo on 31/05/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation
import UIKit

class Navigator {
    class func presentAlert(with message: String) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
}
