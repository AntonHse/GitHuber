//
//  TableRowNode.swift
//  TexturedMaaku
//
//  Created by Kris Baker on 12/22/17.
//  Copyright © 2017 Kristopher Baker. All rights reserved.
//

import AsyncDisplayKit
import Maaku

/// Represents a markdown table row/header as an ASDisplayNode
final class TableRowNode: ASDisplayNode, Linkable {

    /// The link delegate.
    weak var linkDelegate: LinkDelegate?
    
    /// The table cell elements.
    private var tableCells = [ASLayoutElement]()

    // MARK: - Init
    /// Initializes a TableNode.
    ///
    /// - Parameters:
    ///     - row: The markdown table header/row.
    ///     - table: The markdown table.
    ///     - style: The document style.
    ///
    /// - Returns:
    ///     The initialized TableNode.
    public init(row: TableLine, table: Table, style: DocumentStyle) {
        super.init()

        automaticallyManagesSubnodes = true
        setupTable(row, table: table, style: style)
    }
    
    convenience init(model: TableRowNodeModel) {
        self.init(row: model.row, table: model.table, style: model.style)
    }

    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .horizontal,
                                      spacing: 0.0,
                                      justifyContent: .start,
                                      alignItems: .start,
                                      children: tableCells)

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0), child: stack)
    }
}

// MARK: - ASTextNodeDelegate
extension TableRowNode: ASTextNodeDelegate {
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

// MARK: - Private Methods
private extension TableRowNode {
    /// Configures a table row.
    ///
    /// - Parameters:
    ///     - row: The markdown table header/row.
    ///     - table: The markdown table.
    ///     - style: The document style.
    func setupTable(_ row: TableLine, table: Table, style: DocumentStyle) {
        for (column, cell) in row.cells.enumerated() {
            let alignment = table.alignments[safe: column] ?? .none
            let cellNode = TableCellNode(cell: cell, row: row, alignment: alignment, style: style)
            cellNode.style.width = ASDimensionMakeWithFraction(1.0 / CGFloat(row.cells.count))
            tableCells.append(cellNode)
        }
    }
}
