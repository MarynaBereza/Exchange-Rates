//
//  NbuRates+CoreDataProperties.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 11/16/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//
//

import Foundation
import CoreData


extension NbuRates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NbuRates> {
        return NSFetchRequest<NbuRates>(entityName: "NbuRates")
    }

    @NSManaged public var date: Date?
    @NSManaged public var rates: NSOrderedSet?

}

// MARK: Generated accessors for rates
extension NbuRates {

    @objc(insertObject:inRatesAtIndex:)
    @NSManaged public func insertIntoRates(_ value: NbuRate, at idx: Int)

    @objc(removeObjectFromRatesAtIndex:)
    @NSManaged public func removeFromRates(at idx: Int)

    @objc(insertRates:atIndexes:)
    @NSManaged public func insertIntoRates(_ values: [NbuRate], at indexes: NSIndexSet)

    @objc(removeRatesAtIndexes:)
    @NSManaged public func removeFromRates(at indexes: NSIndexSet)

    @objc(replaceObjectInRatesAtIndex:withObject:)
    @NSManaged public func replaceRates(at idx: Int, with value: NbuRate)

    @objc(replaceRatesAtIndexes:withRates:)
    @NSManaged public func replaceRates(at indexes: NSIndexSet, with values: [NbuRate])

    @objc(addRatesObject:)
    @NSManaged public func addToRates(_ value: NbuRate)

    @objc(removeRatesObject:)
    @NSManaged public func removeFromRates(_ value: NbuRate)

    @objc(addRates:)
    @NSManaged public func addToRates(_ values: NSOrderedSet)

    @objc(removeRates:)
    @NSManaged public func removeFromRates(_ values: NSOrderedSet)

}
