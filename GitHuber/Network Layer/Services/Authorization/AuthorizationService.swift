//
//  AuthorizationService.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 16.07.2022.
//

import Foundation

protocol AuthenticationServiceProtocol {
    
    typealias Completion = (Result<Token, NetworkErrors>) -> Void

    func makeAuthorizationUrl(model: GithubWebAuthorizeRequest) -> URLRequest
    func authorize(model: GithubWebAuthorizeRequest, completion: (Result<String, NetworkErrors>) -> Void)

    func getToken(model: AccessTokenRequest, completion: @escaping (Result<Token, NetworkErrors>) -> Void)
    func checkToken(token: String, completion: @escaping (ResultDefault) -> Void)
    func deleteToken(token: String, completion: @escaping (ResultDefault) -> Void)
}

/// Service for user authentication
final class AuthenticationService {

    // MARK: - Private Properties
    private let networkClient: NetworkClientProtocol
    
    private struct Path {
        static let webAuthorization = "login/oauth/authorize"
        static let accessToken = "login/oauth/access_token"
    }
    
    // MARK: - Init
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
}

// MARK: - AuthenticationServiceProtocol
extension AuthenticationService: AuthenticationServiceProtocol {
    func authorize(model: GithubWebAuthorizeRequest, completion: (Result<String, NetworkErrors>) -> Void) {
        var parameters: [String: String] = [AuthenticationKeys.clientID.rawValue: model.clientID,
                                            AuthenticationKeys.state.rawValue: model.state,
                                            AuthenticationKeys.allowSignup.rawValue: model.allowSignup.description]
        
        if let login = model.login {
            parameters[AuthenticationKeys.login.rawValue] = login
        }
        if let redirectUri = model.redirectUri {
            parameters[AuthenticationKeys.redirectUri.rawValue] = redirectUri
        }
        if !model.scope.isEmpty {
            parameters[AuthenticationKeys.scope.rawValue] = model.scope.map { $0.rawValue }.joined(separator: " ")
        }
        
        let request = Request<Int>(baseURL: Domains.github,
                                   path: Path.webAuthorization,
                                   type: .urlParameters(parameters))
        networkClient.sendRequest(request: request) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }

    func getToken(model: AccessTokenRequest, completion: @escaping (Result<Token, NetworkErrors>) -> Void) {
        var parameters: [String: String] = [AccessTokenKeys.clientID.rawValue: model.clientId,
                                            AccessTokenKeys.clientSecret.rawValue: model.clientSecret,
                                            AccessTokenKeys.code.rawValue: model.code]
        if let redirectUri = model.redirectUri {
            parameters[AccessTokenKeys.redirectUri.rawValue] = redirectUri
        }
        
        let request = Request<Token>(baseURL: Domains.github,
                                     path: Path.accessToken,
                                     type: .urlParameters(parameters),
                                     headers: ["Accept": "application/json"])

        networkClient.sendRequest(request: request) { result in
            switch result {
            case .success(let response):
                guard let data = response as? Token else {
                    completion(.failure(NetworkErrors.default))
                    return
                }
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func checkToken(token: String, completion: @escaping (ResultDefault) -> Void) {
        // TODO: Logic in Authorization Client

        let parameters: [String: String] = [TokenKeys.token.rawValue: token]
        let request = Request<String>(path: "/applications/\(GithubGlobalKeys.clientID)/token",
                                      type: .bodyParameters(parameters),
                                      httpMethod: .post,
                                      headers: ["Accept": "application/json"],
                                      authorizationCredentionals: .init(username: GithubGlobalKeys.clientID, password: GithubGlobalKeys.clientSecret))

        networkClient.sendRequest(request: request) { result in
            switch result {
            case .success:
                completion(.success)
            case .failure(let error):
                completion(.failure(NetworkErrors.describing(error)))
            }
        }
    }
    
    func deleteToken(token: String, completion: @escaping (ResultDefault) -> Void) {
        let parameters: [String: String] = [TokenKeys.token.rawValue: token]
        let request = Request<Bool>(path: "/applications/\(GithubGlobalKeys.clientID)/grant",
                                    type: .bodyParameters(parameters),
                                    httpMethod: .delete,
                                    headers: ["Accept": "application/vnd.github.v3+json"],
                                    authorizationCredentionals: .init(username: GithubGlobalKeys.clientID, password: GithubGlobalKeys.clientSecret))

        networkClient.sendRequest(request: request) { result in
            switch result {
            case .success:
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func makeAuthorizationUrl(model: GithubWebAuthorizeRequest) -> URLRequest {
        var parameters: [String: String] = [AuthenticationKeys.clientID.rawValue: model.clientID,
                                            AuthenticationKeys.state.rawValue: model.state,
                                            AuthenticationKeys.allowSignup.rawValue: model.allowSignup.description]
        
        if let login = model.login {
            parameters[AuthenticationKeys.login.rawValue] = login
        }
        if let redirectUri = model.redirectUri {
            parameters[AuthenticationKeys.redirectUri.rawValue] = redirectUri
        }
        if !model.scope.isEmpty {
            parameters[AuthenticationKeys.scope.rawValue] = model.scope.map { $0.rawValue }.joined(separator: " ")
        }
        let request = Request<String>(baseURL: Domains.github, // TODO: УБрать дженерик
                                   path: Path.webAuthorization,
                                   type: .urlParameters(parameters))
        return networkClient.buildRequest(request: request)
    }
}

// MARK: - Private Keys
private extension AuthenticationService {
    enum ParametersKeys: String {
        case email
        case password
    }
    
    enum AuthenticationKeys: String {
        case clientID = "client_id"
        case redirectUri = "redirect_uri"
        case scope
        case login
        case state
        case allowSignup = "allow_signup"
    }
    
    enum AccessTokenKeys: String {
        case clientID = "client_id"
        case clientSecret = "client_secret"
        case code
        case redirectUri = "redirect_uri"
    }
    
    enum TokenKeys: String {
        case token = "access_token"
    }
}
