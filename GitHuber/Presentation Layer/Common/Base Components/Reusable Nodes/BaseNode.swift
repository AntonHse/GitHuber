//
//  BaseNode.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

import AsyncDisplayKit

class BaseNode: ASDisplayNode {
    override init() {
        super.init()

        backgroundColor = .white
        automaticallyManagesSubnodes = true
    }
}
