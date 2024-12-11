//
//  PhoneBook+CoreDataClass.swift
//  NBC_W7-8_PhoneBook
//
//  Created by 황석현 on 12/11/24.
//
//

import Foundation
import CoreData

@objc(PhoneBook)
public class PhoneBook: NSManagedObject {
    public static let className = "PhoneBook"
    public enum Key {
        static let name = "name"
        static let phoneNumber = "phoneNumber"
        static let profile = "profile"
    }

}
