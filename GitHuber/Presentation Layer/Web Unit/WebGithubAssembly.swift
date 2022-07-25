//
//  WebAssembly.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 21.07.2022.
//

import AsyncDisplayKit

final class WebGithubAssembly {

    static func build(urlRequest: URLRequest) -> ASDKViewController<ASDisplayNode> {
        let tokenManager = TokenManagerBuilder.build()

        let router = WebGithubRouter()
        let presenter = WebGithubPresenter(router: router, tokenManager: tokenManager, urlRequest: urlRequest)
        let viewController = WebGithubVC(presenter: presenter)
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }

    // MARK: - Private Init
    private init() {}
}
