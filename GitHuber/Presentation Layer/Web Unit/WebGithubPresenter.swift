//
//  WebPresenter.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 21.07.2022.
//

import Foundation

protocol WebGithubPresenterProtocol {
    var urlRequest: URLRequest { get }
    
    func handleUrl(url: URL?)
}

final class WebGithubPresenter {
    weak var viewController: WebGithubVCProtocol?

    let urlRequest: URLRequest
    
    // MARK: - Private Properties
    private let tokenManager: TokenManagerProtocol
    private let router: WebGithubRouterProtocol

    // MARK: - Init
    init(router: WebGithubRouterProtocol, tokenManager: TokenManagerProtocol, urlRequest: URLRequest) {
        self.router = router
        self.tokenManager = tokenManager
        self.urlRequest = urlRequest
    }
}

// MARK: - WebPresenterProtocol
extension WebGithubPresenter: WebGithubPresenterProtocol {
    func handleUrl(url: URL?) {
        guard let url = url,
              let urlComponents = URLComponents(string: url.absoluteString),
              let queryItem = urlComponents.queryItems?.first(where: { $0.name == "code" }),
              let code = queryItem.value else { return }
        
        tokenManager.getToken(code: code) { [weak self] result in
            switch result {
            case .success:
                self?.router.closeView()
            case .failure:
                break
            }
        }
    }
    func presentPreviousScreen() {
        
    }
}
