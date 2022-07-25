//
//  ViewController.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 13.07.2022.
//

import AsyncDisplayKit

final class RepositoriesAssembly {

    static func build() -> ASDKViewController<BaseNode> {
        let networkClient = NetworkClient()
        let searchService = SearchService(networkClient: networkClient)
        let userService = UsersService(networkClient: networkClient)
        let tokenManager = TokenManagerBuilder.build()
        
        let storage = UserDefaultsStorage.shared
        let userStorage = UserRepositoriesStorage(storage: storage)
        let searchStorage = SearchRepositoriesStorage(storage: storage)
        
        let router = RepositoriesRouter()
        let presenter = RepositoriesPresenter(router: router)
        let interactor = RepositoriesInteractor(presenter: presenter, searchService: searchService, userService: userService, tokenManager: tokenManager, userStorage: userStorage, searchStorage: searchStorage)
        let viewController = RepositoriesVC(interactor: interactor)

        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }

    // MARK: - Private Init
    private init() {}
}
