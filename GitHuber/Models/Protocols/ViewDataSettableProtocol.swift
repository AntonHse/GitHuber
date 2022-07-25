//
//  ViewDataSettable.swift
//  GitHuber
//
//  Created by Anton Shupletsov on 18.07.2022.
//

protocol ViewDataSettableProtocol {
    associatedtype ModelType

    func set(model: ModelType)
}
