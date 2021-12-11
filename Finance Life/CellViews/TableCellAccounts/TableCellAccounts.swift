//
//  TableCellAccounts.swift
//  Finance Life
//
//  Created by Vladislav Pashkevich on 9.12.21.
//

import Foundation
import UIKit

class TableCellAccounts: UITableViewCell {
    @IBOutlet private weak var nameForAccount: UILabel!
    @IBOutlet private weak var valueForAccount: UILabel!
    
    func update(name: String, value: String) {
        nameForAccount.text = name
        valueForAccount.text = value
    }

    
}
