//
//  RepositoryDetailsVC.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 18.07.2022.
//

import AsyncDisplayKit

protocol RepositoryDetailsVCProtocol: TableNodeControllerProtocol {
    /// Scrolls to the cell
    ///
    /// - Parameters:
    ///     - rowIndex: Row index
    func scroll(to rowIndex: Int)
}

final class RepositoryDetailsVC: ASDKViewController<BaseNode> {
    
    // MARK: - Private Properties
    /// The collection node.
    private let collectionNode: ASCollectionNode
    /// The collection view layout.
    private let collectionViewLayout: UICollectionViewFlowLayout
    private let interactor: RepositoryDetailsInteractorProtocol
    
    private var dataSource: [TableNodeSectionData] = []
    
    // MARK: - Init
    init(interactor: RepositoryDetailsInteractorProtocol) {
        self.interactor = interactor
    
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionNode = ASCollectionNode(collectionViewLayout: collectionViewLayout)
    
        super.init(node: BaseNode())
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionNode()
        interactor.getInitialData()
    }
    
    // MARK: - Layout
    func setupLayout() {
        node.addSubnode(collectionNode)
        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASInsetLayoutSpec() }
            return ASWrapperLayoutSpec(layoutElement: self.collectionNode)
        }
    }
}

// MARK: - RepositoryDetailsVCProtocol
extension RepositoryDetailsVC: RepositoryDetailsVCProtocol {
    
    func set(tableData: [TableNodeSectionData]) {
        dataSource = tableData
        collectionNode.reloadData()
    }

    func scroll(to rowIndex: Int) {
        let indexPath = IndexPath(item: rowIndex, section: 1) // TODO: Section universal
        collectionNode.scrollToItem(at: indexPath, at: .top, animated: true)
    }
}

// MARK: - ASTableDataSource
extension RepositoryDetailsVC: ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = { () -> ASCellNode in
            guard indexPath.section == 1,  // TODO: Section universal
                  let model = self.dataSource[indexPath.section].header as? ASHeaderNodeModel else { return ASCellNode() }
            let header = ASHeaderNode()
            header.set(imageType: model.image, description: model.description)
            return header
        }
        return cellNodeBlock

    }

    func collectionNode(_ collectionNode: ASCollectionNode, supplementaryElementKindsInSection section: Int) -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = { () -> ASCellNode in
            guard let cellModel = self.dataSource[indexPath.section].cells[safe: indexPath.row] else { return ASCellNode() }
        
            switch cellModel.type {
            case .repoInfo:
                let cell = RepositoryInfoCellNode()
                cell.set(model: cellModel, delegate: self)
                return cell
            case .readme(let type):
                let node: ASDisplayNode
        
                switch type {
                case .paragraph:
                    guard let cellModel = cellModel as? ParagraphNodeModel else { return ASCellNode() }
                    node = ParagraphNode(model: cellModel)
                case .codeBlock:
                    guard let cellModel = cellModel as? CodeBlockNodeModel else { return ASCellNode() }
                    node = CodeBlockNode(model: cellModel)
                case .footnoteDefinition:
                    guard let cellModel = cellModel as? FootnoteDefinitionNodeModel else { return ASCellNode() }
                    node = FootnoteDefinitionNode(model: cellModel)
                case .list:
                    guard let cellModel = cellModel as? ListNodeModel else { return ASCellNode() }
                    node = ListNode(model: cellModel)
                case .horizontalRyle:
                    guard let cellModel = cellModel as? HorizontalRuleNodeModel else { return ASCellNode() }
                    node = HorizontalRuleNode(model: cellModel)
                case .tableRow:
                    guard let cellModel = cellModel as? TableRowNodeModel else { return ASCellNode() }
                    node = TableRowNode(model: cellModel)
                case .table:
                    guard let cellModel = cellModel as? TableNodeModel else { return ASCellNode() }
                    node = TableNode(model: cellModel)
                case .blockQuote:
                    guard let cellModel = cellModel as? BlockQuoteNodeModel else { return ASCellNode() }
                    node = BlockQuoteNode(model: cellModel)
                case .heading:
                    guard let cellModel = cellModel as? HeadingNodeModel else { return ASCellNode() }
                    node = HeadingNode(model: cellModel)
                case .listItem:
                    guard let cellModel = cellModel as? ListItemNodeModel else { return ASCellNode() }
                    node = ListItemNode(model: cellModel)
                case .tableCell:
                    guard let cellModel = cellModel as? TableCellNodeModel else { return ASCellNode() }
                    node = TableCellNode(model: cellModel)
                }
                
                if var linkable = node as? Linkable {
                    linkable.linkDelegate = self
                }
                
                return WrapperCellNode(node: node)
            }
        }

        return cellNodeBlock
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].cells.count
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return dataSource.count
    }
}

// MARK: - ASTableDelegate
extension RepositoryDetailsVC: ASCollectionDelegateFlowLayout, ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, sizeRangeForHeaderInSection section: Int) -> ASSizeRange {
        guard section == 1 else { return ASSizeRangeMake(CGSize(width: 0, height: 0)) } // TODO: Section universal
        return ASSizeRangeMake(CGSize(width: collectionNode.bounds.size.width, height: 55))
    }
    
    func collectionView(_ collectionView: ASCollectionView,
                        constrainedSizeForNodeAt indexPath: IndexPath) -> ASSizeRange {
        let maxHeight = CGFloat.greatestFiniteMagnitude
        let itemWidth: CGFloat = view.frame.width
        let minSize = CGSize(width: itemWidth, height: 0)
        let maxSize = CGSize(width: itemWidth, height: maxHeight)
        let sizeRange = ASSizeRangeMake(minSize, maxSize)

        return sizeRange
    }
}

// MARK: - LinkDelegate
extension RepositoryDetailsVC: LinkDelegate {
    func linkTapped(_ url: URL) {
        interactor.handleLinkTapped(url: url)
    }
}

// MARK: - Private Methods
private extension RepositoryDetailsVC {
    func configureCollectionNode() {
        collectionViewLayout.minimumLineSpacing = 0.0
        collectionViewLayout.minimumInteritemSpacing = 0.0
        collectionViewLayout.sectionInset = .zero
        
        collectionNode.delegate = self
        collectionNode.dataSource = self
        
        collectionNode.view.scrollsToTop = true
        collectionNode.view.alwaysBounceVertical = true
        collectionNode.backgroundColor = .white
        
        collectionNode.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionHeader)
    }
}
