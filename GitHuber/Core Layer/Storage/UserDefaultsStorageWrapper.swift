//
//  UserDefaultsStorageWrapper.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 24.07.2022.
//

import Foundation

protocol UserDefaultsStorageWrapperProtocol {
    init(storage: UserDefaultsStorageProtocol, key: String)
    
    func setModel<Model: Codable>(_ model: Model)
    func getModel<Model: Codable>() -> Model?
    func deleteModel()
}

final class UserDefaultsStorageWrapper {
    
    private let concurrentQueue = DispatchQueue(label: "com.gitHuber.UserDefaultsStorageWrapper",
                                                attributes: .concurrent)
    
    private let key: String
    private let storage: UserDefaultsStorageProtocol

    // MARK: - Init
    init(storage: UserDefaultsStorageProtocol, key: String) {
        self.storage = storage
        self.key = key
    }
}

// MARK: - TokenStorageProtocol
extension UserDefaultsStorageWrapper: UserDefaultsStorageWrapperProtocol {
    func setModel<Model: Codable>(_ model: Model) {
        concurrentQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            let encoder = JSONEncoder()
            if let encodedModel = try? encoder.encode(model) {
                self.storage.set(value: encodedModel, key: self.key)
            }
        }
    }

    func getModel<Model: Codable>() -> Model? {
        let decoder = JSONDecoder()
        guard let savedModel = storage.get(key: key) as? Data,
              let loadedModel = try? decoder.decode(Model.self, from: savedModel) else { return nil }
        return loadedModel
    }
    
    func deleteModel() {
        concurrentQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.storage.delete(key: self.key)
        }
    }
}
