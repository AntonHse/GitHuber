//
//  HeadingNodeModel.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 20.07.2022.
//

import Maaku

struct HeadingNodeModel: CellModel {
    var type: CellType = .readme(type: .heading)
    
    let heading: Heading
    let style: DocumentStyle
    var nested: Bool = false
}
