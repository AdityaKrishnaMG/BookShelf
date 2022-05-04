//
//  Utils.swift
//  BookShelf
//
//  Created by Aditya Krishna on 4/27/22.
//

import Foundation

func map<T: Decodable>(json: Any, to type: T.Type) -> T {
    let parseData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    let mappedObject = try! JSONDecoder().decode(T.self, from: parseData)
    return mappedObject
}
