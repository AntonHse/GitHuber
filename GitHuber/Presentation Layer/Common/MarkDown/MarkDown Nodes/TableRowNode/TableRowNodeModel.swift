//
//  TableRowNodeModel.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 21.07.2022.
//

import Maaku

struct TableRowNodeModel: CellModel {
    var type: CellType = .readme(type: .tableRow)
    
    let row: TableLine
    let table: Table
    let style: DocumentStyle
}
