//
//  GithubToken.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 16.07.2022.
//

import Foundation

struct GithubWebAuthorizeRequest {
    /// `Required`. The client ID you received from GitHub when you registered.
    var clientID: String = GithubGlobalKeys.clientID
    /// The URL in your application where users will be sent after authorization. See details below about redirect urls.
    var redirectUri: String? = nil
    /// A space-delimited list of scopes. If not provided, scope defaults to an empty list for users that have not authorized any scopes for the application. For users who have authorized scopes for the application, the user won't be shown the OAuth authorization page with the list of scopes. Instead, this step of the flow will automatically complete with the set of scopes the user has authorized for the application. For example, if a user has already performed the web flow twice and has authorized one token with user scope and another token with repo scope, a third web flow that does not provide a scope will receive a token with user and repo scope.
    let scope: [Scope] = [.repo, .readOrg, .repoStatus, .publicRepo]
    /// Suggests a specific account to use for signing in and authorizing the app.
    var login: String? = nil
    /// An unguessable random string. It is used to protect against cross-site request forgery attacks.
    let state: String = UUID().debugDescription
    /// Whether or not unauthenticated users will be offered an option to sign up for GitHub during the OAuth flow. The default is true. Use false when a policy prohibits signups.
    let allowSignup: Bool = true
}

/// Github permissions
enum Scope: String {
    case user = "user"
    case userEmail = "user:email"
    case userFollow = "user:follow"
    case publicRepo = "public_repo"
    case repo = "repo"
    case repoDeployment = "repo_deployment"
    case repoStatus = "repo:status"
    case deleteRepo = "delete_repo"
    case notifications = "notifications"
    case gist = "gist"
    case readRepoHook = "read:repo_hook"
    case writeRepoHook = "write:repo_hook"
    case adminRepoHook = "admin:repo_hook"
    case adminOrgHook = "admin:org_hook"
    case readOrg = "read:org"
    case writeOrg = "write:org"
    case adminOrg = "admin:org"
    case readPublicKey = "read:public_key"
    case writePublicKey = "write:public_key"
    case adminPublicKey = "admin:public_key"
    case readGPGKey = "read:gpg_key"
    case writeGPGKey = "write:gpg_key"
    case adminGPGKey = "admin:gpg_key"
    case workflow
}
