//
//  Array.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 18.07.2022.
//

extension Array {
    /// Safely retrieve an array element
    /// - Parameter index: element index
    subscript(safe index: Index) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}
