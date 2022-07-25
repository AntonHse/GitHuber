//
//  ASHeaderNode.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 25.07.2022.
//

import AsyncDisplayKit

final class ASHeaderNode: BaseCellNode {
    
    // MARK: - Private Properties
    private let image = ASImageNode()
    private let text = ASTextNode()
    
    // MARK: - Init
    override init() {
        super.init()
        
        configureNode()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let hStack = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 10,
                                       justifyContent: .start,
                                       alignItems: .center,
                                       children: [image, text])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15, left: 16, bottom: 0, right: 16), child: hStack)
    }

    // MARK: - Public Methods
    func set(imageType: Images, description: String) {
        text.attributedText = description.small(color: Colors.placeholderText)
        image.image = imageType.image
    }
}

// MARK: - Private Methods
private extension ASHeaderNode {
    func configureNode() {
        backgroundColor = Colors.header
        image.style.preferredSize = CGSize(width: 14, height: 14)
        text.maximumNumberOfLines = 1
    }
}

