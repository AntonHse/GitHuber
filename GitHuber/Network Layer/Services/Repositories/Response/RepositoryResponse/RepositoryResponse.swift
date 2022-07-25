//
//  RepositoryResponse.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 19.07.2022.
//

struct RepositoryResponse: Decodable {
    let allowMergeCommit: Bool?
    let allowRebaseMerge: Bool?
    let allowSquashMerge: Bool?
    let archiveUrl: String?
    let archived: Bool?
    let assigneesUrl: String?
    let blobsUrl: String?
    let branchesUrl: String?
    let cloneUrl: String?
    let collaboratorsUrl: String?
    let commentsUrl: String?
    let commitsUrl: String?
    let compareUrl: String?
    let contentsUrl: String?
    let contributorsUrl: String?
    let createdAt: String?
    let defaultBranch: String?
    let deploymentsUrl: String?
    let descriptionField: String?
    let downloadsUrl: String?
    let eventsUrl: String?
    let fork: Bool?
    let forksCount: Int?
    let forksUrl: String?
    let fullName: String?
    let gitCommitsUrl: String?
    let gitRefsUrl: String?
    let gitTagsUrl: String?
    let gitUrl: String?
    let hasDownloads: Bool?
    let hasIssues: Bool?
    let hasPages: Bool?
    let hasWiki: Bool?
    let homepage: String?
    let hooksUrl: String?
    let htmlUrl: String?
    let id: Int?
    let issueCommentUrl: String?
    let issueEventsUrl: String?
    let issuesUrl: String?
    let keysUrl: String?
    let labelsUrl: String?
    let language: String?
    let languagesUrl: String?
    let license: RepositoryLicense?
    let mergesUrl: String?
    let milestonesUrl: String?
    let mirrorUrl: String?
    let name: String?
    let networkCount: Int?
    let notificationsUrl: String?
    let openIssuesCount: Int?
    let organization: RepositoryOrganization?
    let owner: RepositoryOrganization?
    let parent: RepositoryParent?
    let permissions: RepositoryPermission?
    let privateField: Bool?
    let pullsUrl: String?
    let pushedAt: String?
    let releasesUrl: String?
    let size: Int?
    let source: RepositoryParent?
    let sshUrl: String?
    let stargazersCount: Int?
    let stargazersUrl: String?
    let statusesUrl: String?
    let subscribersCount: Int?
    let subscribersUrl: String?
    let subscriptionUrl: String?
    let svnUrl: String?
    let tagsUrl: String?
    let teamsUrl: String?
    let topics: [String]?
    let treesUrl: String?
    let updatedAt: String?
    let url: String?
    let watchersCount: Int?
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        allowMergeCommit = try values.decodeIfPresent(Bool.self, forKey: .allowMergeCommit)
        allowRebaseMerge = try values.decodeIfPresent(Bool.self, forKey: .allowRebaseMerge)
        allowSquashMerge = try values.decodeIfPresent(Bool.self, forKey: .allowSquashMerge)
        archiveUrl = try values.decodeIfPresent(String.self, forKey: .archiveUrl)
        archived = try values.decodeIfPresent(Bool.self, forKey: .archived)
        assigneesUrl = try values.decodeIfPresent(String.self, forKey: .assigneesUrl)
        blobsUrl = try values.decodeIfPresent(String.self, forKey: .blobsUrl)
        branchesUrl = try values.decodeIfPresent(String.self, forKey: .branchesUrl)
        cloneUrl = try values.decodeIfPresent(String.self, forKey: .cloneUrl)
        collaboratorsUrl = try values.decodeIfPresent(String.self, forKey: .collaboratorsUrl)
        commentsUrl = try values.decodeIfPresent(String.self, forKey: .commentsUrl)
        commitsUrl = try values.decodeIfPresent(String.self, forKey: .commitsUrl)
        compareUrl = try values.decodeIfPresent(String.self, forKey: .compareUrl)
        contentsUrl = try values.decodeIfPresent(String.self, forKey: .contentsUrl)
        contributorsUrl = try values.decodeIfPresent(String.self, forKey: .contributorsUrl)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        defaultBranch = try values.decodeIfPresent(String.self, forKey: .defaultBranch)
        deploymentsUrl = try values.decodeIfPresent(String.self, forKey: .deploymentsUrl)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        downloadsUrl = try values.decodeIfPresent(String.self, forKey: .downloadsUrl)
        eventsUrl = try values.decodeIfPresent(String.self, forKey: .eventsUrl)
        fork = try values.decodeIfPresent(Bool.self, forKey: .fork)
        forksCount = try values.decodeIfPresent(Int.self, forKey: .forksCount)
        forksUrl = try values.decodeIfPresent(String.self, forKey: .forksUrl)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        gitCommitsUrl = try values.decodeIfPresent(String.self, forKey: .gitCommitsUrl)
        gitRefsUrl = try values.decodeIfPresent(String.self, forKey: .gitRefsUrl)
        gitTagsUrl = try values.decodeIfPresent(String.self, forKey: .gitTagsUrl)
        gitUrl = try values.decodeIfPresent(String.self, forKey: .gitUrl)
        hasDownloads = try values.decodeIfPresent(Bool.self, forKey: .hasDownloads)
        hasIssues = try values.decodeIfPresent(Bool.self, forKey: .hasIssues)
        hasPages = try values.decodeIfPresent(Bool.self, forKey: .hasPages)
        hasWiki = try values.decodeIfPresent(Bool.self, forKey: .hasWiki)
        homepage = try values.decodeIfPresent(String.self, forKey: .homepage)
        hooksUrl = try values.decodeIfPresent(String.self, forKey: .hooksUrl)
        htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        issueCommentUrl = try values.decodeIfPresent(String.self, forKey: .issueCommentUrl)
        issueEventsUrl = try values.decodeIfPresent(String.self, forKey: .issueEventsUrl)
        issuesUrl = try values.decodeIfPresent(String.self, forKey: .issuesUrl)
        keysUrl = try values.decodeIfPresent(String.self, forKey: .keysUrl)
        labelsUrl = try values.decodeIfPresent(String.self, forKey: .labelsUrl)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        languagesUrl = try values.decodeIfPresent(String.self, forKey: .languagesUrl)
        license = try values.decodeIfPresent(RepositoryLicense.self, forKey: .license)
        mergesUrl = try values.decodeIfPresent(String.self, forKey: .mergesUrl)
        milestonesUrl = try values.decodeIfPresent(String.self, forKey: .milestonesUrl)
        mirrorUrl = try values.decodeIfPresent(String.self, forKey: .mirrorUrl)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        networkCount = try values.decodeIfPresent(Int.self, forKey: .networkCount)
        notificationsUrl = try values.decodeIfPresent(String.self, forKey: .notificationsUrl)
        openIssuesCount = try values.decodeIfPresent(Int.self, forKey: .openIssuesCount)
        organization = try values.decodeIfPresent(RepositoryOrganization.self, forKey: .organization)
        owner = try values.decodeIfPresent(RepositoryOrganization.self, forKey: .owner)
        parent = try values.decodeIfPresent(RepositoryParent.self, forKey: .parent)
        permissions = try values.decodeIfPresent(RepositoryPermission.self, forKey: .permissions)
        privateField = try values.decodeIfPresent(Bool.self, forKey: .privateField)
        pullsUrl = try values.decodeIfPresent(String.self, forKey: .pullsUrl)
        pushedAt = try values.decodeIfPresent(String.self, forKey: .pushedAt)
        releasesUrl = try values.decodeIfPresent(String.self, forKey: .releasesUrl)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        source = try values.decodeIfPresent(RepositoryParent.self, forKey: .source)
        sshUrl = try values.decodeIfPresent(String.self, forKey: .sshUrl)
        stargazersCount = try values.decodeIfPresent(Int.self, forKey: .stargazersCount)
        stargazersUrl = try values.decodeIfPresent(String.self, forKey: .stargazersUrl)
        statusesUrl = try values.decodeIfPresent(String.self, forKey: .statusesUrl)
        subscribersCount = try values.decodeIfPresent(Int.self, forKey: .subscribersCount)
        subscribersUrl = try values.decodeIfPresent(String.self, forKey: .subscribersUrl)
        subscriptionUrl = try values.decodeIfPresent(String.self, forKey: .subscriptionUrl)
        svnUrl = try values.decodeIfPresent(String.self, forKey: .svnUrl)
        tagsUrl = try values.decodeIfPresent(String.self, forKey: .tagsUrl)
        teamsUrl = try values.decodeIfPresent(String.self, forKey: .teamsUrl)
        topics = try values.decodeIfPresent([String].self, forKey: .topics)
        treesUrl = try values.decodeIfPresent(String.self, forKey: .treesUrl)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        watchersCount = try values.decodeIfPresent(Int.self, forKey: .watchersCount)
    }
}

// MARK: - Encodable
extension RepositoryResponse: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(descriptionField, forKey: .descriptionField)
        try container.encode(watchersCount, forKey: .watchersCount)
        try container.encode(language, forKey: .language)
        try container.encode(id, forKey: .id)
        try container.encode(owner, forKey: .owner)
    }
}

// MARK: - Private
private extension RepositoryResponse {
    enum CodingKeys: String, CodingKey {
        case allowMergeCommit = "allow_merge_commit"
        case allowRebaseMerge = "allow_rebase_merge"
        case allowSquashMerge = "allow_squash_merge"
        case archiveUrl = "archive_url"
        case archived
        case assigneesUrl = "assignees_url"
        case blobsUrl = "blobs_url"
        case branchesUrl = "branches_url"
        case cloneUrl = "clone_url"
        case collaboratorsUrl = "collaborators_url"
        case commentsUrl = "comments_url"
        case commitsUrl = "commits_url"
        case compareUrl = "compare_url"
        case contentsUrl = "contents_url"
        case contributorsUrl = "contributors_url"
        case createdAt = "created_at"
        case defaultBranch = "default_branch"
        case deploymentsUrl = "deployments_url"
        case descriptionField = "description"
        case downloadsUrl = "downloads_url"
        case eventsUrl = "events_url"
        case fork
        case forksCount = "forks_count"
        case forksUrl = "forks_url"
        case fullName = "full_name"
        case gitCommitsUrl = "git_commits_url"
        case gitRefsUrl = "git_refs_url"
        case gitTagsUrl = "git_tags_url"
        case gitUrl = "git_url"
        case hasDownloads = "has_downloads"
        case hasIssues = "has_issues"
        case hasPages = "has_pages"
        case hasWiki = "has_wiki"
        case homepage
        case hooksUrl = "hooks_url"
        case htmlUrl = "html_url"
        case id
        case issueCommentUrl = "issue_comment_url"
        case issueEventsUrl = "issue_events_url"
        case issuesUrl = "issues_url"
        case keysUrl = "keys_url"
        case labelsUrl = "labels_url"
        case language
        case languagesUrl = "languages_url"
        case license
        case mergesUrl = "merges_url"
        case milestonesUrl = "milestones_url"
        case mirrorUrl = "mirror_url"
        case name
        case networkCount = "network_count"
        case notificationsUrl = "notifications_url"
        case openIssuesCount = "open_issues_count"
        case organization
        case owner
        case parent
        case permissions
        case privateField = "private"
        case pullsUrl = "pulls_url"
        case pushedAt = "pushed_at"
        case releasesUrl = "releases_url"
        case size
        case source
        case sshUrl = "ssh_url"
        case stargazersCount = "stargazers_count"
        case stargazersUrl = "stargazers_url"
        case statusesUrl = "statuses_url"
        case subscribersCount = "subscribers_count"
        case subscribersUrl = "subscribers_url"
        case subscriptionUrl = "subscription_url"
        case svnUrl = "svn_url"
        case tagsUrl = "tags_url"
        case teamsUrl = "teams_url"
        case topics
        case treesUrl = "trees_url"
        case updatedAt = "updated_at"
        case url
        case watchersCount = "watchers_count"
    }
}
