//
//  UIColor+Extension.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

import UIKit

extension UIColor {
    static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ aplha: CGFloat = 256) -> UIColor {
        return .init(red: red / 256, green: green / 256, blue: blue / 256, alpha: 256 / 256)
    }
}
