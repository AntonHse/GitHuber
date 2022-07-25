//
//  BlockQuoteNodeModel.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 21.07.2022.
//

import Maaku

struct BlockQuoteNodeModel: CellModel {
    var type: CellType = .readme(type: .blockQuote)
    
    let blockQuote: BlockQuote
    let style: DocumentStyle
    var nested: Bool = false
}
