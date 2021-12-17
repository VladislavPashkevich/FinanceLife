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


extension Date {
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        let dateInFormat = dateFormatter.string(from: self as Date)
        return dateInFormat
    }
}
