//
//  PrivatRequest.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 10/21/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import Foundation


class PrivatAPIServerManager {
    
    
    static var dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyy"
        
        return formatter
    }()
    
    
    static func fetchPrivatRatesToDate(date: Date, completion: @escaping(_ privatRateModel: [PrivatAPIRateModel]?, _ error: Error?) -> ()) {

        let dateString = dateFormatter.string(from: date)
        let privatURL = URL(string:"https://api.privatbank.ua/p24api/exchange_rates?json&date=\(dateString)")
        
        guard let url = privatURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            guard let data = data else {
                
                return
            }

            if let error = error {
                
                print(error)
            } else {
                
                let rates = try! JSONDecoder().decode(PrivatRatesResponseModel.self, from: data)
                
                DispatchQueue.main.async {
                    
                    completion(rates.exchangeRate, error)
                }
            }
        }
        task.resume()
    }
}
