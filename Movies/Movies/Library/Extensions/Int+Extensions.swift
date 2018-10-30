//
//  Int+Extensions.swift
//  Movies
//
//  Created by Lorrayne Paraiso  on 29/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

extension Int {
    func toUSCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en-US")
        formatter.numberStyle = .currency
        
        var retValue = ""
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            retValue = formattedTipAmount
        }
        
        return retValue
    }
    
    func toRuntime() -> String {
        return "\(self/60)h \((self)%60)m"
    }
}
