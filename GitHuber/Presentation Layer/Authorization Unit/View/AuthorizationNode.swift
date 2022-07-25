//
//  AuthorizationNode.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

import AsyncDisplayKit
import Foundation

final class AuthorizationNode: BaseNode {

    // MARK: - Public Properties
    var onSignInButtonTap: (() -> ())?

    // MARK: - Private Properties
    private let imageNode = ASImageNode()
    private let signInRemoteButton = ASContinueButtonNode()

    // MARK: - Init
    override init() {
        super.init()
        configureNode()
    }

    // MARK: - Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let buttonsStackSpec = ASStackLayoutSpec(direction: .vertical,
                                                 spacing: 8,
                                                 justifyContent: .end,
                                                 alignItems: .stretch,
                                                 children: [signInRemoteButton])
        let headerStackSpec = ASStackLayoutSpec(direction: .vertical,
                                                spacing: 40,
                                                justifyContent: .end,
                                                alignItems: .stretch,
                                                children: [buttonsStackSpec, imageNode])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: safeAreaInsets.bottom + 16, right: 16), child: headerStackSpec)
    }
}

// MARK: - Private Extension
private extension AuthorizationNode {
    func configureNode() {
        
        
        signInRemoteButton.backgroundColor = .black
        signInRemoteButton.setTitle("Sign in with GitHub",
                                    with: .boldSystemFont(ofSize: 16), with: .white, for: .normal)
        signInRemoteButton.addTarget(self, action: #selector(signInButtonTapped), forControlEvents: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func signInButtonTapped() {
        onSignInButtonTap?()
    }
}

