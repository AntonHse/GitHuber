//
//  TableNodeSectionData.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 20.07.2022.
//

enum HeaderFooterType {
    case `default`
}

/// All app cells
enum CellType {
    case repoInfo
    case readme(type: ReadmeType)
}

enum ReadmeType {
    case codeBlock
    case footnoteDefinition
    case list
    case listItem
    case horizontalRyle
    case table
    case tableRow
    case tableCell
    case blockQuote
    case heading
    case paragraph
}

protocol HeaderFooterModel {
    var type: HeaderFooterType { get }
}

protocol CellModel {
    var type: CellType { get }
}

protocol TableNodeSectionDataProtocol {
    var header: HeaderFooterModel? { get }
    var cells: [CellModel] { get }
    var footer: HeaderFooterModel? { get }

    init(header: HeaderFooterModel?, cells: [CellModel], footer: HeaderFooterModel?)
}

struct TableNodeSectionData: TableNodeSectionDataProtocol {
    var header: HeaderFooterModel?
    var cells: [CellModel]
    var footer: HeaderFooterModel?
    
    // MARK: - Init
    init(header: HeaderFooterModel? = nil, cells: [CellModel], footer: HeaderFooterModel? = nil) {
        self.header = header
        self.cells = cells
        self.footer = footer
    }
}
