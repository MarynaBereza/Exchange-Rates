//
//  NbuRate+CoreDataProperties.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 11/16/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//
//

import Foundation
import CoreData


extension NbuRate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NbuRate> {
        return NSFetchRequest<NbuRate>(entityName: "NbuRate")
    }

    @NSManaged public var longName: String?
    @NSManaged public var rate: Float
    @NSManaged public var shortName: String?
    @NSManaged public var nbuRate: NbuRates?

}
