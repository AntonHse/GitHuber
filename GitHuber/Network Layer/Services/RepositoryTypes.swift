//
//  RepositoryTypes.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 24.07.2022.
//

enum VisibilityType: String {
    case all
    case `public`
    case `private`
}

enum AffiliationType: String {
    case owner
    case collaborator
    case organizationMember = "organization_member"
}

enum RepositoryType: String {
    case all
    case owner
    case `public`
    case `private`
    case member
}

enum UserRepositoriesSortType: String {
    case created
    case updated
    case pushed
    case fullName = "full_name"
}

enum SearchSortType: String {
    case stars
    case forks
    case updated
}

enum OrderType: String {
    case asc
    case desc
}
