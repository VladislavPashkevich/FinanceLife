//
//  CategoryExpense+CoreDataClass.swift
//  Finance Life
//
//  Created by Vladislav Pashkevich on 7.12.21.
//
//

import Foundation
import CoreData

@objc(CategoryExpense)
public class CategoryExpense: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryExpense> {
        return NSFetchRequest<CategoryExpense>(entityName: "CategoryExpense")
    }

    @NSManaged public var expense: String
}
