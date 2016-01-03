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
        let tipCalculator = TipCalculatorModel(total: testTotal, taxPct: 0.15)

        let actual = tipCalculator.calcTipWithTipPct(0.12)
        XCTAssertEqualWithAccuracy(3.065, actual.tipAmt, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(32.4347, actual.total, accuracy: 0.001)
    }

    func testReturnPossibleTips() {
        let testTotal = 29.37
        let tipCalculator = TipCalculatorModel(total: testTotal, taxPct: 0.15)

        let actual = tipCalculator.returnPossibleTips()
        // [18: (4.59704347826087, 33.9670434782609),
        //  15: (3.83086956521739, 33.2008695652174),
        //  20: (5.10782608695652, 34.4778260869565)]
        XCTAssertEqualWithAccuracy(4.597, actual[18]!.tipAmt, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(33.967, actual[18]!.total, accuracy: 0.001)

        XCTAssertEqualWithAccuracy(3.8309, actual[15]!.tipAmt, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(33.201, actual[15]!.total, accuracy: 0.001)

        XCTAssertEqualWithAccuracy(5.1078, actual[20]!.tipAmt, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(34.4778, actual[20]!.total, accuracy: 0.001)
    }
    
}
