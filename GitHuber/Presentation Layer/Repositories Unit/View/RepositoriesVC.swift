//
//  RepositoriesViewController.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 13.07.2022.
//

import AsyncDisplayKit

protocol RepositoriesVCProtocol: AnyObject {
    func set(cells: [RepositoryCellNodeModel])
    func insert(cells: [RepositoryCellNodeModel])
}

final class RepositoriesVC: ASDKViewController<BaseNode> {
    
    // MARK: - Private Properties
    private let tableNode = ASTableNode(style: .plain)
    private let interactor: RepositoriesInteractorProtocol
    
    private var cellModels: [RepositoryCellNodeModel] = []
    private var searchText: String = ""
    
    private let footerLoader = UIActivityIndicatorView(style: .medium)
    private lazy var loader: UIActivityIndicatorView = {
        return UIActivityIndicatorView(style: .medium)
    }()

    // MARK: - Init
    init(interactor: RepositoriesInteractorProtocol) {
        self.interactor = interactor
    
        super.init(node: BaseNode())
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureFooterLoader()
        configureNavigationBar()
        configureSearchBar()
        configureTableNode()
        
        showLoader()
        interactor.getInitialData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        // Center the activity indicator view
        let bounds = node.bounds
        loader.frame.origin = CGPoint(
            x: (bounds.width - loader.frame.width) / 2.0,
            y: (bounds.height - loader.frame.height) / 2.0
        )
    }
    
    // MARK: - Layout
    func setupLayout() {
        node.addSubnode(tableNode)
        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASInsetLayoutSpec() }
            return ASWrapperLayoutSpec(layoutElement: self.tableNode)
        }
    }
}

// MARK: - RepositoriesViewControllerProtocol
extension RepositoriesVC: RepositoriesVCProtocol {
    func set(cells: [RepositoryCellNodeModel]) {
        hideLoader()
        
        cellModels = cells
        tableNode.reloadData()
    }
    
    func insert(cells: [RepositoryCellNodeModel]) {
        let section = 0
        let totalCount = cellModels.count + cells.count
        var indexPaths: [IndexPath] = []

        for row in cellModels.count..<totalCount {
            let path = IndexPath(row: row, section: section)
            indexPaths.append(path)
        }
        
        hideLoader()
        cellModels.append(contentsOf: cells)
        tableNode.insertRows(at: indexPaths, with: .fade)
    }
}

// MARK: - ASTableDataSource
extension RepositoriesVC: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = { () -> ASCellNode in
            guard let cellModel = self.cellModels[safe: indexPath.row] else { return ASCellNode() }

            let cell = RepositoryCellNode()
            cell.set(model: cellModel)
           // cell.debugName = String(indexPath.row)
            return cell
        }

        return cellNodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
}

// MARK: - ASTableDelegate
extension RepositoriesVC: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width
        return ASSizeRangeMake(CGSize(width: width, height: 0), CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        guard let index = tableNode.indexPathForSelectedRow else { return }
        tableNode.deselectRow(at: index, animated: true)

        guard let cellModel = self.cellModels[safe: indexPath.row],
              let ownerName = cellModel.profileInfo.text else { return }
        interactor.handleCellTapped(ownerName: ownerName, repositoryName: cellModel.name)
    }
    
    /// Should load new batches
    /// - Parameter tableNode: Table node
    /// - Returns: `true` - Infinite scroll; `false` - Nothing to load
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        context.beginBatchFetching()
        showFooterLoader()

        interactor.uploadRepositories(for: searchText, from: cellModels.count) { [weak self] success in
            self?.hideFooterLoader()
            success ? context.completeBatchFetching(success) : context.cancelBatchFetching()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // tableNode bug(?) (https://github.com/facebookarchive/AsyncDisplayKit/issues/1631):
        tableNode.leadingScreensForBatching = 2
    }
}

// MARK: - UITextFieldDelegate
extension RepositoriesVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText = textField.text ?? ""
        
        showLoader()
        interactor.getRepositories(for: textField.text ?? "")
        return true
    }
}

// MARK: - Private Methods
private extension RepositoriesVC {
    func configureTableNode() {
        node.view.addSubview(loader)
        
        tableNode.backgroundColor = .white
        tableNode.delegate = self
        tableNode.dataSource = self

        // tableNode bug(?) (https://github.com/facebookarchive/AsyncDisplayKit/issues/1631):
        tableNode.leadingScreensForBatching = 0 // Means that you want new batches to be loaded every time the user scrolls to the point where there is only 2 element left in the table
    }
    
    func configureFooterLoader() {
        footerLoader.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableNode.bounds.width, height: CGFloat(44))
        
        tableNode.view.tableFooterView = footerLoader
        tableNode.view.tableFooterView?.isHidden = false
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logOutButtonTapped))
    }
    
    func configureSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.searchTextField.delegate = self
        navigationItem.searchController = search
    }

    func showLoader() {
        navigationItem.searchController?.dismiss(animated: true)
        loader.isHidden = false
        loader.startAnimating()
    }
    
    func hideLoader() {
        loader.isHidden = true
        loader.stopAnimating()
    }
    
    func showFooterLoader() {
        DispatchQueue.main.async {
            self.footerLoader.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.tableNode.bounds.width, height: CGFloat(44))
            
            self.footerLoader.isHidden = false
            self.footerLoader.startAnimating()
            
            self.tableNode.view.tableFooterView = self.footerLoader
            self.tableNode.view.tableFooterView?.isHidden = false
        }
    }
    
    func hideFooterLoader() {
        DispatchQueue.main.async {
            self.tableNode.view.tableFooterView = nil
            self.footerLoader.isHidden = true
            self.footerLoader.stopAnimating()
        }
    }

    // MARK: - Actions
    @objc
    func logOutButtonTapped() {
        interactor.logOutUser()
    }
}
