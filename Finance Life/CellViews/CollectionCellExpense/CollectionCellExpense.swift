//
//  CollectionCellExpense.swift
//  Finance Life
//
//  Created by Vladislav Pashkevich on 7.12.21.
//

import Foundation
import UIKit

class CollectionCellExpense: UICollectionViewCell {
    @IBOutlet private weak var ExpenseName: UILabel!
    @IBOutlet weak var buttonDelete: UIButton!
    
    
    func update(text: String) {
        ExpenseName.text = text
    }
    
    @objc func buttonIsHidden() {
        buttonDelete.isHidden = false
    }
    
    @IBAction func deleteExpense() {
        
    }

    
}
