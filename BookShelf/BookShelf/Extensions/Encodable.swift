//
//  Encodable.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/28/22.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String: Any] {
        let data = try! JSONEncoder().encode(self)
        guard let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            fatalError()
        }
        return dictionary
    }
}
