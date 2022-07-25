//
//  DeeplinkHandler.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 22.07.2022.
//

import Foundation
import UIKit

protocol DeeplinkHandlerProtocol {
    func handleDeeplink(urlContext: UIOpenURLContext) -> DeeplinkType?
}

final class DeeplinkHandler: DeeplinkHandlerProtocol {
    func handleDeeplink(urlContext: UIOpenURLContext) -> DeeplinkType? {
        guard let urlComponents = NSURLComponents(url: urlContext.url, resolvingAgainstBaseURL: true),
              let host = urlComponents.host else { return nil }
        return DeeplinkType(rawValue: host)
    }
}
