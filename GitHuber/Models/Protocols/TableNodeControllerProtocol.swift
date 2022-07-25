//
//  TableNodeDataSettable.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 18.07.2022.
//

protocol TableNodeControllerProtocol: AnyObject {
    func set(tableData: [TableNodeSectionData])
}
