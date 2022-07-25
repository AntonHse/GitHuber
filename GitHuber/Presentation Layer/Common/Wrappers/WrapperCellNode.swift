//
//  WrapperCellNode.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 20.07.2022.
//

import AsyncDisplayKit
import Maaku

final class WrapperCellNode<T: ASDisplayNode>: BaseCellNode, Linkable {

    /// The wrapped node node.
    private(set) public var node: T

    /// The link delegate proxy.
    public var linkDelegate: LinkDelegate? {
        get {
            return (node as? Linkable)?.linkDelegate
        }
        set {
            if var linkable = node as? Linkable {
                linkable.linkDelegate = newValue
            }
        }
    }

    /// Initializes a ParagraphNode with the specified tag and style.
    ///
    /// - Parameters:
    ///     - markdownTag: The markdown tag.
    ///     - style: The markdown style.
    ///
    /// - Returns:
    ///     The initialized ParagraphNode.
    init(node: T) {
        self.node = node
        super.init()

        selectionStyle = .none
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: node)
    }
}

