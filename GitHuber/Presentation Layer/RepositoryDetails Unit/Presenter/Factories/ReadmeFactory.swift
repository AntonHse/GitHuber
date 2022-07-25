//
//  ReadmeFactory.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 20.07.2022.
//

import Maaku

protocol ReadmeFactoryProtocol {
    func makeReadmeCells(readmeBlocks: [Block]) -> [CellModel]
}

final class ReadmeFactory {}

// MARK: - ReadmeFactoryProtocol
extension ReadmeFactory: ReadmeFactoryProtocol {
    func makeReadmeCells(readmeBlocks: [Block]) -> [CellModel] {
        return readmeBlocks.compactMap { makeCellModel(block: $0) }
    }
}

// MARK: - Private Extension
private extension ReadmeFactory {
    /// Gets CellModel for the block.
    ///
    /// - Parameters:
    ///     - style: The document style to use for the block.
    ///     - nested: Indicates if the node will be nested.
    /// - Returns:
    ///     The ASDisplayNode for the block if it can be created, nil otherwise.
    func makeCellModel(block: Block, style: DocumentStyle = DefaultDocumentStyle(), nested: Bool = false) -> CellModel? {
        var model: CellModel?

        if let paragraph = block as? Paragraph {
            model = ParagraphNodeModel(paragraph: paragraph, style: style, nested: nested)
        } else if let heading = block as? Heading {
            model = HeadingNodeModel(heading: heading, style: style, nested: nested)
        } else if let list = block as? List {
            model = ListNodeModel(list: list, style: style, nested: nested)
        } else if let blockQuote = block as? BlockQuote {
            model = BlockQuoteNodeModel(blockQuote: blockQuote, style: style, nested: nested)
        } else if let table = block as? Table {
            model = TableNodeModel(table: table, style: style, nested: nested)
        } else if let codeBlock = block as? CodeBlock {
            model = CodeBlockNodeModel(codeBlock: codeBlock, style: style, nested: nested)
        } else if block is HorizontalRule {
            model = HorizontalRuleNodeModel(style: style, nested: nested)
        } else if let footnoteDefinition = block as? FootnoteDefinition {
            model = FootnoteDefinitionNodeModel(footnoteDefinition: footnoteDefinition, style: style)
        } else if let listItem = block as? ListItem {
            model = ListItemNodeModel(listItem: listItem, style: style, nested: nested)
        }
        // TODO: Add Plugins
//        else if let plugin = block as? Plugin {
//            model = NodePluginManager.displayNode(for: plugin, style: style, nested: nested)
//        }

        return model
    }
}
