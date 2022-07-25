//
//  RepositoriesPresenter.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 13.07.2022.
//

protocol RepositoriesPresenterProtocol {
    func presentData(_ data: [RepositoryResponse], upload: Bool)
    func presentData(_ data: SearchRepositoriesResponse, upload: Bool)

    func presentResositoryDetails(ownerName: String, repositoryName: String)
    func presentAuthorizationScreen()
    func presentAlert(error: Error)
}

final class RepositoriesPresenter {
    
    weak var viewController: RepositoriesVCProtocol?

    // MARK: - Private Properties
    private let router: RepositoriesRouterProtocol

    // MARK: - Init
    init(router: RepositoriesRouterProtocol) {
        self.router = router
    }
}

// MARK: - RepositoriesPresenterProtocol
extension RepositoriesPresenter: RepositoriesPresenterProtocol {
    func presentData(_ data: SearchRepositoriesResponse, upload: Bool) {
        var cells: [RepositoryCellNodeModel] = []
        data.items.forEach { itemModel in
            let profileInfo = ProfileInfoNodeModel(imageUrl: itemModel.owner?.avatarUrl, text: itemModel.owner?.login)
            let cell = RepositoryCellNodeModel(id: itemModel.id,
                                               profileInfo: profileInfo,
                                               name: itemModel.name ?? "",
                                               description: itemModel.descriptionField,
                                               rating: itemModel.watchersCount,
                                               language: itemModel.language)
            cells.append(cell)
        }
        upload ? viewController?.insert(cells: cells) : viewController?.set(cells: cells)
    }
    
    func presentData(_ data: [RepositoryResponse], upload: Bool) {
        var cells: [RepositoryCellNodeModel] = []
        data.forEach { itemModel in
            let profileInfo = ProfileInfoNodeModel(imageUrl: itemModel.owner?.avatarUrl, text: itemModel.owner?.login)
            let cell = RepositoryCellNodeModel(id: itemModel.id,
                                               profileInfo: profileInfo,
                                               name: itemModel.name ?? "",
                                               description: itemModel.descriptionField,
                                               rating: itemModel.watchersCount,
                                               language: itemModel.language)
            cells.append(cell)
        }
        upload ? viewController?.insert(cells: cells) : viewController?.set(cells: cells)
    }
    
    func presentResositoryDetails(ownerName: String, repositoryName: String) {
        router.routeToRepositoryDetailsVC(ownerName: ownerName, repositoryName: repositoryName)
    }
    
    func presentAuthorizationScreen() {
        router.routeToAuthorizationScreen()
    }
    
    func presentAlert(error: Error) {
        // make alert factory and handle errors
    }
}
