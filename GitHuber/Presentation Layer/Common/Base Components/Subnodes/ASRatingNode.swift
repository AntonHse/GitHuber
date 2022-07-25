//
//  ASRatingNode.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

import AsyncDisplayKit

final class ASRatingNode: BaseNode {
    
    // MARK: - Private Properties
    private let starImage = ASImageNode()
    private let ratingText = ASTextNode()
    
    // MARK: - Init
    override init() {
        super.init()
        
        configureNode()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let hStack = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 4,
                                       justifyContent: .spaceBetween,
                                       alignItems: .center,
                                       children: [starImage, ratingText])
        return hStack
    }

    // MARK: - Public Methods
    func set(rating number: Int) {
        ratingText.attributedText = String(number.formattedWithSeparator).normal(color: Colors.placeholderText)
    }
}

// MARK: - Private Methods
private extension ASRatingNode {
    func configureNode() {
        starImage.style.preferredSize = CGSize(width: 14, height: 14)
        starImage.tintColor = .gray
        starImage.image = Images.star.image
    }
}
