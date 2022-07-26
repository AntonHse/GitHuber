//
//  TableNode.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/21/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import Maaku

/// Represents a markdown table as an ASDisplayNode
final class TableNode: ASDisplayNode, ASTextNodeDelegate, Linkable {

    /// The link delegate.
    weak var linkDelegate: LinkDelegate?

    // MARK: - Private Properties
    /// The table row elements.
    private var tableRows = [ASLayoutElement]()

    /// The insets.
    private let insets: UIEdgeInsets

    /// Indicates if the node is nested.
    private let nested: Bool

    // MARK: - Init
    /// Initializes a TableNode with the specified table and style.
    ///
    /// - Parameters:
    ///     - table: The markdown table.
    ///     - style: The document style.
    ///     - nested: Indicates if the node is nested.
    /// - Returns:
    ///     The initialized TableNode.
    init(table: Table, style: DocumentStyle, nested: Bool = false) {
        insets = style.insets.table
        self.nested = nested
        super.init()

        automaticallyManagesSubnodes = true
        setupTable(table, style: style)
    }
    
    convenience init(model: TableNodeModel) {
        self.init(table: model.table, style: model.style, nested: model.nested)
    }

    /// Configures a table.
    ///
    /// - Parameters:
    ///     - table: The markdown table.
    ///     - style: The document style.
    private func setupTable(_ table: Table, style: DocumentStyle) {
        tableRows.append(TableRowNode(row: table.header, table: table, style: style))

        let separator = ASDisplayNode()
        separator.backgroundColor = style.colors.horizontalRule
        separator.style.flexBasis = ASDimensionMake(style.values.horizontalRuleHeight)
        separator.style.spacingBefore = 5.0
        tableRows.append(separator)

        for row in table.rows {
            tableRows.append(TableRowNode(row: row, table: table, style: style))
        }
    }

    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var tableInsets = insets

        if nested {
            tableInsets = .zero
            tableInsets.left = insets.left
        }

        let stack = ASStackLayoutSpec(direction: .vertical,
                                      spacing: 0.0,
                                      justifyContent: .start,
                                      alignItems: .stretch,
                                      children: tableRows)
        stack.style.flexShrink = 1.0
        stack.style.flexGrow = 1.0

        return ASInsetLayoutSpec(insets: tableInsets, child: stack)
    }

    public func textNode(_ textNode: ASTextNode,
                         tappedLinkAttribute attribute: String,
                         value: Any, at point: CGPoint,
                         textRange: NSRange) {
        if let url = value as? URL {
            linkDelegate?.linkTapped(url)
        }
    }

    public func textNode(_ textNode: ASTextNode,
                         shouldHighlightLinkAttribute attribute: String,
                         value: Any,
                         at point: CGPoint) -> Bool {
        return true
    }
}
