//
//  NSAttributedString+Extension.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 17.07.2022.
//

import Foundation
import UIKit

/// Regex to match character headers.
private let headerRegex = try? NSRegularExpression(pattern: "^(\\d{1,2}|\\w)\\.\\s", options: [])

/// Internal extensions for String
extension String {

    /// Finds a character header matching this string.
    ///
    /// The pattern for a character header is a string starting with
    /// 1-2 digits or any single word character, followed by a ".",
    /// followed by a space (which could be a non-breaking space \u{00A0})
    ///
    /// The regex pattern for the match is: ^(\d{1,2}|\w)\.\s
    ///
    /// - Returns:
    ///     The matching header if found, nil otherwise.
    func characterHeaderMatch() -> String? {
        let matchRange = NSRange(location: 0, length: utf16.count)
        guard let match = headerRegex?.firstMatch(in: self, options: [], range: matchRange),
            let range = Range(match.range, in: self) else {
            return nil
        }

        return String(self[range])
    }

    /// Gets the string with "+" and "%20" replaced with space " " characters.
    var urlSpaceDecoded: String {
        let plusReplaced = self.replacingOccurrences(of: "+", with: " ")
        return plusReplaced.removingPercentEncoding ?? plusReplaced
    }

}

// MARK: - NSAttributedString Fonts
extension String {
    
    func bold(color: UIColor = .label) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.boldSystemFont(ofSize: 18),
        ]
        return NSMutableAttributedString(
            string: self,
            attributes: attributes
        )
    }

    func normal(color: UIColor = .label) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.systemFont(ofSize: 18)
        ]
        return NSMutableAttributedString(
            string: self,
            attributes: attributes
        )
    }
    
    func smallBold(color: UIColor = .label) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineColor: UIColor.clear,
            .foregroundColor: color,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        return NSMutableAttributedString (
            string: self,
            attributes: attributes
        )
    }
    
    func small(color: UIColor = .label) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        return NSMutableAttributedString (
            string: self,
            attributes: attributes
        )
    }
    
    func custom(color: UIColor = .label, fontSize: CGFloat) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.systemFont(ofSize: fontSize)
        ]
        return NSMutableAttributedString (
            string: self,
            attributes: attributes
        )
    }
    
    var placeholder: NSMutableAttributedString  {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.placeholderText,
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]
        return NSMutableAttributedString (
            string: self,
            attributes: attributes
        )
    }
}
