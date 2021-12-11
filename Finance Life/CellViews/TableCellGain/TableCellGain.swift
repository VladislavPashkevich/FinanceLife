//
//  CollectionCellExpense.swift
//  Finance Life
//
//  Created by Vladislav Pashkevich on 5.12.21.
//

import Foundation
import UIKit

class TableCellGain: UITableViewCell {
    @IBOutlet private weak var gainName: UILabel!
    
    func update(text: String) {
        gainName.text = text
    }

    
}
