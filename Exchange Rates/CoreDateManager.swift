//
//  CoreDateManager.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 11/3/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class  CoreDateManager {
    
    static let dateFormattre = DateFormatter()
    
    static var coreDataStack = CoreDataStack.instance
    
    // MARK: - Privat
    static func createPrivatRateObjectWith() -> PrivatRate {
        
        return createObjectWithEntityName(entityName:"PrivatRate") as! PrivatRate
    }
    
    static func createPrivatRatesObjectWith() -> PrivatRates {
        
        return createObjectWithEntityName(entityName:"PrivatRates") as! PrivatRates
    }
    
    // MARK: - NBU
    static func createNbuRateObjectWith() -> NbuRate {
        
        return createObjectWithEntityName(entityName:"NbuRate") as! NbuRate
    }
    
    static func createNbuRatesObjectWith() -> NbuRates {
        
        return createObjectWithEntityName(entityName:"NbuRates") as! NbuRates
    }
    
    
    // MARK: - General
    static func createObjectWithEntityName (entityName: String)  -> NSManagedObject {
        
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: coreDataStack.persistentContainer.viewContext) else {
            fatalError("Cound not find entity description")
        }
        
        let object = NSManagedObject(entity: entity, insertInto: coreDataStack.persistentContainer.viewContext)
        
        return object
    }
    
    
    static func getPrivatRatesWith(entityName: String, date: Date) -> [PrivatRate] {
        var privatRatesArray = [PrivatRate]()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)

        let filterPredicate = NSPredicate(format: "date == %@", date as NSDate)
        
        fetchRequest.predicate = filterPredicate
        
        do {
            let results = try coreDataStack.persistentContainer.viewContext.fetch(fetchRequest)
            
            let privarRates = results as! [PrivatRates]
            
            privarRates.first?.rates?.forEach({ (rateObj) in
                let rate = rateObj as! PrivatRate
                privatRatesArray.append(rate)
            })
            privatRatesArray = self.sortRatesFrom(array: privatRatesArray)
            
            print("RESULTS \(results.count)")
            return privatRatesArray
            
        } catch {
            print("Error")
        }
        return []
    }
    
    
    static func getNbuRatesWith(entityName: String, date: Date) -> [NbuRate] {
        var nbuRatesArray = [NbuRate]()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        let filterPredicate = NSPredicate(format: "date == %@", date as NSDate)
        
        fetchRequest.predicate = filterPredicate
        
        do {
            let results = try coreDataStack.persistentContainer.viewContext.fetch(fetchRequest)
            
            let nbuRates = results as! [NbuRates]
            
            nbuRates.first?.rates?.forEach({ (rateObj) in
                let rate = rateObj as! NbuRate
                nbuRatesArray.append(rate)
            })
            nbuRatesArray = nbuRatesArray.sorted { (obj1, obj2) -> Bool in
                return obj1.shortName! < obj2.shortName!
            }
            
            return nbuRatesArray
            
        } catch {
            print("Error")
        }
        return []
    }
    
    
    // MARK: - Method Sorting Array
    static func sortRatesFrom(array: [PrivatRate]) -> [PrivatRate]{
          
          var sortedArrayRates = [PrivatRate]()
          
          for  value in array {
              
              if value.name == "USD"  || value.name == "EUR" ||  value.name == "RUB" {
                  sortedArrayRates.insert(value, at: 0)
                  
              } else {
                  sortedArrayRates.insert(value, at: (sortedArrayRates.isEmpty ? 0 : sortedArrayRates.count))
              }
          }
          return sortedArrayRates
      }
    
}
