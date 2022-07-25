//
//  BaseCellNode.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

import AsyncDisplayKit

class BaseCellNode: ASCellNode {
    override init() {
        super.init()
        
        backgroundColor = .white
        automaticallyManagesSubnodes = true
    }
}
