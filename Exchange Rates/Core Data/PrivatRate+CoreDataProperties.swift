//
//  PrivatRate+CoreDataProperties.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 11/16/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//
//

import Foundation
import CoreData


extension PrivatRate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrivatRate> {
        return NSFetchRequest<PrivatRate>(entityName: "PrivatRate")
    }

    @NSManaged public var buy: Double
    @NSManaged public var name: String?
    @NSManaged public var sale: Double
    @NSManaged public var privatRate: PrivatRates?

}
