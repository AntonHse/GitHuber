//
//  ListItemNodeModel.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 21.07.2022.
//

import Maaku

struct ListItemNodeModel: CellModel {
    var type: CellType = .readme(type: .listItem)
    
    let listItem: ListItem
    let style: DocumentStyle
    var nested: Bool
}
