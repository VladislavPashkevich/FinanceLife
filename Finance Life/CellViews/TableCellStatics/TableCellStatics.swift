//
//  TableCellStatics.swift
//  Finance Life
//
//  Created by Vladislav Pashkevich on 23.12.21.
//

import Foundation
import UIKit

class TableCellCtatics: UITableViewCell {
    @IBOutlet private weak var gainLabel: UILabel!
    @IBOutlet private weak var expenceLabel: UILabel!
    @IBOutlet private weak var gainСurrency: UILabel!
    @IBOutlet private weak var expenceСurrency: UILabel!
    
    
    
    func update(selectCell: [String : Bool]) {
        for (key, value) in selectCell {
            if value == true {
                gainLabel.text = key
                //                expenceLabel.text = ""
                expenceLabel.isHidden = true
                expenceСurrency.isHidden = true
            } else {
                expenceLabel.text = key
                gainLabel.isHidden = true
                gainСurrency.isHidden = true
            }
        }
    }
}
