//
//  RateModel.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 10/21/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import Foundation

struct PrivatRatesResponseModel {
    
    let date: Date
    var exchangeRate: [PrivatAPIRateModel]
    
    
    enum CodingKeys: String, CodingKey {
        case date
        case exchangeRate
    }
    
    static var dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
}

extension PrivatRatesResponseModel: Decodable {
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dateString = try container.decode(String.self, forKey: .date)
        
        date = PrivatRatesResponseModel.dateFormatter.date(from: dateString)!
        
        let exchangeRateWithEmptyModels = try container.decode([PrivatAPIRateModel].self, forKey: .exchangeRate)
        
        exchangeRate = exchangeRateWithEmptyModels.filter({ $0.nameCurrency != "" && $0.buy != 0 && $0.sale != 0 })
        
        print(exchangeRate)
    }
}

struct PrivatAPIRateModel {
    var nameCurrency: String = ""
    var buy: Double = 0
    var sale: Double = 0
    
    enum CodingKeys: String, CodingKey {
        case nameCurrency = "currency"
        case buy = "purchaseRate"
        case sale = "saleRate"
    }
}

extension PrivatAPIRateModel: Decodable {
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let nameCurrency = try? values.decode(String.self, forKey: .nameCurrency) {
            self.nameCurrency = nameCurrency
        }
        
        if let buy = try? values.decode(Double.self, forKey: .buy) {
            self.buy = buy
        }
        
        if let sale = try? values.decode(Double.self, forKey: .sale) {
            self.sale = sale
        }
    }
}
