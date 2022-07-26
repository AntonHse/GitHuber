//
//  ParagraphNode.swift
//  TexturedMaaku
//
//  Created by Kristopher Baker on 12/20/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import Maaku

/// Represents a CommonMark paragraph as an ASDisplayNode.
final class ParagraphNode: BaseNode, Linkable {
        
    /// The link delegate.
    weak var linkDelegate: LinkDelegate?

    // MARK: - Private Properties
    /// The text node.
    private let textNode = ASTextNode()

    /// The image node.
    private var imageNode: ASNetworkImageNode?

    /// The image size.
    private var imageSize: CGSize = .zero {
        didSet {
            if oldValue != imageSize {
                setNeedsLayout()
                imageNode?.setNeedsLayout()
            }
        }
    }

    /// The insets.
    private let insets: UIEdgeInsets

    /// Indicates if the node is nested.
    private let nested: Bool

    // MARK: - Init
    /// Initializes a ParagraphNode with the specified paragraph and style.
    ///
    /// - Parameters:
    ///     - paragraph: The CommonMark paragraph.
    ///     - style: The document style.
    ///     - nested: Indicates if the node is nested.
    /// - Returns:
    ///     The initialized ParagraphNode.
    init(paragraph: Paragraph, style: DocumentStyle, nested: Bool = false) {
        insets = style.insets.paragraph
        self.nested = nested
        super.init()

        setupParagraph(paragraph, style: style)
    }
    
    convenience init(model: ParagraphNodeModel) {
        self.init(paragraph: model.paragraph, style: model.style, nested: model.nested)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var paragraphInsets = insets

        if nested {
            paragraphInsets = .zero
            paragraphInsets.left = insets.left
        }

        if let imageNode = self.imageNode {
            let maxWidth = constrainedSize.max.width - insets.left - insets.right
            var width = maxWidth
            var height: CGFloat = 0

            if imageSize.width > 0 {
                if imageSize.width < maxWidth {
                    width = imageSize.width
                }
                height = (imageSize.height / imageSize.width) * width
            } else {
                width = 50
                height = 50
            }

            imageNode.style.preferredSize = CGSize(width: width, height: height)

            if width < maxWidth {
                let spacer = ASLayoutSpec()
                spacer.style.flexGrow = 1.0
                let stack = ASStackLayoutSpec(direction: .horizontal,
                                              spacing: 0.0,
                                              justifyContent: .start,
                                              alignItems: .stretch,
                                              children: [imageNode, spacer])
                return ASInsetLayoutSpec(insets: paragraphInsets, child: stack)
            } else {
                return ASInsetLayoutSpec(insets: paragraphInsets, child: imageNode)
            }
        }

        return ASInsetLayoutSpec(insets: paragraphInsets, child: textNode)
    }
}

// MARK: - ASTextNodeDelegate
extension ParagraphNode: ASTextNodeDelegate {
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

// MARK: - ASNetworkImageNodeDelegate
extension ParagraphNode: ASNetworkImageNodeDelegate {
    func imageNode(_ imageNode: ASNetworkImageNode, didLoad image: UIImage) {
        imageSize = image.size
    }
}

// MARK: - Private Methods
private extension ParagraphNode {
    /// Configures a paragraph.
    ///
    /// - Parameters:
    ///     - paragraph: The CommonMark paragraph.
    ///     - style: The document style.
    func setupParagraph(_ paragraph: Paragraph, style: DocumentStyle) {
        /// limited support for images - paragraphs with a single image as the only element
        if paragraph.items.count == 1, let inlineImage = paragraph.items[0] as? Image,
            let url = inlineImage.url {
            let node = ASNetworkImageNode()
            node.contentMode = .scaleAspectFit
            node.delegate = self
            node.url = url
            imageNode = node
        } else {
            textNode.style.flexShrink = 1.0
            textNode.style.flexGrow = 1.0
            textNode.isUserInteractionEnabled = true
            textNode.delegate = self
            textNode.attributedText = paragraph.attributedText(style: style.maakuStyle)
        }
    }
}
