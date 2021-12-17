//
//  Expenses+CoreDataClass.swift
//  Finance Life
//
//  Created by Vladislav Pashkevich on 18.12.21.
//
//

import Foundation
import CoreData

@objc(Expenses)
public class Expenses: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expenses> {
        return NSFetchRequest<Expenses>(entityName: "Expenses")
    }

    @NSManaged public var nameExpense: String
    @NSManaged public var value: Double
    @NSManaged public var date: Date

}
