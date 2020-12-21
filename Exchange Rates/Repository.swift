//
//  Repository.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 11/3/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import Foundation
import UIKit


class Repository {
    // MARK: - get Currency Rates
    static func getPrivatCurrencyRatesDataBy (date: Date, completion: @escaping ([PrivatRate]) -> Void) {
        
         let ratesArray = CoreDateManager.getPrivatRatesWith(entityName: "PrivatRates", date: date)
        
        if ratesArray.isEmpty {
            
            getPrivatRatesFromServerWith(date: date, completion: completion)
            print("SERVER Privat")
        } else {
            print("CORE DATA Privat")
            completion(ratesArray)
        }
    }
    
    static func getNbuCurrencyRatesDataBy (date: Date, completion: @escaping ([NbuRate]) -> Void) {
        
        let nbuRatesArray = CoreDateManager.getNbuRatesWith(entityName: "NbuRates", date: date)
        
        if nbuRatesArray.isEmpty {
            
            getNbuRatesFromServer(date: date, complation: completion)
            print("SERVER NBU")
        } else {
            print("CORE DATA NBU")
            completion(nbuRatesArray)
        }
    }
    
    
    
    // MARK: - Get Privat Rates from Server
    static private func getPrivatRatesFromServerWith(date: Date, completion:  @escaping ([PrivatRate]) -> Void) {
        
        //        var privatRatesArray = [PrivatRate]()
        
        PrivatAPIServerManager.fetchPrivatRatesToDate(date: date) {(privarRates, error) in
            
            guard let privatRates = privarRates else {return}
            
            let privatRatesModel = CoreDateManager.createPrivatRatesObjectWith()
            
            for rate in privatRates {
                let privatRate = CoreDateManager.createPrivatRateObjectWith()
                
                privatRate.name = rate.nameCurrency
                privatRate.buy = rate.buy
                privatRate.sale = rate.sale
                
                privatRatesModel.date = date
                privatRatesModel.addToRates(privatRate)
            }
            
            let privatRatesArray = sortRatesFrom(array: Array(privatRatesModel.rates!) as! [PrivatRate])
            completion(privatRatesArray)
        }
    }
    
    // MARK: - Get NBU Rates from Server
    
    static private func getNbuRatesFromServer ( date: Date, complation: @escaping ([NbuRate]) -> ()) {
        NbuAPIServerManager.fetchNBURatesWithDate(date: date) { (nbuRates, error) in
            
            guard let nbuRates = nbuRates else {
                return
            }
            
            let nbuRatesModel = CoreDateManager.createNbuRatesObjectWith()
            
            for rate in nbuRates {
                
                let nbuRateModel = CoreDateManager.createNbuRateObjectWith()
                
                nbuRateModel.shortName = rate.xxxName
                nbuRateModel.longName = rate.txtName
                nbuRateModel.rate = rate.rate
                
                nbuRatesModel.addToRates(nbuRateModel)
                nbuRatesModel.date = date
            }
            
            let nbuRatesArray = Array(nbuRatesModel.rates!) as! [NbuRate]
            
            let sortedNbuRates = nbuRatesArray.sorted { (obj1, obj2) -> Bool in
                return obj1.shortName! < obj2.shortName!
            }
            complation(sortedNbuRates)
        }
    }
    
    
    // MARK: - Method Sort Privat Array
    static func sortRatesFrom(array: [PrivatRate]) -> [PrivatRate]{
     
        var sortedArrayRates = [PrivatRate]()
          
        let sortedArray =  array.sorted { (name1, name2) -> Bool in
            
           return name1.name! > name2.name!
        }
        
          for  value in sortedArray {
              
              if  value.name == "EUR" ||  value.name == "RUB" || value.name == "USD"  {
                  sortedArrayRates.insert(value, at: 0)
                  
              } else {
                  sortedArrayRates.insert(value, at: (sortedArrayRates.isEmpty ? 0 : sortedArrayRates.count))
              }
          }
          return sortedArrayRates
      }
}
