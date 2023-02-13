

import Foundation

class CoinDetails {
    
    var coinName: String
    var coinPrice: String
    var coinChangePrice: String
    var intCoin: Double
    
    init(coinName: String, coinPrice: String, coinChangePrice: String, intCoin: Double) {
        self.coinName = coinName
        self.coinPrice = coinPrice
        self.coinChangePrice = coinChangePrice
        self.intCoin = intCoin
    }
    
}
