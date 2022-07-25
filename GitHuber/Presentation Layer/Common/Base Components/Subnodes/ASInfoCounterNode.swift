//
//  ASInfoCounterNode.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 25.07.2022.
//

import AsyncDisplayKit

final class ASInfoCounterNode: BaseNode {
    
    // MARK: - Private Properties
    private let image = ASImageNode()
    private let counterText = ASTextNode()
    private let descriptionText = ASTextNode()
    
    // MARK: - Init
    override init() {
        super.init()
        
        configureNode()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let hStack = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 4,
                                       justifyContent: .start,
                                       alignItems: .center,
                                       children: [image, counterText, descriptionText])
        return hStack
    }

    // MARK: - Public Methods
    func set(imageType: Images, number: Int, description: String) {
        image.image = imageType.image
        counterText.attributedText = number.formatPoints.smallBold()
        descriptionText.attributedText = description.small(color: Colors.placeholderText)
    }
}

// MARK: - Private Methods
private extension ASInfoCounterNode {
    func configureNode() {
        image.style.preferredSize = CGSize(width: 14, height: 14)
        image.tintColor = .gray
    }
}

