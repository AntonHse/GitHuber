//
//  ASTextFieldNode.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

import AsyncDisplayKit

final class ASTextFieldNode: ASEditableTextNode {
    override init() {
        super.init()
        
        textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        placeholderEnabled = true
        scrollEnabled = false
        maximumLinesToDisplay = 1
        backgroundColor = Colors.backgroundGray
//        textView.
//        typingAttributes = [NSAttributedString.Key.backgroundColor: UIColor.red]
//        cornerRadius = CGFloat(style.preferredSize.height / 2)
    }
    
    override init(textKitComponents: ASTextKitComponents, placeholderTextKitComponents: ASTextKitComponents) {
        super.init(textKitComponents: textKitComponents, placeholderTextKitComponents: placeholderTextKitComponents)
    }
}
