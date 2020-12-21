//
//  PrivatRates+CoreDataProperties.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 11/16/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//
//

import Foundation
import CoreData


extension PrivatRates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrivatRates> {
        return NSFetchRequest<PrivatRates>(entityName: "PrivatRates")
    }

    @NSManaged public var date: Date?
    @NSManaged public var rates: NSSet?

}

// MARK: Generated accessors for rates
extension PrivatRates {

    @objc(addRatesObject:)
    @NSManaged public func addToRates(_ value: PrivatRate)

    @objc(removeRatesObject:)
    @NSManaged public func removeFromRates(_ value: PrivatRate)

    @objc(addRates:)
    @NSManaged public func addToRates(_ values: NSSet)

    @objc(removeRates:)
    @NSManaged public func removeFromRates(_ values: NSSet)

}
