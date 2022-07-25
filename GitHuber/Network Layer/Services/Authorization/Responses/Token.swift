//
//  Token.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 16.07.2022.
//

struct Token: Decodable {
    let accessToken: String
    let tokenType: String
    let scope: String
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decode(String.self, forKey: .accessToken)
        tokenType = try values.decode(String.self, forKey: .tokenType)
        scope = try values.decode(String.self, forKey: .scope)
    }
}

// MARK: - Private
private extension Token {
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope = "scope"
    }
}
