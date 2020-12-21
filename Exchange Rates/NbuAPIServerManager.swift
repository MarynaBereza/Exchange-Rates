//
//  NbuAPIServerManager.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 10/22/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import Foundation


class NbuAPIServerManager {
    
    static let dateFormatter: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        return dateFormatter
    }()
    
    static func fetchNBURatesWithDate (date: Date, completion: @escaping (_ rates: [NbuAPIRateModel]?, _ error: Error? ) -> ()) {
        
        let dateStr = dateFormatter.string(from: date)
        
        let nbuURL = URL(string:"https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?date=\(dateStr)&json")
        
        guard let urlNbu = nbuURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlNbu) {(data, response, error) in
            guard let data = data else {
                return
            }
            
            if let error = error {
                print(error)
                
            } else {
                
                let rates = try! JSONDecoder().decode(Array<NbuAPIRateModel>.self, from: data)
                
                DispatchQueue.main.async {
                    
                completion(rates, error)
                }
            }
        }
        task.resume()
    }
}
