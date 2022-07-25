//
//  HorizontalRuleNode.swift
//  TexturedMaaku
//
//  Created by Kristopher Baker on 12/20/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit

/// Represents a markdown horizontal rule as an ASDisplayNode.
final class HorizontalRuleNode: BaseNode {

    /// The layout spec.
    private var spec: ASLayoutSpec

    /// The insets.
    private let insets: UIEdgeInsets

    /// Indicates if the node is nested.
    private let nested: Bool

    // MARK: - Init
    /// Initializes a HorizontalRuleNode with the specified style.
    ///
    /// - Parameters:
    ///     - style: The document style.
    ///     - nested: Indicates if the node is nested.
    ///  - Returns:
    ///     The initialized HorizontalRuleNode.
    init(style: DocumentStyle, nested: Bool = false) {
        insets = style.insets.horizontalRule
        self.nested = nested

        let separator = ASDisplayNode()
        separator.backgroundColor = style.colors.horizontalRule
        separator.style.flexBasis = ASDimensionMake(style.values.horizontalRuleHeight)

        spec = ASStackLayoutSpec(direction: .vertical,
                                 spacing: 0.0,
                                 justifyContent: .start,
                                 alignItems: .stretch,
                                 children: [separator])

        super.init()
        automaticallyManagesSubnodes = true
    }

    convenience init(model: HorizontalRuleNodeModel) {
        self.init(style: model.style, nested: model.nested)
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var hrInsets = insets

        if nested {
            hrInsets = .zero
            hrInsets.left = insets.left
        }

        let insetSpec = ASInsetLayoutSpec(insets: hrInsets, child: spec)
        return insetSpec
    }
}
