//
//  ASContinueButtonNode.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

import AsyncDisplayKit

final class ASContinueButtonNode: ASButtonNode {
    
    static let height: CGFloat = 60
    
    // MARK: - Init
    override init() {
        super.init()
        
        style.preferredSize.height = ASContinueButtonNode.height
        cornerRadius = style.preferredSize.height / 2
    }

    // MARK: - Public Methods
    func setText() {
        
    }
}
