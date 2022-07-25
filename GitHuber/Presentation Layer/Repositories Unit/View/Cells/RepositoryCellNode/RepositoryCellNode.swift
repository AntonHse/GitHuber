//
//  RepositoryCellNode.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

import AsyncDisplayKit

final class RepositoryCellNode: BaseCellNode, ViewDataSettableProtocol {
        
    let profileInfo = ASProfileInfoNode()
    let nameText = ASTextNode()
    let descriptionText = ASTextNode()
    let rating = ASRatingNode()
    let languageNode = ASLanguageNode()
    
    // MARK: - Init
    override init() {
        super.init()
        
        configureNode()
    }
    
//    override func didEnterDisplayState() {
//        super.didEnterDisplayState()
//        print("\(debugName) didEnterDisplayStat!")
//    }
//
//    override func didExitDisplayState() {
//        super.didExitDisplayState()
//        print("\(debugName) didExitDisplayState")
//    }
//
//    override func didEnterVisibleState() {
//        super.didEnterVisibleState()
//        print("\(debugName) didEnterVisibleState(")
//    }
//
//    override func didExitVisibleState() {
//        super.didExitVisibleState()
//        print("\(debugName) didExitVisibleState(")
//    }
//
//    override func didEnterPreloadState() {
//        super.didEnterPreloadState()
//        print("\(debugName) didEnterPreloadState")
//    }
//
//    override func didExitPreloadState() {
//        super.didExitPreloadState()
//        print("\(debugName) didExitPreloadState")
//    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let headersSubnodes: [ASLayoutElement]
            
        let bottomStack = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 10,
                                            justifyContent: .start,
                                            alignItems: .stretch,
                                            children: [rating, languageNode])
        
        headersSubnodes = descriptionText.attributedText?.length != .zero
            ? [profileInfo, nameText, descriptionText, bottomStack]
            : [profileInfo, nameText, bottomStack]
    
        let headerStackSpec = ASStackLayoutSpec(direction: .vertical,
                                                spacing: 6,
                                                justifyContent: .center,
                                                alignItems: .stretch,
                                                children: headersSubnodes)
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16), child: headerStackSpec)
    }

    // MARK: - Public Methods
    func set(model: RepositoryCellNodeModel) {
        profileInfo.set(model: model.profileInfo)
        nameText.attributedText = model.name.bold(color: .black)
        descriptionText.attributedText = model.description?.normal(color: .black)
        rating.set(rating: model.rating ?? 0)
        if let language = model.language {
            languageNode.set(language: language)
        }
    }
}

// MARK: - Private Methods
private extension RepositoryCellNode {
    func configureNode() {
        nameText.maximumNumberOfLines = 1
        descriptionText.maximumNumberOfLines = 4
    }
}
