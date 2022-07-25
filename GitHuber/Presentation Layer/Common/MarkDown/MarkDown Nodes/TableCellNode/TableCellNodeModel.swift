//
//  TableCellNodeModel.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 21.07.2022.
//

import Maaku

struct TableCellNodeModel: CellModel {
    var type: CellType = .readme(type: .tableCell)
    
    let cell: TableCell
    let row: TableLine
    let alignment: TableAlignment
    let style: DocumentStyle
}
