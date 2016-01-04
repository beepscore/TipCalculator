//
//  TipCalculatorTests.swift
//  TipCalculatorTests
//
//  Created by Steve Baker on 8/31/14.
//  Copyright (c) 2014 Beepscore LLC. All rights reserved.
//

import UIKit
import XCTest

class TipCalculatorTests: XCTestCase {

    func testCalcTipWithTipRateFractional() {
        let testTotal = 29.37
        let tipCalculator = TipCalculatorModel(total: testTotal, taxRateFractional: 0.10)

        let actual = tipCalculator.calcTipWithTipRateFractional(0.12)
        XCTAssertEqualWithAccuracy(3.204, actual.tipAmount, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(32.574, actual.basePlusTaxPlusTip, accuracy: 0.001)
    }

    func testReturnPossibleTips() {
        let testTotal = 29.37
        let tipCalculator = TipCalculatorModel(total: testTotal, taxRateFractional: 0.10)

        let actual = tipCalculator.returnPossibleTips()
        XCTAssertEqualWithAccuracy(4.005, actual["Low"]!.tipAmount, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(33.375, actual["Low"]!.basePlusTaxPlusTip, accuracy: 0.001)

        XCTAssertEqualWithAccuracy(4.806, actual["Medium"]!.tipAmount, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(34.176, actual["Medium"]!.basePlusTaxPlusTip, accuracy: 0.001)

        XCTAssertEqualWithAccuracy(5.34, actual["High"]!.tipAmount, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(34.71, actual["High"]!.basePlusTaxPlusTip, accuracy: 0.001)
    }
    
}
