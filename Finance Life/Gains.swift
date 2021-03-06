//
//  Gains+CoreDataClass.swift
//  Finance Life
//
//  Created by Vladislav Pashkevich on 18.12.21.
//
//

import Foundation
import CoreData

@objc(Gains)
public class Gains: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Gains> {
        return NSFetchRequest<Gains>(entityName: "Gains")
    }

    @NSManaged public var value: Double
    @NSManaged public var date: Date
    @NSManaged public var nameGain: String
}
