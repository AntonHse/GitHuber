//
//  ListItemNode.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/24/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import Maaku

/// Represents a markdown list item as an ASDisplayNode.
final class ListItemNode: ASDisplayNode, Linkable {

    /// The layout children.
    private var children = [ASLayoutElement]()

    /// The link delegate.
    weak var linkDelegate: LinkDelegate?

    /// Indicates if the node is nested.
    private let nested: Bool

    // MARK: - Init
    /// Initializes a ListNode with the specified items, ordering, and style.
    ///
    /// - Parameters:
    ///     - listItem: The list item.
    ///     - style: The document style.
    ///     - nested: Indicates if the node is nested.
    /// - Returns:
    ///     The initialized ListNode.
    init(listItem: ListItem, style: DocumentStyle, nested: Bool) {
        self.nested = nested
        super.init()

        automaticallyManagesSubnodes = true
        setupListItem(listItem, style: style)
    }
    
    convenience init(model: ListItemNodeModel) {
        self.init(listItem: model.listItem, style: model.style, nested: model.nested)
    }

    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let spec = ASStackLayoutSpec(direction: .vertical,
                                     spacing: 5.0,
                                     justifyContent: .start,
                                     alignItems: .stretch,
                                     children: children)
        spec.style.flexShrink = 1.0
        spec.style.flexGrow = 1.0
        return spec
    }
}

// MARK: - ASTextNodeDelegate
extension ListItemNode: ASTextNodeDelegate {
    func textNode(_ textNode: ASTextNode,
                         tappedLinkAttribute attribute: String,
                         value: Any, at point: CGPoint,
                         textRange: NSRange) {
        if let url = value as? URL {
            linkDelegate?.linkTapped(url)
        }
    }

    func textNode(_ textNode: ASTextNode,
                         shouldHighlightLinkAttribute attribute: String,
                         value: Any,
                         at point: CGPoint) -> Bool {
        return true
    }
}

// MARK: - LinkDelegate
extension ListItemNode: LinkDelegate {
    func linkTapped(_ url: URL) {
        linkDelegate?.linkTapped(url)
    }
}

// MARK: - Private Methods
private extension ListItemNode {
    /// Configures the specified list item.
    ///
    /// - Parameters:
    ///     - listItem: The list.
    ///     - style: The document style.
    func setupListItem(_ listItem: ListItem, style: DocumentStyle) {
        for item in listItem.items {
            var itemStyle = style

            if item is Paragraph {
                itemStyle.insets.paragraph = .zero
            } else if item is BlockQuote {
                itemStyle.insets.blockQuote = .zero
            } else if item is Heading {
                itemStyle.insets.heading = .zero
            }

            if let displayNode = item.displayNode(style: itemStyle, nested: true) {
                if var linkable = displayNode as? Linkable {
                    linkable.linkDelegate = self
                }

                displayNode.style.flexShrink = 1.0
                displayNode.style.flexGrow = 1.0

                children.append(displayNode)
            } else {
                let listValueTextNode = ASTextNode()
                listValueTextNode.isUserInteractionEnabled = true
                listValueTextNode.delegate = self
                listValueTextNode.style.flexShrink = 1.0
                listValueTextNode.style.flexGrow = 1.0
                listValueTextNode.attributedText =  item.attributedText(style: style.maakuStyle)

                children.append(listValueTextNode)
            }
        }
    }
}

