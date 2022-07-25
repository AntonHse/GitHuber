//
//  UserRepositoriesStorage.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 24.07.2022.
//

import Foundation

protocol UserRepositoriesStorageProtocol {
    func setModel(_ model: [RepositoryResponse])
    func getModel() -> [RepositoryResponse]?
    func deleteModel()
}

final class UserRepositoriesStorage {
    
    private static let key = "UserRepositories"
    private let storage: UserDefaultsStorageWrapperProtocol

    // MARK: - Init
    init(storage: UserDefaultsStorageProtocol) {
        self.storage = UserDefaultsStorageWrapper(storage: storage, key: UserRepositoriesStorage.key)
    }
}

// MARK: - TokenStorageProtocol
extension UserRepositoriesStorage: UserRepositoriesStorageProtocol {
    func setModel(_ model: [RepositoryResponse]) {
        storage.setModel(model)
    }

    func getModel() -> [RepositoryResponse]? {
        return storage.getModel()
    }
    
    func deleteModel() {
        storage.deleteModel()
    }
}
