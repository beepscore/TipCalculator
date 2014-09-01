//
//  ViewController.swift
//  TipCalculator
//
//  Created by Steve Baker on 8/31/14.
//  Copyright (c) 2014 Beepscore LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // ! implies variables are optional, implicitly unwrapped
    // app will crash if they aren't set before use
    @IBOutlet var totalTextField: UITextField!
    @IBOutlet var taxPctSlider: UISlider!
    @IBOutlet var taxPctLabel: UILabel!
    @IBOutlet var resultsTextView: UITextView!

    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // AnyObject can be any type, similar to Objective C type "id"
    @IBAction func calculateTapped(sender : AnyObject) {
    }

    @IBAction func taxPercentageChanged(sender : AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }

    @IBAction func viewTapped(sender : AnyObject) {
    }

    func refreshUI() {
        totalTextField.text = String(format: "%0.2f", tipCalc.total)
        taxPctSlider.value = Float(tipCalc.taxPct) * 100
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        resultsTextView.text = ""
    }
}
