//
//  AuthorizationRouter.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

import AsyncDisplayKit

protocol AuthorizationRouterProtocol {
    func routeToRepositoriesList()
}

final class AuthorizationRouter {
    weak var viewController: ASDKViewController<BaseNode>?
}

// MARK: - AuthorizationRouterProtocol
extension AuthorizationRouter: AuthorizationRouterProtocol {
    func routeToRepositoriesList() {
        guard let navController = viewController?.navigationController else { return }
        let repositoriesVC = RepositoriesAssembly.build()

        navController.setViewControllers([repositoriesVC], animated: true)
    }
}
