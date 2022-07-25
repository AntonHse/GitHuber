//
//  AuthorizationRequest.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 21.07.2022.
//

struct AuthorizationRequest {
    /// `Required`. The client ID you received from GitHub when you registered.
    var clientID: String = GithubGlobalKeys.clientID
    /// A space-delimited list of scopes. If not provided, scope defaults to an empty list for users that have not authorized any scopes for the application. For users who have authorized scopes for the application, the user won't be shown the OAuth authorization page with the list of scopes. Instead, this step of the flow will automatically complete with the set of scopes the user has authorized for the application. For example, if a user has already performed the web flow twice and has authorized one token with user scope and another token with repo scope, a third web flow that does not provide a scope will receive a token with user and repo scope.
    let scope: [Scope] = [.repo, .readOrg, .repoStatus, .publicRepo, .user]
}
