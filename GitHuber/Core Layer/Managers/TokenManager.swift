//
//  AuthenticationManager.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

final class TokenManagerBuilder {
    
    static func build() -> TokenManagerProtocol {
        let kcStorage = KeyChainStorage.standard
        let tokenStorage = TokenStorage(storage: kcStorage)
        let networkClient = NetworkClient()
        let authenticationService = AuthenticationService(networkClient: networkClient)
        let tokenManager = TokenManager(authenticationService: authenticationService, tokenStorage: tokenStorage)
        
        return tokenManager
    }
    
    // MARK: - Init
    private init() {}
}

protocol TokenManagerProtocol {
    /// Get token from github api
    /// - Parameters:
    ///   - code: Get code from https://github.com/login/oauth/authorize
    ///   - completion: Completion Block
    func getToken(code: String, completion: @escaping (ResultDefault) -> Void)
    /// Get token from local storage
    func getToken() -> String?
    /// Delete token from api github and local storage
    func deleteToken(completion: @escaping (ResultDefault) -> Void)
}

final class TokenManager {
    
    // MARK: - Private Properties
    private let authenticationService: AuthenticationService
    private let tokenStorage: TokenStorageProtocol
    private let service = UsersService(networkClient: NetworkClient())
    // MARK: - Init
    fileprivate init(authenticationService: AuthenticationService, tokenStorage: TokenStorageProtocol) {
        self.authenticationService = authenticationService
        self.tokenStorage = tokenStorage
    }
}

// MARK: - TokenManagerProtocol
extension TokenManager: TokenManagerProtocol {

    func getToken(code: String, completion: @escaping (ResultDefault) -> Void) {
        authenticationService.getToken(model: AccessTokenRequest(code: code)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.tokenStorage.setToken(response.accessToken)
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getToken() -> String? {
        tokenStorage.getToken()
    }

    func deleteToken(completion: @escaping (ResultDefault) -> Void) {
        guard let token = tokenStorage.getToken() else {
            completion(.failure(.default))
            return
        }
        
//        service.fetchUser { [weak self] result in
//            switch result {
//            case .success(let user):
//                print(user.login)
////                self?.getUserRepositories(user: user)
//            case .failure(let error):
//                break
////                self?.presenter.presentAlert()
//            }
//        }
        
        authenticationService.deleteToken(token: token) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success:
                self.tokenStorage.deleteToken()
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
