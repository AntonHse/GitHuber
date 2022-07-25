//
//  ASLanguageNode.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

import AsyncDisplayKit

enum LanguageType: String {
    case swift
    case cPlusPlus = "C++"
    case vala
    case go
    case schell
    case pascal
    case objectiveC = "objective-c"
    case python
    case php
    case javaScript
    case ruby
    case java
    
    var color: UIColor {
        switch self {
        case .swift: return .orange
        case .cPlusPlus: return .systemPink
        case .schell: return .green
        case .javaScript: return .yellow
        case .go: return .blue
        case .vala: return .purple
        case .python, .objectiveC: return .systemBlue
        case .ruby, .java: return .brown
        default: return .black // TODO: Expand
        }
    }
}

final class ASLanguageNode: BaseNode {
    
    // MARK: - Private Properties
    private let colorNode = ASDisplayNode()
    private let languageName = ASTextNode()
    
    // MARK: - Init
    override init() {
        super.init()
        
        configureNode()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let hStack = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 4,
                                       justifyContent: .spaceBetween,
                                       alignItems: .center,
                                       children: [colorNode, languageName])
        return hStack
    }

    // MARK: - Public Methods
    func set(language: String) {
        let languageType = LanguageType(rawValue: language.lowercased())
        languageName.attributedText = language.normal(color: Colors.placeholderText)
        colorNode.backgroundColor = languageType?.color ?? .black
    }
}

// MARK: - Private Methods
private extension ASLanguageNode {
    func configureNode() {
        colorNode.style.preferredSize = CGSize(width: 13, height: 13)
        colorNode.cornerRadius = colorNode.style.preferredSize.height / 2
    }
}

