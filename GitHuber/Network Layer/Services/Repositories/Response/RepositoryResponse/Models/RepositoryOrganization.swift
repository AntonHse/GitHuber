//
//  RepositoryOrganization.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 19.07.2022.
//

struct RepositoryOrganization: Decodable {
    let avatarUrl: String?
    let eventsUrl: String?
    let followersUrl: String?
    let followingUrl: String?
    let gistsUrl: String?
    let gravatarId: String?
    let htmlUrl: String?
    let id: Int?
    let login: String?
    let organizationsUrl: String?
    let receivedEventsUrl: String?
    let reposUrl: String?
    let siteAdmin: Bool?
    let starredUrl: String?
    let subscriptionsUrl: String?
    let type: String?
    let url: String?
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
        eventsUrl = try values.decodeIfPresent(String.self, forKey: .eventsUrl)
        followersUrl = try values.decodeIfPresent(String.self, forKey: .followersUrl)
        followingUrl = try values.decodeIfPresent(String.self, forKey: .followingUrl)
        gistsUrl = try values.decodeIfPresent(String.self, forKey: .gistsUrl)
        gravatarId = try values.decodeIfPresent(String.self, forKey: .gravatarId)
        htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        login = try values.decodeIfPresent(String.self, forKey: .login)
        organizationsUrl = try values.decodeIfPresent(String.self, forKey: .organizationsUrl)
        receivedEventsUrl = try values.decodeIfPresent(String.self, forKey: .receivedEventsUrl)
        reposUrl = try values.decodeIfPresent(String.self, forKey: .reposUrl)
        siteAdmin = try values.decodeIfPresent(Bool.self, forKey: .siteAdmin)
        starredUrl = try values.decodeIfPresent(String.self, forKey: .starredUrl)
        subscriptionsUrl = try values.decodeIfPresent(String.self, forKey: .subscriptionsUrl)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}

// MARK: - Encodable
extension RepositoryOrganization: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(avatarUrl, forKey: .avatarUrl)
        try container.encode(login, forKey: .login)
    }
}

// MARK: - Private
private extension RepositoryOrganization {
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case eventsUrl = "events_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case gravatarId = "gravatar_id"
        case htmlUrl = "html_url"
        case id
        case login
        case organizationsUrl = "organizations_url"
        case receivedEventsUrl = "received_events_url"
        case reposUrl = "repos_url"
        case siteAdmin = "site_admin"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case type
        case url
    }
}
