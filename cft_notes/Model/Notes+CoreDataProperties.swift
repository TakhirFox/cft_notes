//
//  Notes+CoreDataProperties.swift
//  cft_notes
//
//  Created by Zakirov Tahir on 18.03.2021.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var contentNote: String?
    @NSManaged public var dateNote: String?
    @NSManaged public var titleNote: String?
    @NSManaged public var createAt: Date?

}

extension Notes : Identifiable {

}
