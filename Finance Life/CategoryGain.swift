//
//  CategoryGain+CoreDataClass.swift
//  Finance Life
//
//  Created by Vladislav Pashkevich on 7.12.21.
//
//

import Foundation
import CoreData

@objc(CategoryGain)
public class CategoryGain: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryGain> {
        return NSFetchRequest<CategoryGain>(entityName: "CategoryGain")
    }

    @NSManaged public var gain: String
}
