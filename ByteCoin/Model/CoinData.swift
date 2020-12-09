//
//  CoinData.swift
//  ByteCoin
//
//  Created by Emmanuel Cuevas on 09/12/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}

