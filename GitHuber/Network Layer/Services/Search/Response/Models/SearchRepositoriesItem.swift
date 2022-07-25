//
//  SearchRepositoriesItem.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

struct SearchRepositoriesItem: Decodable {
    
    let createdAt: String?
    let defaultBranch: String?
    let descriptionField: String?
    let fork: Bool?
    let forksCount: Int?
    let fullName: String?
    let homepage: String?
    let htmlUrl: String?
    let id: Int?
    let language: String?
    let masterBranch: String?
    let name: String?
    let openIssuesCount: Int?
    let owner: SearchRepositoriesOwner?
    let privateField: Bool?
    let pushedAt: String?
    let score: Float?
    let size: Int?
    let stargazersCount: Int?
    let updatedAt: String?
    let url: String?
    let watchersCount: Int?
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        defaultBranch = try values.decodeIfPresent(String.self, forKey: .defaultBranch)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        fork = try values.decodeIfPresent(Bool.self, forKey: .fork)
        forksCount = try values.decodeIfPresent(Int.self, forKey: .forksCount)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        homepage = try values.decodeIfPresent(String.self, forKey: .homepage)
        htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        masterBranch = try values.decodeIfPresent(String.self, forKey: .masterBranch)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        openIssuesCount = try values.decodeIfPresent(Int.self, forKey: .openIssuesCount)
        owner = try values.decodeIfPresent(SearchRepositoriesOwner.self, forKey: .owner)
        privateField = try values.decodeIfPresent(Bool.self, forKey: .privateField)
        pushedAt = try values.decodeIfPresent(String.self, forKey: .pushedAt)
        score = try values.decodeIfPresent(Float.self, forKey: .score)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        stargazersCount = try values.decodeIfPresent(Int.self, forKey: .stargazersCount)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        watchersCount = try values.decodeIfPresent(Int.self, forKey: .watchersCount)
    }
}

// MARK: - Encodable
extension SearchRepositoriesItem: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(descriptionField, forKey: .descriptionField)
        try container.encode(watchersCount, forKey: .watchersCount)
        try container.encode(language, forKey: .language)
        try container.encode(id, forKey: .id)
        try container.encode(owner, forKey: .owner)
        // Expand if needed
    }
}

// MARK: - Coding Keys
private extension SearchRepositoriesItem {
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case defaultBranch = "default_branch"
        case descriptionField = "description"
        case fork
        case forksCount = "forks_count"
        case fullName = "full_name"
        case homepage
        case htmlUrl = "html_url"
        case id
        case language
        case masterBranch = "master_branch"
        case name
        case openIssuesCount = "open_issues_count"
        case owner
        case privateField = "private"
        case pushedAt = "pushed_at"
        case score
        case size
        case stargazersCount = "stargazers_count"
        case updatedAt = "updated_at"
        case url
        case watchersCount = "watchers_count"
    }
}
