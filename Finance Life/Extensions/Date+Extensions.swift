//
//  Date+Extensions.swift
//  Finance Life
//
//  Created by Vladislav Pashkevich on 20.12.21.
//

import Foundation



extension Date {
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        let dateInFormat = dateFormatter.string(from: self as Date)
        return dateInFormat
    }
}
