//
//  CodeBlockNodeModel.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 21.07.2022.
//

import Maaku

struct CodeBlockNodeModel: CellModel {
    var type: CellType = .readme(type: .codeBlock)
    
    let codeBlock: CodeBlock
    let style: DocumentStyle
    var nested: Bool = false
}
