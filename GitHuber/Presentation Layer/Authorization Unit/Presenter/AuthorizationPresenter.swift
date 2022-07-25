//
//  AuthorizationPresenter.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 16.07.2022.
//

import AsyncDisplayKit
import AuthenticationServices

protocol AuthorizationPresenterProtocol {
    func presentSignInScreen()
}

final class AuthorizationPresenter: NSObject, ObservableObject {
    weak var viewController: AuthorizationVCProtocol?
    
    // MARK: - Private Properties
    private let router: AuthorizationRouterProtocol
    private var authorizationManager: AuthorizationOAuthManagerProtocol

    // MARK: - Init
    init(router: AuthorizationRouterProtocol,
         authorizationManager: AuthorizationOAuthManagerProtocol) {
        self.router = router
        self.authorizationManager = authorizationManager

        super.init()
        self.authorizationManager.delegate = self
    }
}

// MARK: - MainPresenterProtocol
extension AuthorizationPresenter: AuthorizationPresenterProtocol {
    func presentSignInScreen() {
        authorizationManager.authorize { [weak self] result in
            switch result {
            case .success:
                self?.router.routeToRepositoriesList()
            case .failure(let error):
                self?.handleErrors(error: error)
            }
        }
    }
}

// MARK: - AuthorizationManagerDelegate
extension AuthorizationPresenter: AuthorizationManagerDelegate {
    func startLoading() {
        viewController?.showLoader()
    }
    
    func stopLoading() {
        viewController?.hideLoader()
    }
}

// MARK: - Private Methods
private extension AuthorizationPresenter {
    func handleErrors(error: NetworkErrors) {
        switch error {
        case .gitlabAuthError(let gitlabAuthError):
            switch gitlabAuthError.errorType {
            case .expiredToken:
                presentSignInScreen()
            default:
                viewController?.showAlert(title: gitlabAuthError.errorType.rawValue,
                                          description: gitlabAuthError.description)
            }
        default:
            viewController?.showAlert(title: "Network Error",
                                      description: "Please, try again")
        }
    }
}
