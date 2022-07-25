//
//  FootnoteDefinitionNodeModel.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 21.07.2022.
//

import Maaku

struct FootnoteDefinitionNodeModel: CellModel {
    var type: CellType = .readme(type: .footnoteDefinition)
    
    let footnoteDefinition: FootnoteDefinition
    let style: DocumentStyle
    var nested: Bool = false
}
