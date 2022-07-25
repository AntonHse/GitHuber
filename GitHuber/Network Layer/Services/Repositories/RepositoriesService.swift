//
//  RepositoriesService.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

import Foundation

protocol RepositoryServiceProtocol {
    /// Get deailf information from user repository
    /// - Parameters:
    ///   - ownerName: The account owner of the repository. The name is not case sensitive.
    ///   - repositoryName: The name of the repository. The name is not case sensitive.
    ///   - completion: Completion block
    func fetchRepositoryInfo(
        ownerName: String,
        repositoryName: String,
        completion: @escaping (Result<RepositoryResponse, NetworkErrors>) -> Void
    )
    /// Get deailf information from user repository
    /// - Parameters:
    ///   - ownerName: The account owner of the repository. The name is not case sensitive.
    ///   - repositoryName: The name of the repository. The name is not case sensitive.
    ///   - completion: Completion block
    func fetchRepositoryReadme(
        ownerName: String,
        repositoryName: String,
        completion: @escaping (Result<RepositoryReadmeResponse, NetworkErrors>) -> Void
    )
    /// Combination of `fetchRepositoryInfo` and `fetchRepositoryReadme`
    /// - Parameters:
    ///   - ownerName: The account owner of the repository. The name is not case sensitive.
    ///   - repositoryName: The name of the repository. The name is not case sensitive.
    ///   - completion: Completion block
    func fetchRepositoryInfoWithReadme(
        ownerName: String,
        repositoryName: String,
        completion: @escaping (Result<RepositoryWithReadme, NetworkErrors>) -> Void
    )
}

final class RepositoryService {
    
    // MARK: - Private Properties
    private let networkClient: NetworkClientProtocol
    
    private struct Path {
        static let repository = "/repos"
        static let readme = "/readme"
    }
    
    // MARK: - Init
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
}

// MARK: - RepositoriesServiceProtocol
extension RepositoryService: RepositoryServiceProtocol {
    
    func fetchRepositoryInfoWithReadme(
        ownerName: String,
        repositoryName: String,
        completion: @escaping (Result<RepositoryWithReadme, NetworkErrors>) -> Void
    ) {
        let group = DispatchGroup()

        var repositoryInfo: RepositoryResponse?
        var repositoryReadme: RepositoryReadmeResponse?
        var error: NetworkErrors = .default
        
        group.enter()
        fetchRepositoryInfo(ownerName: ownerName, repositoryName: repositoryName) { result in
            group.leave()
    
            switch result {
            case .success(let response):
                repositoryInfo = response
            case .failure(let networkError):
                repositoryInfo = nil
                error = networkError
            }
        }
        
        group.enter()
        fetchRepositoryReadme(ownerName: ownerName, repositoryName: repositoryName) { result in
            group.leave()
    
            switch result {
            case .success(let response):
                repositoryReadme = response
            case .failure(let networkError):
                repositoryReadme = nil
                error = networkError
            }
        }
        
        group.notify(queue: .main) {
            guard let repositoryInfo = repositoryInfo, let repositoryReadme = repositoryReadme else {
                completion(.failure(error))
                return
            }
            
            let repositoryWithReponse = RepositoryWithReadme(info: repositoryInfo, readme: repositoryReadme)
            completion(.success(repositoryWithReponse))
        }
    }
    
    func fetchRepositoryInfo(
        ownerName: String,
        repositoryName: String,
        completion: @escaping (Result<RepositoryResponse, NetworkErrors>) -> Void
    ) {
        let request = Request<RepositoryResponse>(path: Path.repository + "/" + "\(ownerName)/\(repositoryName)",
                                                  headers: ["Accept": "application/vnd.github.v3+json"])
        networkClient.sendRequest(request: request) { result in
            switch result {
            case .success(let response):
                guard let data = response as? RepositoryResponse else {
                    completion(.failure(NetworkErrors.default))
                    return
                }
                completion(.success(data))
            case .failure(let error):
                completion(.failure(NetworkErrors.describing(error)))
            }
        }
    }
    
    func fetchRepositoryReadme(
        ownerName: String,
        repositoryName: String,
        completion: @escaping (Result<RepositoryReadmeResponse, NetworkErrors>) -> Void
    ) {
        let request = Request<RepositoryReadmeResponse>(path: Path.repository  + "/\(ownerName)/\(repositoryName)" + Path.readme,
                                                        headers: ["Accept": "application/vnd.github.v3+json"])
        networkClient.sendRequest(request: request) { result in
            switch result {
            case .success(let response):
                guard let data = response as? RepositoryReadmeResponse else {
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
