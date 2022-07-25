//
//  RepositoryDetailsAssembly.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 18.07.2022.
//

import UIKit

final class RepositoryDetailsAssembly {

    static func build(ownerName: String, repositoryName: String) -> UIViewController {
        let networkClient = NetworkClient()
        let service = RepositoryService(networkClient: networkClient)
        let factory = ReadmeFactory()
        
        let router = RepositoryDetailsRouter()
        let presenter = RepositoryDetailsPresenter(router: router, readmeFactory: factory)
        let interactor = RepositoryDetailsInteractor(ownerName: ownerName,
                                                     repositoryName: repositoryName,
                                                     presenter: presenter,
                                                     service: service)
        let viewController = RepositoryDetailsVC(interactor: interactor)

        router.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }

    // MARK: - Private Init
    private init() {}
}
