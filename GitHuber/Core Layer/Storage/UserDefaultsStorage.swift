//
//  UserDefaultsStorage.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 16.07.2022.
//

import Foundation

protocol UserDefaultsStorageProtocol {
    func set(value: Any, key: String)
    func get(key: String) -> Any?
    func delete(key: String)
}

final class UserDefaultsStorage {
    private let userDefaults = UserDefaults.standard
    
    /// Singlton
    static let shared = UserDefaultsStorage()

    // MARK: - Private Init
    private init() {}
}

// MARK: - UserDefaultsStorageProtocol
extension UserDefaultsStorage: UserDefaultsStorageProtocol {
    func set(value: Any, key: String) {
        userDefaults.setValue(value, forKey: key)
    }
    
    func get(key: String) -> Any? {
        userDefaults.value(forKey: key)
    }
    
    func delete(key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
