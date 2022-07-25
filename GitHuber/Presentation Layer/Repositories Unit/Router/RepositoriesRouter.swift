//
//  RepositoriesRouter.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 19.07.2022.
//

import AsyncDisplayKit

protocol RepositoriesRouterProtocol {
    func routeToRepositoryDetailsVC(ownerName: String, repositoryName: String)
    func routeToAuthorizationScreen()
}

final class RepositoriesRouter {
    weak var viewController: ASDKViewController<BaseNode>?
}

// MARK: - AuthorizationRouterProtocol
extension RepositoriesRouter: RepositoriesRouterProtocol {
    func routeToRepositoryDetailsVC(ownerName: String, repositoryName: String) {
        guard let navController = viewController?.navigationController else { return }
       
        let repositoryDetailsVC = RepositoryDetailsAssembly.build(ownerName: ownerName, repositoryName: repositoryName)
        navController.pushViewController(repositoryDetailsVC, animated: true)
    }
    
    func routeToAuthorizationScreen() {
        guard let navController = viewController?.navigationController else { return }

        let authorizationVC = AuthorizationAssembly.build()
        navController.setViewControllers([authorizationVC], animated: true)
    }
}
