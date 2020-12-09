//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Emmanuel Cuevas on 09/12/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let currecy: String
    let currencyExchange: String
    let rate: Double
    
    var rateToString:String{
        return String(format: "%.2f", rate)
    }
}
