//
//  NbuAPIRateModel.swift
//  Exchange Rates
//
//  Created by Maryna Bereza on 10/22/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import Foundation


struct NbuAPIRateModel {

    let txtName: String
    let xxxName: String
    let rate: Float
    
    enum CodingKeys: String, CodingKey {
        case txtName = "txt"
        case xxxName = "cc"
        case rate
    }
}

extension NbuAPIRateModel: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        txtName = try values.decode(String.self, forKey: .txtName)
        
        xxxName = try values.decode(String.self, forKey: .xxxName)
        
        rate = try values.decode(Float.self, forKey: .rate)
    }
}

