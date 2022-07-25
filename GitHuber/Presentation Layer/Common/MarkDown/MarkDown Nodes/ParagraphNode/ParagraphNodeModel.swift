//
//  ParagraphNodeModel.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 20.07.2022.
//

import Maaku

struct ParagraphNodeModel: CellModel {
    var type: CellType = .readme(type: .paragraph)
    
    let paragraph: Paragraph
    let style: DocumentStyle
    var nested: Bool = false
}
