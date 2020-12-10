//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CoinViewController: UIViewController  {
    
    var coinManager = CoinManager()
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
}

//MARK: - UIPickerViewDelegate

extension CoinViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    //    This function asks for the number or columns that should be shown in the view.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        print(coinManager.currencyArray[row])
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(selectedCurrency: selectedCurrency)
    }
}

//MARK: - CoinManagerDelegate

extension CoinViewController: CoinManagerDelegate{
    
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coin.rateToString
            self.currencyLabel.text = coin.currencyExchange
        }
    }
    
    func didFailWithError(error: Error){
        print(error)
    }
    
}





