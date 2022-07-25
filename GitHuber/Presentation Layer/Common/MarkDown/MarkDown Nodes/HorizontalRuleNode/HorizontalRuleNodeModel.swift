//
//  HorizontalRuleNodeModel.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 21.07.2022.
//

struct HorizontalRuleNodeModel: CellModel {
    var type: CellType = .readme(type: .horizontalRyle)
    
    let style: DocumentStyle
    var nested: Bool = false
}
