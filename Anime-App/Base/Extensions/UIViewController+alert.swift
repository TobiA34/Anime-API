//
//  UIAlertController+alert.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 12/08/2023.
//

import UIKit

extension UIViewController {
    func showAlert(title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
