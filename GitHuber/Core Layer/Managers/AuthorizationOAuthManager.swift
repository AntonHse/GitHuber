//
//  AuthorizationManager.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 23.07.2022.
//

import AuthenticationServices

protocol AuthorizationManagerDelegate: AnyObject {
    func startLoading()
    func stopLoading()
}

protocol AuthorizationOAuthManagerProtocol {
    var delegate: AuthorizationManagerDelegate? { get set }
    
    func authorize(completion: @escaping (ResultDefault) -> Void)
}

final class AuthorizationOAuthManager: NSObject, ObservableObject {
    
    weak var delegate: AuthorizationManagerDelegate?
    
    // MARK: - Private Properties
    private let tokenManager: TokenManagerProtocol
    private let service: AuthenticationServiceProtocol
    
    // MARK: - Init
    init(tokenManager: TokenManagerProtocol, service: AuthenticationServiceProtocol) {
        self.tokenManager = tokenManager
        self.service = service
    }
}

// MARK: - AuthorizationManagerProtocol
extension AuthorizationOAuthManager: AuthorizationOAuthManagerProtocol {
    func authorize(completion: @escaping (ResultDefault) -> Void) {
        let request = service.makeAuthorizationUrl(model: .init())

        guard let url = request.url else { return }
        
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: AppSettings.scheme) { [weak self] callbackURL, error in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(.describing(error)))
                return
            }
         
            guard let callbackURL = callbackURL,
                  let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems,
                  let code = queryItems.first(where: { $0.name == "code" })?.value else { return }
            self.delegate?.startLoading()
            self.tokenManager.getToken(code: code) { [weak self] result in
                self?.delegate?.stopLoading()
                
                switch result {
                case .success:
                    completion(.success)
                case .failure(let networkErrors):
                    completion(.failure(networkErrors))
                }
            }
        }
        
        session.presentationContextProvider = self
        session.prefersEphemeralWebBrowserSession = true
        
        session.start()
    }
}

// MARK: - ASWebAuthenticationPresentationContextProviding
extension AuthorizationOAuthManager: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window ?? ASPresentationAnchor()
    }
}
