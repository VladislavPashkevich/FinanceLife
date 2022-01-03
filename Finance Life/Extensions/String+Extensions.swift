//
//  String+Extensions.swift
//  Finance Life
//
//  Created by Vladislav Pashkevich on 11.12.21.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}




extension Dictionary where Value: Equatable {
    func key(from value: Value) -> Key? {
        return self.first(where: { $0.value == value })?.key
    }
}

//print(someDictionary.key(from: someValue)) // optional
//
//if let key = someDictionary.key(from: someValue) {
//    print(key) // non-optional
//}


