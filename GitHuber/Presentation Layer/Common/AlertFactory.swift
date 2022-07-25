//
//  AlertFactory.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 24.07.2022.
//

import AsyncDisplayKit

protocol AlertFactoryProtocol {
    func showAlert(title: String, description: String)
    func showAlert(title: String, description: String, buttonName: String?)
}

final class AlertFactory {
    weak var viewController: ASDKViewController<BaseNode>?
}

// MARK: - AlertFactoryProtocol
extension AlertFactory: AlertFactoryProtocol {
    func showAlert(title: String, description: String) {
        showAlert(title: title, description: description, buttonName: nil)
    }

    func showAlert(title: String, description: String, buttonName: String?) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let okButton = UIAlertAction(title: buttonName ?? "Ok", style: .default, handler: nil)

        alert.addAction(okButton)

        viewController?.present(alert, animated: true)
    }
}
