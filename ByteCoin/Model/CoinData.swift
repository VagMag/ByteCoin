//
//  CoinData.swift
//  ByteCoin
//
//  Created by Maxim Vagin on 27.04.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    //для чего пишем кодэбэл?
    let asset_id_quote: String
    let rate: Double
}
