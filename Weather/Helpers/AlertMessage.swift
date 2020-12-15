//
//  AlertMessage.swift
//  Weather
//
//  Created by Mehmet on 15.12.2020.
//  Copyright © 2020 Mehmet. All rights reserved.
//

import UIKit
import Foundation

struct AlertMessage {
    func alertMessage(message: String, viewController: UIViewController){
        let alertController = UIAlertController(title: "Caution", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okButton)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
