//
//  Sequence+Extensions.swift
//  Finance Life
//
//  Created by Vladislav Pashkevich on 20.12.21.
//

import Foundation


extension Sequence  {
    func sum<T: AdditiveArithmetic>(_ predicate: (Element) -> T) -> T { reduce(.zero) { $0 + predicate($1) } }
}
