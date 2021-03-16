//
//  Array+Filtering.swift
//  Homework_8
//
//  Created by Sasha on 15/03/2021.
//

import Foundation

public extension Array where Element: Hashable {
    static func removeDuplicates(_ elements: [Element]) -> [Element] {
        var seen = Set<Element>()
        return elements.filter{ seen.insert($0).inserted }
    }
}
