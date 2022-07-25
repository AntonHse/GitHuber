//
//  UsersService.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 24.07.2022.
//

protocol UsersServiceProtocol {
    /// If the authenticated user is authenticated through basic authentication or OAuth with the user scope, then the response lists public and private profile information. If the authenticated user is authenticated through OAuth without the user scope, then the response lists only public profile information.
    func fetchUser(completion: @escaping (Result<User, NetworkErrors>) -> Void)
    
    /// Lists repositories that the authenticated user has explicit permission (:read, :write, or :admin) to access. The authenticated user has explicit permission to access repositories they own, repositories where they are a collaborator, and repositories that they can access through an organization membership.
    /// - Parameters:
    ///   - completion: Competion block
    ///   - model: UserRepositories request model
    func fetchUserRepositories(
        model: UserRepositoriesRequestModel,
        completion: @escaping (Result<[RepositoryResponse], NetworkErrors>) -> Void
    )
}

final class UsersService {

    // MARK: - Private Properties
    private let networkClient: NetworkClientProtocol
    
    private struct Path {
        static let user = "user"
        static let userRepos = "user/repos"
    }
    
    // MARK: - Init
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
}

// MARK: - UsersServiceProtocol
extension UsersService: UsersServiceProtocol {
    func fetchUser(completion: @escaping (Result<User, NetworkErrors>) -> Void) {
        let request = Request<User>(path: Path.user,
                                    headers: ["Accept": "application/vnd.github.v3+json"])
        networkClient.sendRequest(request: request) { result in
            switch result {
            case .success(let response):
                guard let data = response as? User else {
                    completion(.failure(NetworkErrors.default))
                    return
                }
                completion(.success(data))
            case .failure(let error):
                completion(.failure(NetworkErrors.describing(error)))
            }
        }
    }
    
    func fetchUserRepositories(model: UserRepositoriesRequestModel,
                               completion: @escaping (Result<[RepositoryResponse], NetworkErrors>) -> Void) {
        var parameters: [String: String] = [
            Keys.visibility.rawValue: model.visibilityType.rawValue,
            Keys.sort.rawValue: model.sortType.rawValue,
            Keys.page.rawValue: String(model.page),
            Keys.perPage.rawValue: String(model.perPage)
        ]
        if !model.affiliationType.isEmpty {
            parameters[Keys.affiliation.rawValue] = model.affiliationType.map { $0.rawValue }.joined(separator: ",")
        }
        
        let request = Request<[RepositoryResponse]>(path: Path.userRepos,
                                                    type: .urlParameters(parameters),
                                                    headers: ["Accept": "application/vnd.github+json"])
        networkClient.sendRequest(request: request) { result in
            switch result {
            case .success(let response):
                guard let data = response as? [RepositoryResponse] else {
                    completion(.failure(NetworkErrors.default))
                    return
                }
                completion(.success(data))
            case .failure(let error):
                completion(.failure(NetworkErrors.describing(error)))
            }
        }
    }
}

// MARK: - Private
private extension UsersService {
    enum Keys: String {
        case visibility
        case affiliation
        case type
        case sort
        case direction
        case perPage = "per_page"
        case page
    }
}
