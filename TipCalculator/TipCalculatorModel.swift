//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Steve Baker on 8/31/14.
//  Copyright (c) 2014 Beepscore LLC. All rights reserved.
//

import Foundation
import UIKit

class TipCalculatorModel {
    var total: Double
    var taxRateFractional: Double
    
    // computed property, doesn't store value, computes it each time.
    var subtotal: Double {
        get {
            return total / (taxRateFractional + 1)
        }
    }
    
    init(total: Double, taxRateFractional: Double) {
        self.total = total
        self.taxRateFractional = taxRateFractional
    }

    /**
     * @param tipPct is fractional amount e.g specify 0.15 for 15% tip
     */
    func calcTipWithTipPct(tipPct: Double) -> (tipAmt: Double, total: Double) {
        let tipAmt = subtotal * tipPct
        let finalTotal = total + tipAmt
        return (tipAmt, finalTotal)
    }

    // return dictionary with key Int and value tuple of Doubles
    func returnPossibleTips() -> [Int: (tipAmt: Double, total: Double)] {
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        //let possibleTipsExplicit : [Double] = [0.15, 0.18, 0.20]

        // instantiate empty dictionary
        var retval = Dictionary<Int, (tipAmt:Double, total:Double)> ()

        for possibleTip in possibleTipsInferred {
            let intPct = Int(possibleTip*100)
            retval[intPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
    }
    
}
