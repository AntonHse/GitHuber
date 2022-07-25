//
//  AppDependencyContainer.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 22.07.2022.
//

import AsyncDisplayKit

final class AppDependencyContainerBuilder {
    static func build() -> AppDependencyContainerProtocol {
        let tokenManager = TokenManagerBuilder.build()
        let dependencyContainer = AppDependencyContainer(tokenManager: tokenManager)

        return dependencyContainer
    }
    
    // MARK: - Private Init
    private init() {}
}

protocol AppDependencyContainerProtocol {
    func getFistScreen() -> ASDKViewController<BaseNode>
}

final class AppDependencyContainer {
    
    private let tokenManager: TokenManagerProtocol

    // MARK: - Init
    fileprivate init(tokenManager: TokenManagerProtocol) {
        self.tokenManager = tokenManager
    }
}

// MARK: - AppDependencyContainerProtocol
extension AppDependencyContainer: AppDependencyContainerProtocol {
    func getFistScreen() -> ASDKViewController<BaseNode> {
        deleteDataFromKeyChainIfNeeded()
        
        if let _ = tokenManager.getToken() {
            return RepositoriesAssembly.build()
        } else {
            return AuthorizationAssembly.build()
        }
    }
}

private extension AppDependencyContainer {
    
    func deleteDataFromKeyChainIfNeeded() {
        let storage = UserDefaultsStorage.shared
        let tokenStorage = TokenStorage(storage: KeyChainStorage.standard)

        if storage.get(key: "hasRunBefore") == nil {
            tokenStorage.deleteToken()
             
            storage.set(value: "hasRunBefore", key: "hasRunBefore")
        }
    }
}
