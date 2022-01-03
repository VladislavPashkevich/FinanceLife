//
//  MyCellDate.swift
//  Finance Life
//
//  Created by Vladislav Pashkevich on 4.12.21.
//

import Foundation
import UIKit

class MyCellDate: UITableViewCell {
    @IBOutlet private weak var textLabelDate: UILabel!
    @IBOutlet private weak var textLabelDay: UILabel!
     
    func update(date: Date) {
        textLabelDate.text = date.dateToString()
//        textLabelDay.text = day
    }

    
}
