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

    func testCalcTipWithTipPct() {
        let testTotal = 29.37
        let tipCalculator = TipCalculatorModel(total: testTotal, taxRateFractional: 0.10)

        let actual = tipCalculator.calcTipWithTipPct(0.12)
        XCTAssertEqualWithAccuracy(3.204, actual.tipAmt, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(32.574, actual.total, accuracy: 0.001)
    }

    func testReturnPossibleTips() {
        let testTotal = 29.37
        let tipCalculator = TipCalculatorModel(total: testTotal, taxRateFractional: 0.10)

        let actual = tipCalculator.returnPossibleTips()
        // [18: (4.59704347826087, 33.9670434782609),
        //  15: (3.83086956521739, 33.2008695652174),
        //  20: (5.10782608695652, 34.4778260869565)]
        XCTAssertEqualWithAccuracy(4.806, actual[18]!.tipAmt, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(34.176, actual[18]!.total, accuracy: 0.001)

        XCTAssertEqualWithAccuracy(4.005, actual[15]!.tipAmt, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(33.375, actual[15]!.total, accuracy: 0.001)

        XCTAssertEqualWithAccuracy(5.34, actual[20]!.tipAmt, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(34.71, actual[20]!.total, accuracy: 0.001)
    }
    
}
