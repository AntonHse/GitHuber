//
//  RepositoryPermission.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 19.07.2022.
//

struct RepositoryPermission: Decodable {
    let admin: Bool?
    let pull: Bool?
    let push: Bool?
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        admin = try values.decodeIfPresent(Bool.self, forKey: .admin)
        pull = try values.decodeIfPresent(Bool.self, forKey: .pull)
        push = try values.decodeIfPresent(Bool.self, forKey: .push)
    }
}

// MARK: - Private
private extension RepositoryPermission {
    enum CodingKeys: String, CodingKey {
        case admin
        case pull
        case push
    }
}
