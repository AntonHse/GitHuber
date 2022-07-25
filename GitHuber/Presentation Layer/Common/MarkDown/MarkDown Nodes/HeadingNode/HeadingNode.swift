//
//  HeadingNode.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/20/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import Maaku

/// Represents a markdown heading as an ASDisplayNode
final class HeadingNode: BaseNode, Linkable {
    
    /// The link delegate.
    weak var linkDelegate: LinkDelegate?
    
    // MARK: - Private Properties
    /// The text node.
    private let textNode = ASTextNode()

    /// The circle header node.
    private var circleHeaderNode: CircleHeaderNode?

    /// The insets.
    private let insets: UIEdgeInsets

    /// Indicates if the node is nested.
    private let nested: Bool

    // MARK: - Init
    /// Initializes a HeadingNode with the specified heading and style.
    ///
    /// - Parameters:
    ///     - heading: The markdown heading.
    ///     - style: The document style.
    ///     - nested: Indicates if the node is nested.
    /// - Returns:
    ///     The initialized HeadingNode.
    init(heading: Heading, style: DocumentStyle, nested: Bool = false) {
        insets = style.insets.heading
        self.nested = nested
        super.init()

        automaticallyManagesSubnodes = true
        setupHeading(heading, style: style)
    }
    
    convenience init(model: HeadingNodeModel) {
        self.init(heading: model.heading, style: model.style, nested: model.nested)
    }

    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var headingInsets = insets

        if nested {
            headingInsets = .zero
            headingInsets.left = insets.left
        }

        if let circleHeader = circleHeaderNode {
            let stackLayout = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: 14.0,
                                                justifyContent: .start,
                                                alignItems: .center,
                                                children: [circleHeader, textNode])
            return ASInsetLayoutSpec(insets: headingInsets, child: stackLayout)
        } else {
            return ASInsetLayoutSpec(insets: headingInsets, child: textNode)
        }
    }
}

// MARK: - ASTextNodeDelegate
extension HeadingNode: ASTextNodeDelegate {
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

// MARK: - Private Methods
private extension HeadingNode {
    /// Configures a heading.
    ///
    /// - Parameters:
    ///     - heading: The markdown heading.
    ///     - style: The document style.
    func setupHeading(_ heading: Heading, style: DocumentStyle) {
        var items = heading.items

        // check for circle headers and update items as needed
        if style.values.circleHeadersEnabled, items.count > 0, let markdownText = items[0] as? Text,
            let numHeader = markdownText.text.characterHeaderMatch() {
            var numberHeaderText = numHeader

            if let index = numHeader.firstIndex(of: ".") {
                numberHeaderText = String(numHeader.prefix(upTo: index))
            }

            if markdownText.text.count > numHeader.count {
                let index = markdownText.text.index(markdownText.text.startIndex, offsetBy: numHeader.count)
                let updatedText = String(markdownText.text[index...])
                items[0] = Text(text: updatedText)
            } else {
                items.remove(at: 0)
            }

            circleHeaderNode = CircleHeaderNode(text: numberHeaderText, style: style)
        }

        textNode.style.flexShrink = 1.0
        textNode.isUserInteractionEnabled = true
        textNode.delegate = self
        textNode.attributedText = heading.with(items: items).attributedText(style: style.maakuStyle)
    }
}
