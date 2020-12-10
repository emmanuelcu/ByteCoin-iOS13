//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(error: Error)
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
}


struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "0FC24114-7A68-4882-98C2-DC700986CA4C"
    
    func getCoinPrice(selectedCurrency: String){
        let urlString = "\(baseURL)/\(selectedCurrency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func performRequest(with urlString: String){
        //        1. Create the URL
        if let url = URL(string: urlString){
            //        2. Create the URL session
            let session = URLSession(configuration: .default)
            //        3. Give the session a task
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let coin = self.parseJSON(safeData){
                        self.delegate?.didUpdateCoin(self, coin: coin)
                    }
                }
                
            }
            //        4. Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let curren = decodedData.asset_id_base
            let currenEx = decodedData.asset_id_quote
            let rate = decodedData.rate
            
            let coin = CoinModel(currecy: curren, currencyExchange: currenEx, rate: rate )
            print(decodedData.rate)
            print(coin.rateToString)
            
            return coin
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
    
}
