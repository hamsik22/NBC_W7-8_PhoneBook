//
//  PhoneBook+CoreDataProperties.swift
//  NBC_W7-8_PhoneBook
//
//  Created by 황석현 on 12/11/24.
//
//

import Foundation
import CoreData


extension PhoneBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneBook> {
        return NSFetchRequest<PhoneBook>(entityName: "PhoneBook")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var profile: String?

}

extension PhoneBook : Identifiable {

}
