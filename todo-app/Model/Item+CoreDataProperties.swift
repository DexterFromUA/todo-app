//
//  Item+CoreDataProperties.swift
//  todo-app
//
//  Created by Dexter on 30.04.2021.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var completed: Bool

}

extension Item : Identifiable {

}
