//
//  RepositoryReadmeResponse.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 19.07.2022.
//

struct RepositoryReadmeResponse: Decodable {

    let links: RepositoryContentsLink?
    let content: String?
    let downloadUrl: String?
    let encoding: String?
    let gitUrl: String?
    let htmlUrl: String?
    let name: String?
    let path: String?
    let sha: String?
    let size: Int?
    let type: String?
    let url: String?
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        links = try values.decodeIfPresent(RepositoryContentsLink.self, forKey: .links)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        downloadUrl = try values.decodeIfPresent(String.self, forKey: .downloadUrl)
        encoding = try values.decodeIfPresent(String.self, forKey: .encoding)
        gitUrl = try values.decodeIfPresent(String.self, forKey: .gitUrl)
        htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        sha = try values.decodeIfPresent(String.self, forKey: .sha)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}

// MARK: - Private
private extension RepositoryReadmeResponse {
    enum CodingKeys: String, CodingKey {
        case links
        case content = "content"
        case downloadUrl = "download_url"
        case encoding = "encoding"
        case gitUrl = "git_url"
        case htmlUrl = "html_url"
        case name = "name"
        case path = "path"
        case sha = "sha"
        case size = "size"
        case type = "type"
        case url = "url"
    }
}
