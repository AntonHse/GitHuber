//
//  Images.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

import UIKit

enum Images {
    case fork
    case link
    case info
    case star
    case githubLogo
}

// MARK: - UIImage
extension Images {
    var image: UIImage? {
        switch self {
        case .fork:
            return UIImage(systemName: "tuningfork")
        case .link:
            return UIImage(systemName: "link")
        case .info:
            return UIImage(systemName: "info.circle")
        case .star:
            return UIImage(named: "Star")?.withRenderingMode(.alwaysTemplate)
        case .githubLogo:
            return UIImage(named: "GithubLogo")
        }
    }
}
