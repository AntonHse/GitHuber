//
//  RepositoryLicense.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 19.07.2022.
//

struct RepositoryLicense: Decodable {
    let htmlUrl: String?
    let key: String?
    let name: String?
    let spdxId: String?
    let url: String?
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        spdxId = try values.decodeIfPresent(String.self, forKey: .spdxId)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}

// MARK: - Private
private extension RepositoryLicense {
    enum CodingKeys: String, CodingKey {
        case htmlUrl = "html_url"
        case key
        case name
        case spdxId = "spdx_id"
        case url
    }
}
