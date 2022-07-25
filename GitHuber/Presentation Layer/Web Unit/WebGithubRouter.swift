//
//  WebGithubRouter.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 21.07.2022.
//

import AsyncDisplayKit

protocol WebGithubRouterProtocol {
    func closeView()
}

final class WebGithubRouter {
    weak var viewController: ASDKViewController<ASDisplayNode>?
}

// MARK: - WebGithubRouterProtocol
extension WebGithubRouter: WebGithubRouterProtocol {
    func closeView() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
