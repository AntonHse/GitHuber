//
//  SearchService.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

/// https://docs.github.com/en/rest/search#search-repositories
protocol SearchServiceProtocol {
    /// Get list of repositories from search text
    /// - Parameters:
    ///   - text: The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub
    ///   - sortType: Sorts the results of your query by number of stars, forks, or help-wanted-issues or how recently the items were updated. `Default: best match`
    ///   - orderType: Determines whether the first search result returned is the highest number of matches (desc) or lowest number of matches (asc). This parameter is ignored unless you provide sort. `Default: desc`
    ///   - page: Page number of the results to fetch.  `Default: 1`
    ///   - perPage: The number of results per page (max 100). `Default: 30 (Api), 100 (Local)`
    ///   - completion: Completion block
    func fetchRepositories(
        for text: String,
        sortType: SearchSortType?,
        orderType: OrderType,
        page: Int,
        perPage: Int?,
        completion: @escaping (Result<SearchRepositoriesResponse, NetworkErrors>) -> Void
    )
}

final class SearchService {

    // MARK: - Private Properties
    private let networkClient: NetworkClientProtocol
    
    private static let numberPerPage = 100
    
    private struct Path {
        static let searchRepositories = "/search/repositories"
    }

    // MARK: - Init
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
}

// MARK: - RepositoriesServiceProtocol
extension SearchService: SearchServiceProtocol {

    func fetchRepositories(for text: String,
                           sortType: SearchSortType?,
                           orderType: OrderType,
                           page: Int,
                           perPage: Int?,
                           completion: @escaping (Result<SearchRepositoriesResponse, NetworkErrors>) -> Void) {
        var parameters: [String: String] = [
            Keys.text.rawValue: text,
            Keys.order.rawValue: orderType.rawValue,
            Keys.page.rawValue: String(page),
            Keys.perPage.rawValue: String(perPage ?? SearchService.numberPerPage)
        ]
        
        if let sort = sortType?.rawValue {
            parameters[Keys.sort.rawValue] = sort
        }
        
        let request = Request<SearchRepositoriesResponse>(path: Path.searchRepositories,
                                                          type: .urlParameters(parameters),
                                                          headers: ["Accept": "application/vnd.github.v3+json"])
        networkClient.sendRequest(request: request) { result in
            switch result {
            case .success(let response):
                guard let data = response as? SearchRepositoriesResponse else {
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

// MARK: - Keys
private extension SearchService {
    enum Keys: String {
        case text = "q"
        case order
        case sort
        case perPage = "per_page"
        case page
    }
}
