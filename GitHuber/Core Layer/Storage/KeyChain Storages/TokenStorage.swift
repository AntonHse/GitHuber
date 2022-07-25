//
//  TokenStorage.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 23.07.2022.
//

import Foundation

protocol TokenStorageProtocol {
    func setToken(_ value: String)
    func getToken() -> String?
    func deleteToken()
}

final class TokenStorage {
    
    private let storage: KeyChainStorageProtocol
    
    private let serviceName = "access-token"
    private let accountName = "github"

    // MARK: - Init
    init(storage: KeyChainStorageProtocol) {
        self.storage = storage
    }
}

// MARK: - TokenStorageProtocol
extension TokenStorage: TokenStorageProtocol {
    func setToken(_ value: String) {
        let data = Data(value.utf8)
        storage.save(data, service: serviceName, account: accountName)
    }

    func getToken() -> String? {
        guard let data = storage.read(service: serviceName, account: accountName) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func deleteToken() {
        storage.delete(service: serviceName, account: accountName)
    }
}
