//
//  RepositoryDetailsInteractor.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 18.07.2022.
//

import Maaku

protocol RepositoryDetailsInteractorProtocol {
    /// Load authorized users repositories
    func getInitialData()
    
    func handleLinkTapped(url: URL)
}

final class RepositoryDetailsInteractor {
    
    // MARK: - Private Properties
    private let presenter: RepositoryDetailsPresenterProtocol
    private let service: RepositoryServiceProtocol
    
    private let ownerName: String
    private let repositoryName: String

    /// The number formatter.
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        return formatter
    }()

    // MARK: - Init
    init(ownerName: String,
         repositoryName: String,
         presenter: RepositoryDetailsPresenterProtocol,
         service: RepositoryServiceProtocol
    ) {
        self.ownerName = ownerName
        self.repositoryName = repositoryName
        self.presenter = presenter
        self.service = service
    }
}

// MARK: - RepositoryDetailsInteractorProtocol
extension RepositoryDetailsInteractor: RepositoryDetailsInteractorProtocol {
    func getInitialData() {
        service.fetchRepositoryInfoWithReadme(ownerName: ownerName, repositoryName: repositoryName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let blocks = self.configureBlocks(data: response.readme)
                self.presenter.presentData(response.info, readmeData: blocks)
            case .failure:
                break
                // TODO: Handle error
            }
        }
    }
    
    /// Called when a document link is tapped.
    /// Subclasses can override this to customize handling of URLs.
    /// URLs that look like web links (http...) will open in
    /// SFSafariViewController by default.
    ///
    /// - Parameters:
    ///     - url: The URL that was tapped.
    func handleLinkTapped(url: URL) {
        let scheme = url.scheme ?? ""
    
        if scheme.hasPrefix("http") {
            presenter.presentSafari(url: url)
        } else if scheme.hasPrefix("footnote") {
            guard let host = url.host,
                  let footnoteNumber = numberFormatter.number(from: host)?.intValue else { return }
            presenter.presentFootnote(number: footnoteNumber)
        } else if url.absoluteString.hasPrefix("#"), let fragment = url.fragment?.urlSpaceDecoded {
            presenter.presentHeading(text: fragment)
        } else if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

// MARK: - Private Extension
private extension RepositoryDetailsInteractor {
    func configureBlocks(data: RepositoryReadmeResponse) -> [Block] {
        guard let content = data.content,
              let decodedData = Data(base64Encoded: content, options: .ignoreUnknownCharacters),
              let document = try? Document(data: decodedData, options: .preLang) else { return [] }
        return document.items
    }
}
