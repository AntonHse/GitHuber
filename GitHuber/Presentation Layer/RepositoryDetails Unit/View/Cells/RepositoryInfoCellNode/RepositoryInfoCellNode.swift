//
//  RepositoryInfoCell.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 19.07.2022.
//

import AsyncDisplayKit

final class RepositoryInfoCellNode: BaseCellNode {
    let profileInfo = ASProfileInfoNode()
    let nameText = ASTextNode()
    let descriptionText = ASTextNode()
    let link = ASLinkNode()
    let starsCounterNode = ASInfoCounterNode()
    let forksCounterNode = ASInfoCounterNode()
    
    var isShowLink = false
    
    // MARK: - Init
    override init() {
        super.init()
        
        configureNode()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let headersSubnodes: [ASLayoutElement]
            
//        let bottomStack = ASStackLayoutSpec(direction: .horizontal,
//                                            spacing: 10,
//                                            justifyContent: .start,
//                                            alignItems: .stretch,
//                                            children: [rating, languageNode])
        let hSpec = ASStackLayoutSpec(direction: .horizontal,
                                      spacing: 10,
                                      justifyContent: .start,
                                      alignItems: .start,
                                      children: [starsCounterNode, forksCounterNode])
        var bottomNodes: [ASLayoutElement] = [hSpec]
        if isShowLink { bottomNodes.insert(link, at: 0) }
        headersSubnodes = descriptionText.attributedText?.length != .zero
            ? [profileInfo, nameText, descriptionText] + bottomNodes
            : [profileInfo, nameText] + bottomNodes
    
        let headerStackSpec = ASStackLayoutSpec(direction: .vertical,
                                                spacing: 10,
                                                justifyContent: .start,
                                                alignItems: .stretch,
                                                children: headersSubnodes)

        let layoutSpec = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: .minimumY, child: headerStackSpec)
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16), child: layoutSpec)
    }
    
    // MARK: - Public Methods
    func set(model: CellModel, delegate: LinkDelegate) {
        guard let model = model as? RepositoryInfoCellNodeModel else { return }
        
        
        profileInfo.set(model: model.profileInfo)
        nameText.attributedText = model.name.bold(color: .black)
        descriptionText.attributedText = model.description?.normal(color: .black)
        
        if let linkStr = model.repoLink {
            isShowLink = true
            link.set(description: linkStr)
            link.linkDelegate = delegate
        }
        if let rating = model.rating {
            starsCounterNode.set(imageType: .star, number: rating, description: "stars")
        }
        if let forks = model.forks {
            forksCounterNode.set(imageType: .fork, number: forks, description: "forks")
        }
    }
}

// MARK: - Private Methods
private extension RepositoryInfoCellNode {
    func configureNode() {
        nameText.maximumNumberOfLines = 1
    }
}
