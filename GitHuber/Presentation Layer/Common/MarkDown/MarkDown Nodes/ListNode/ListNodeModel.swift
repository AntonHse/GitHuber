//
//  ListNodeModel.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 21.07.2022.
//

import Maaku

struct ListNodeModel: CellModel {
    var type: CellType = .readme(type: .list)
    
    let list: List
    let style: DocumentStyle
    var nested: Bool = false
}
