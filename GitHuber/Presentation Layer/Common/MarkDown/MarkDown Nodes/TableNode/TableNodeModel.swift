//
//  TableNodeModel.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 21.07.2022.
//

import Maaku

struct TableNodeModel: CellModel {
    var type: CellType = .readme(type: .table)
    
    let table: Table
    let style: DocumentStyle
    var nested: Bool = false
}
