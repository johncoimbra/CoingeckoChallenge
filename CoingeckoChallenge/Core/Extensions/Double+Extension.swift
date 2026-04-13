//
//  Double+Extension.swift
//  CoingeckoChallenge
//
//  Created by John Allen Santos Coimbra on 12/04/26.
//

import Foundation

extension Double {
    func toAbbreviated() -> String {
        if self >= 1_000_000_000_000 {
            return String(format: "$%.2fT", self / 1_000_000_000_000)
        }
        
        if self >= 1_000_000_000 {
            return String(format: "$%.2fB", self / 1_000_000_000)
        }
        
        if self >= 1_000_000 {
            return String(format: "$%.2fM", self / 1_000_000)
        }
        
        return String(format: "$%.2f", self)
    }
    
    func toCurrencyString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: self)) ?? "$\(self)"
    }
}
