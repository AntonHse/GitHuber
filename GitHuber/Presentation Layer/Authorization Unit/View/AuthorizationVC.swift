//
//  AuthorizationViewContrller.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 16.07.2022.
//

import AsyncDisplayKit
import WebKit

protocol AuthorizationVCProtocol: AnyObject {
    func showLoader()
    func hideLoader()
    func showAlert(title: String, description: String)
}

final class AuthorizationVC: ASDKViewController<BaseNode> {
    
    // MARK: - Private Properties
    private let alertFactory: AlertFactoryProtocol
    private let presenter: AuthorizationPresenter
    private let contentNode: AuthorizationNode
    
    private lazy var loader: UIActivityIndicatorView = {
        return UIActivityIndicatorView(style: .medium)
    }()

    // MARK: - Init
    init(presenter: AuthorizationPresenter, alertFactory: AlertFactoryProtocol) {
        self.presenter = presenter
        self.contentNode = AuthorizationNode()
        self.alertFactory = alertFactory

        super.init(node: BaseNode())
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        // Center the activity indicator view
        let bounds = node.bounds
        loader.frame.origin = CGPoint(
            x: (bounds.width - loader.frame.width) / 2.0,
            y: (bounds.height - loader.frame.height) / 2.0
        )
    }

    // MARK: - Layout
    private func setupLayout() {
        node.addSubnode(contentNode)
        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASInsetLayoutSpec() }
            return ASInsetLayoutSpec(insets: .zero, child: self.contentNode)
        }
    }
}

// MARK: - AuthorizationVCProtocol
extension AuthorizationVC: AuthorizationVCProtocol {
    func showLoader() {
        loader.isHidden = false
        loader.startAnimating()
    }
    
    func hideLoader() {
        loader.isHidden = true
        loader.stopAnimating()
    }
    
    func showAlert(title: String, description: String) {
        alertFactory.showAlert(title: title, description: description)
    }
}

// MARK: - Private Methods
private extension AuthorizationVC {
    func configureView() {
        contentNode.view.addSubview(loader)
        contentNode.onSignInButtonTap = { [weak self] in
            self?.presenter.presentSignInScreen()
        }
    }
}
