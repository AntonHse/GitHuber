//
//  RepositoryContentsLink.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 19.07.2022.
//

struct RepositoryContentsLink: Decodable {

    let git: String?
    let html: String?
    let selfValue: String?
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        git = try values.decodeIfPresent(String.self, forKey: CodingKeys.git)
        html = try values.decodeIfPresent(String.self, forKey: CodingKeys.html)
        selfValue = try values.decodeIfPresent(String.self, forKey: CodingKeys.selfValue)
    }
}

// MARK: - Private
private extension RepositoryContentsLink {
    enum CodingKeys: String, CodingKey {
        case git = "git"
        case html = "html"
        case selfValue = "self"
    }
}
