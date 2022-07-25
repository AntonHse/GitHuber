//
//  RepositoryInfoCellNodeModel.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 19.07.2022.
//

struct RepositoryInfoCellNodeModel: CellModel {
    var type: CellType
    
    var id: Int?
    var profileInfo: ProfileInfoNodeModel
    var name: String
    var description: String?
    var repoLink: String?
    var rating: Int?
    var forks: Int?
}
