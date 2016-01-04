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

    // static is similar to class variable
    // http://stackoverflow.com/questions/24015207/class-variables-not-yet-supported
    // use dictionary with keys of a "stable" type, not subject to inaccuracy of Double
    static let tipRates = ["Low": 0.15, "Medium": 0.18, "High": 0.20]

    /**
     * amount plus tax, no tip
     */
    var baseAmountPlusTax: Double

    /**
     * tax rate as a fraction 0.00 - 1.0, not a percent
     * e.g 0.08 not 8%
     */
    var taxRateFractional: Double
    
    /**
     * base amount no tax, no tip
     * Computed property.
     * Doesn't store value, computes value each time it is called.
     * Uses instance variables baseAmountPlusTax and taxRateFractional.
     */
    var baseAmount: Double {
        get {
            return baseAmountPlusTax / (1 + taxRateFractional)
        }
    }
    
    init(baseAmountPlusTax: Double, taxRateFractional: Double) {
        self.baseAmountPlusTax = baseAmountPlusTax
        self.taxRateFractional = taxRateFractional
    }

    /**
     * @param tipRateFractional is tip rate as a fraction 0 - 1.0, not a percent
     * e.g. 0.15 not 15%
     * @return tuple (tipAmount, basePlusTaxPlusTip)
     * tip amount in currency unit e.g. $
     * basePlusTaxPlusTip is base amount + tax amount + tip amount. In currency unit e.g. $
     */
    func calcTipWithTipRateFractional(tipRateFractional: Double)
        -> (tipAmount: Double, basePlusTaxPlusTip: Double) {
            let tipAmount = (tipRateFractional * baseAmount)
            return (tipAmount, (baseAmountPlusTax + tipAmount))
    }

    // return dictionary containing key and value a tuple of Doubles
    func returnPossibleTips() -> [String: (tipAmount: Double, basePlusTaxPlusTip: Double)] {

        // instantiate empty dictionary
        var possibleTips = [String: (tipAmount:Double, basePlusTaxPlusTip:Double)] ()
        for tipRate in TipCalculatorModel.tipRates {
            possibleTips[tipRate.0] = calcTipWithTipRateFractional(tipRate.1)
        }
        return possibleTips
    }
    
}
