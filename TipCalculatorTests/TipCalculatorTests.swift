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
    
    func testReturnPossibleTips() {
        let testTotal = 29.37
        let tipCalculator = TipCalculatorModel(total: testTotal, taxPct: 15)
        // [18: (0.3304125, 29.7004125), 15: (0.27534375, 29.64534375), 20: (0.367125, 29.737125)]
        let actual = tipCalculator.returnPossibleTips()
        print("actual: ", actual)
        XCTAssertEqualWithAccuracy(29.70, actual[18]!.total, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(0.330, actual[18]!.tipAmt, accuracy: 0.001)

        XCTAssertEqualWithAccuracy(29.645, actual[15]!.total, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(0.2753, actual[15]!.tipAmt, accuracy: 0.001)

        XCTAssertEqualWithAccuracy(29.737, actual[20]!.total, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(0.367, actual[20]!.tipAmt, accuracy: 0.001)
    }
    
}
