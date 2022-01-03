//
//  DataForReport+CoreDataClass.swift
//  Finance Life
//
//  Created by Vladislav Pashkevich on 21.12.21.
//
//

import Foundation
import CoreData

@objc(DataForReport)
public class DataForReport: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataForReport> {
        return NSFetchRequest<DataForReport>(entityName: "DataForReport")
    }

    @NSManaged public var value: Double
    @NSManaged public var boolValue: Bool
    @NSManaged public var date: Date

}
