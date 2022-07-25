//
//  AuthorizationServiceRequest.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 16.07.2022.
//

struct AccessTokenRequest {
    /// Required. The client ID you received from GitHub for your OAuth App.
    var clientId: String = GithubGlobalKeys.clientID
    /// Required. The client secret you received from GitHub for your OAuth App.
    var clientSecret: String = GithubGlobalKeys.clientSecret
    /// Required. The code you received as a response to Step 1.
    let code: String
    /// The URL in your application where users are sent after authorization.
    var redirectUri: String? = GithubGlobalKeys.redirectUrl
}
