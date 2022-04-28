//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation



struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "A6A6A594-7D4B-4CB5-86E5-2C7E3F396FB7"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    func getCoinPrice(for currency:String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        //создаем url. URL изначально имеет опциональный тип, поэтому делаем optional binding
        if let url = URL(string: urlString) {
            // создаем сесси для URL
            let session = URLSession(configuration: .default)
            //ставим задачу task, complitionHandler имеет тип данных функцию. ее можно передать именно функцией или клоужером прямо в task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(coinData: safeData)
                }
                
                
            }
            //запускаем запрос
            task.resume()
        }
    }
    func parseJSON(coinData: Data) -> Double? {
        //создаем декодер
        let decoder = JSONDecoder()
        //запускаем декодер
        //.self добавлено для того, чтобы обозначить CoinData как Тип данных
        //т.к метод декодирования может вызвать ошибку, то хкод просит добавит try
        //чтобы обработать ошибки нужно заключить метод do
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let price = decodedData.rate
            print(decodedData.asset_id_quote)
            print(decodedData.rate)
            return price
        } catch {
            return nil
        }
        
    }
}
