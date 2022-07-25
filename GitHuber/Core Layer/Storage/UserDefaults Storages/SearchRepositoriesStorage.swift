//
//  SearchRepositoriesStorage.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 24.07.2022.
//

import Foundation

protocol SearchRepositoriesStorageProtocol {
    func setModel(_ model: SearchRepositoriesResponse)
    func getModel() -> SearchRepositoriesResponse?
    func deleteModel()
}

final class SearchRepositoriesStorage {
    
    private static let key = "SearchRepositories"
    private let storage: UserDefaultsStorageWrapperProtocol

    // MARK: - Init
    init(storage: UserDefaultsStorageProtocol) {
        self.storage = UserDefaultsStorageWrapper(storage: storage, key: SearchRepositoriesStorage.key)
    }
}

// MARK: - TokenStorageProtocol
extension SearchRepositoriesStorage: SearchRepositoriesStorageProtocol {
    func setModel(_ model: SearchRepositoriesResponse) {
        storage.setModel(model)
    }

    func getModel() -> SearchRepositoriesResponse? {
        storage.getModel()
    }
    
    func deleteModel() {
        storage.deleteModel()
    }
}

