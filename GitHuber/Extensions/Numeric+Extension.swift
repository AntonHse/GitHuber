//
//  Numeric+Extension.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 18.07.2022.
//

import Foundation

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
