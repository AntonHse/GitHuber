//
//  ASLinkNode.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 25.07.2022.
//


import AsyncDisplayKit

final class ASLinkNode: BaseNode, Linkable {
    
    /// The link delegate.
    weak var linkDelegate: LinkDelegate?
    
    // MARK: - Private Properties
    private let linkImage = ASImageNode()
    private let linkText = ASTextNode()
    
    // MARK: - Init
    override init() {
        super.init()
        
        configureNode()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let hStack = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 4,
                                       justifyContent: .start,
                                       alignItems: .start,
                                       children: [linkImage, linkText])
        return hStack
    }

    // MARK: - Public Methods
    func set(description: String) {
        let text = description.smallBold()
        text.addAttribute(.link, value: description, range: NSRange(location: 0, length: text.length))
        linkText.attributedText = text
        
        linkImage.image = Images.link.image
    }
}

// MARK: - ASTextNodeDelegate
extension ASLinkNode: ASTextNodeDelegate {
    func textNode(_ textNode: ASTextNode,
                  tappedLinkAttribute attribute: String,
                  value: Any, at point: CGPoint,
                  textRange: NSRange) {
        if let valueStr = value as? String, let url = URL(string: valueStr) {
            linkDelegate?.linkTapped(url)
        }
    }

    func textNode(_ textNode: ASTextNode,
                         shouldHighlightLinkAttribute attribute: String,
                         value: Any,
                         at point: CGPoint) -> Bool {
        return true
    }
}

// MARK: - Private Methods
private extension ASLinkNode {
    func configureNode() {
        linkText.delegate = self
        linkText.isUserInteractionEnabled = true

        linkImage.style.preferredSize = CGSize(width: 14, height: 14)
        linkImage.tintColor = Colors.placeholderText
    }
}

