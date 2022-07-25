//
//  RepositoryDetailsPresenter.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 18.07.2022.
//

import Maaku

protocol RepositoryDetailsPresenterProtocol {
    func presentData(_ repoData: RepositoryResponse, readmeData: [Block])
    func presentSafari(url: URL)
    
    func presentHeading(text: String)
    func presentFootnote(number: Int)
}

final class RepositoryDetailsPresenter {
    weak var viewController: RepositoryDetailsVCProtocol?

    // MARK: - Private Properties
    private let router: RepositoryDetailsRouterProtocol
    private let readmeFactory: ReadmeFactoryProtocol
    
    private var blocks: [Block] = []

    // MARK: - Init
    init(router: RepositoryDetailsRouterProtocol, readmeFactory: ReadmeFactoryProtocol) {
        self.router = router
        self.readmeFactory = readmeFactory
    }
}

// MARK: - RepositoryDetailsPresenterProtocol
extension RepositoryDetailsPresenter: RepositoryDetailsPresenterProtocol {
    func presentData(_ repoData: RepositoryResponse, readmeData: [Block]) {
        var sections: [TableNodeSectionData] = []
        
        let infoSection = makeRepositoryInfoModelSection(data: repoData)
        let readmeSection = makeRepositoryReadmeModelSection(blocks: readmeData)

        sections.append(infoSection)
        if let readmeSection = readmeSection { sections.append(readmeSection) }
    
        self.blocks = readmeData
        viewController?.set(tableData: sections)
    }
    
    func presentSafari(url: URL) {
        router.routeToSafari(url: url)
    }
    
    func presentHeading(text: String) {
        blocks.enumerated().forEach { index, item in
            guard let heading = item as? Heading, heading.stringValue.lowercased() == text.lowercased() else { return }
            viewController?.scroll(to: index)
        }
    }
    
    func presentFootnote(number: Int) {
        blocks.enumerated().forEach { index, item in
            guard let footnote = item as? FootnoteDefinition, footnote.number == number else { return }
            viewController?.scroll(to: index)
        }
    }
}

// MARK: - Private Methods
private extension RepositoryDetailsPresenter {
    func makeRepositoryInfoModelSection(data: RepositoryResponse) -> TableNodeSectionData {
        let profileInfo = ProfileInfoNodeModel(imageUrl: data.owner?.avatarUrl, text: data.owner?.login)
        let cell = RepositoryInfoCellNodeModel(type: .repoInfo,
                                               id: data.id,
                                               profileInfo: profileInfo,
                                               name: data.name ?? "",
                                               description: data.descriptionField,
                                               repoLink: data.homepage,
                                               rating: data.watchersCount,
                                               forks: data.forksCount)
        return TableNodeSectionData(cells: [cell])
    }
    
    func makeRepositoryReadmeModelSection(blocks: [Block]) -> TableNodeSectionData? {
        let cells = readmeFactory.makeReadmeCells(readmeBlocks: blocks)
        let header = ASHeaderNodeModel(image: Images.info, description: "README.md")
        let section = TableNodeSectionData(header: header, cells: cells)
        return !cells.isEmpty ? section : nil
    }
}
