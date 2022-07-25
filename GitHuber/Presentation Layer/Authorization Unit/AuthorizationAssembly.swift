//
//  AuthorizationAssembly.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 16.07.2022.
//

import AsyncDisplayKit

final class AuthorizationAssembly {

    static func build() -> ASDKViewController<BaseNode> {
        let tokenManager = TokenManagerBuilder.build()
        let networkClient = NetworkClient()
        let service = AuthenticationService(networkClient: networkClient)
        let authorizationManager = AuthorizationOAuthManager(tokenManager: tokenManager,
                                                             service: service)
        let alertFactory = AlertFactory()

        let router = AuthorizationRouter()
        let presenter = AuthorizationPresenter(router: router, authorizationManager: authorizationManager)
        let viewController = AuthorizationVC(presenter: presenter, alertFactory: alertFactory)
        
        presenter.viewController = viewController
        router.viewController = viewController
        alertFactory.viewController = viewController
        
        return viewController
    }
    
    // MARK: - Private Init
    private init() {}
}
