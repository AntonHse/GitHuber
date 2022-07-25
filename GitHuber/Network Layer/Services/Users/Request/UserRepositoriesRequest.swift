//
//  UserRepositoriesRequest.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 24.07.2022.
//

struct UserRepositoriesRequestModel {
    /// Limit results to repositories with the specified visibility. `Default: all`
    var visibilityType: VisibilityType = .all
    /// Comma-separated list of values. `Default: owner,collaborator,organization_member`
    var affiliationType: [AffiliationType] = [.organizationMember, .owner, .collaborator]
    /// Limit results to repositories of the specified type. Will cause a 422 error if used in the same request as visibility or affiliation. `Default: all`
    /// `Note: If you specify visibility or affiliation, you cannot specify type`
    var type: RepositoryType? = nil
    /// The property to sort the results by. `Default: full_name`
    var sortType: UserRepositoriesSortType = .fullName
    /// Page number of the results to fetch.  `Default: 1`
    var page: Int = 1
    /// The number of results per page (max 100). `Default: 30 (Api), 100 (Local)`
    var perPage: Int = 100
}
