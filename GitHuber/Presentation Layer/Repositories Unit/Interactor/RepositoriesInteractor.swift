//
//  RepositoriesInteractor.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 13.07.2022.
//

import Foundation

protocol RepositoriesInteractorProtocol {
    /// Load authorized user repositories
    func getInitialData()
    /// Upload new repositories during scroolling
    /// - Parameters:
    ///   - text: Searched text
    ///   - element: Last element index in cells array
    func uploadRepositories(for text: String, from element: Int, completion: ((Bool) -> ())?)
    /// Load repositories for searched text
    /// - Parameter text: Searched text
    func getRepositories(for text: String)
    /// Handle transition from user tapped cell
    /// - Parameter id: id of cell
    func handleCellTapped(ownerName: String, repositoryName: String)
    /// Log out authorized user
    func logOutUser()
}

final class RepositoriesInteractor {
    
    // MARK: - Private Properties
    private let presenter: RepositoriesPresenterProtocol
    private let userService: UsersServiceProtocol
    private let searchService: SearchServiceProtocol
    private let tokenManager: TokenManagerProtocol
    
    private let userStorage: UserRepositoriesStorageProtocol
    private let searchStorage: SearchRepositoriesStorageProtocol
    
    private var isUploadNeeded = false
    private var pageCounter = 1
    
    // MARK: - Init
    init(presenter: RepositoriesPresenterProtocol,
         searchService: SearchServiceProtocol,
         userService: UsersServiceProtocol,
         tokenManager: TokenManagerProtocol,
         userStorage: UserRepositoriesStorageProtocol,
         searchStorage: SearchRepositoriesStorageProtocol) {
        self.presenter = presenter
        self.searchService = searchService
        self.tokenManager = tokenManager
        self.userService = userService
        self.userStorage = userStorage
        self.searchStorage = searchStorage
    }
}

// MARK: - RepositoriesInteractorProtocol
extension RepositoriesInteractor: RepositoriesInteractorProtocol {
    func getInitialData() {
        if let model = searchStorage.getModel() {
            presenter.presentData(model, upload: false)
        } else if let model = userStorage.getModel(){
            presenter.presentData(model, upload: false)
        } else {
            userService.fetchUser { [weak self] result in
                switch result {
                case .success:
                    self?.getUserRepositories()
                case .failure(let error):
                    self?.presenter.presentAlert(error: error)
                }
            }
        }
    }
    
    func getRepositories(for text: String) {
        pageCounter = 1
        fetchRepositories(for: text, page: pageCounter)
    }
    
    func uploadRepositories(for text: String, from element: Int, completion: ((Bool) -> ())?) {
        guard isUploadNeeded else {
            completion?(false)
            return
        }
        guard !text.isEmpty else {
            completion?(false)
            getUserRepositories(page: pageCounter)
            return
        }

        pageCounter += 1
        fetchRepositories(for: text, page: pageCounter, upload: true, completion: completion)
    }
    
    func handleCellTapped(ownerName: String, repositoryName: String) {
        presenter.presentResositoryDetails(ownerName: ownerName, repositoryName: repositoryName)
    }
    
    func logOutUser() {
        tokenManager.deleteToken { [weak self] result in
            switch result {
            case .success:
                self?.userStorage.deleteModel()
                self?.searchStorage.deleteModel()
            
                self?.presenter.presentAuthorizationScreen()
            case .failure(let error):
                self?.presenter.presentAlert(error: error)
            }
        }
        
    }
}

// MARK: - Private Extension
private extension RepositoriesInteractor {
    func fetchRepositories(for text: String, page: Int, upload: Bool = false, completion: ((Bool) -> ())? = nil) {
        searchService.fetchRepositories(for: text, sortType: nil, orderType: .desc, page: page, perPage: nil) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                self.searchStorage.setModel(response)
                self.isUploadNeeded = response.totalCount ?? 101 > 100
                self.presenter.presentData(response, upload: upload)
    
                completion?(true)
            case .failure(let error):
                completion?(false)
                
                self.presenter.presentAlert(error: error)
            }
        }
    }
    
    func getUserRepositories(page: Int = 1) {
        userService.fetchUserRepositories(model: .init()) { [weak self]  result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                self.userStorage.setModel(response)
                self.isUploadNeeded = response.count > 100
                self.presenter.presentData(response, upload: false)
            case .failure(let error):
                self.presenter.presentAlert(error: error)
            }
        }
    }
}
