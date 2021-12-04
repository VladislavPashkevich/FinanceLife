//
//  Accounts+CoreDataClass.swift
//  Finance Life
//
//  Created by Vladislav Pashkevich on 4.12.21.
//
//

import Foundation
import CoreData

@objc(Accounts)
public class Accounts: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Accounts> {
        return NSFetchRequest<Accounts>(entityName: "Accounts")
    }

    @NSManaged public var nameAccount: String
    @NSManaged public var value: Double


}
