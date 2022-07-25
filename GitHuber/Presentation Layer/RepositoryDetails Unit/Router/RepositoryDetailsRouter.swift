//
//  RepositoryDetailsRouter.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 21.07.2022.
//

import AsyncDisplayKit
import SafariServices

protocol RepositoryDetailsRouterProtocol {
    func routeToSafari(url: URL)
}

final class RepositoryDetailsRouter {
    weak var viewController: ASDKViewController<BaseNode>?
}

// MARK: - AuthorizationRouterProtocol
extension RepositoryDetailsRouter: RepositoryDetailsRouterProtocol {
    func routeToSafari(url: URL) {       
        let safariViewController = SFSafariViewController(url: url)
        viewController?.present(safariViewController, animated: true, completion: nil)
    }
}
