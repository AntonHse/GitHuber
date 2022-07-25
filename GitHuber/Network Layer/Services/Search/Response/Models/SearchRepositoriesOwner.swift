//
//  SearchRepositoriesOwner.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

struct SearchRepositoriesOwner: Decodable {
    
    let avatarUrl: String?
    let gravatarId: String?
    let id: Int?
    let login: String?
    let receivedEventsUrl: String?
    let type: String?
    let url: String?
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
        gravatarId = try values.decodeIfPresent(String.self, forKey: .gravatarId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        login = try values.decodeIfPresent(String.self, forKey: .login)
        receivedEventsUrl = try values.decodeIfPresent(String.self, forKey: .receivedEventsUrl)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}

// MARK: - Encodable
extension SearchRepositoriesOwner: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(avatarUrl, forKey: .avatarUrl)
        try container.encode(login, forKey: .login)
        // Expand if needed
    }
}

// MARK: - Coding Keys
private extension SearchRepositoriesOwner {
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case id
        case login
        case receivedEventsUrl = "received_events_url"
        case type
        case url
    }
}
