//
//  ASProfileInfoNode.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

import AsyncDisplayKit

final class ASProfileInfoNode: BaseNode, ViewDataSettableProtocol {

    // MARK: - Private Properties
    private let profileImage = ASNetworkImageNode()
    private let profileName = ASTextNode()
    
    // MARK: - Init
    override init() {
        super.init()
        
        configureNode()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let hStack = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 6,
                                       justifyContent: .start,
                                       alignItems: .center,
                                       children: [profileImage, profileName])
        return hStack
    }

    // MARK: - Public Methods
    func set(model: ProfileInfoNodeModel) {
        if let imageUrl = model.imageUrl {
            profileImage.url = URL(string: imageUrl)
        }
        
        if let text = model.text {
            profileName.attributedText = text.custom(color: Colors.placeholderText, fontSize: 16)
        }
    }
}

// MARK: - Private Methods
private extension ASProfileInfoNode {
    func configureNode() {
        profileImage.style.preferredSize = CGSize(width: 20, height: 20)
        profileImage.cornerRadius = profileImage.style.preferredSize.height / 2
    }
}
