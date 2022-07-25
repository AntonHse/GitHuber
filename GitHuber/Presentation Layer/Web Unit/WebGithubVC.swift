//
//  WebVC.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

import AsyncDisplayKit
import WebKit
import AuthenticationServices

protocol WebGithubVCProtocol: AnyObject {
    
}

final class WebGithubVC: ASDKViewController<ASDisplayNode> {
    
    // MARK: - Private Properties
    private let webView: WKWebView
    private let presenter: WebGithubPresenterProtocol

    // MARK: - Init
    init(presenter: WebGithubPresenterProtocol) {
        self.webView = WKWebView()
        self.presenter = presenter
        super.init(node: ASDisplayNode())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        loadWevView()
    }
}

// MARK: - WebGithubVCProtocol
extension WebGithubVC: WebGithubVCProtocol {
    
}

// MARK: - WKNavigationDelegate
extension WebGithubVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        presenter.handleUrl(url: webView.url)
    }
}

extension WebGithubVC: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window ?? ASPresentationAnchor()
    }
}

// MARK: - Private Methods
private extension WebGithubVC {
    func configureWebView() {
        webView.navigationDelegate = self
        view = webView
    }
    
    func loadWevView() {

//        webView.load(presenter.urlRequest)
//        webView.allowsBackForwardNavigationGestures = true
    }
}
