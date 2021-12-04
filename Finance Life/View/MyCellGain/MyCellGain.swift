//
//  MyCellGain.swift
//  Finance Life
//
//  Created by Vladislav Pashkevich on 4.12.21.
//

import Foundation
import UIKit

class MyCellGain: UITableViewCell {
    @IBOutlet private weak var textLabelName: UILabel!
    @IBOutlet private weak var textLabelValue: UILabel!
    
    func update(text: String, value: Int) {
        textLabelName.text = text
        textLabelValue.text = String(value)
    }

    
}
