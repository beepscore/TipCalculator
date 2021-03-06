//
//  ViewController.swift
//  TipCalculator
//
//  Created by Steve Baker on 8/31/14.
//  Copyright (c) 2014 Beepscore LLC. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIKit.UIViewController, UITableViewDataSource {

    // ! implies variables are optional, implicitly unwrapped
    // app will crash if they aren't set before use
    @IBOutlet var totalTextField: UITextField!
    @IBOutlet var taxPctSlider: UISlider!
    @IBOutlet var taxPctLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    
    let tipCalc = TipCalculatorModel(baseAmountPlusTax: 33.25, taxRateFractional: 0.06)

    var possibleTips = Dictionary<String, (tipAmount: Double, basePlusTaxPlusTip: Double)>()

    var sortedKeys:[String] = []

    // MARK: - lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -

    /**
     * @param sender AnyObject can be any type, similar to Objective C type "id"
     */
    @IBAction func calculateTapped(sender : AnyObject) {

        // Currently Swift String class doesn't have a method to convert to Double
        // Use as NSString to convert Swift String to NSString
        // then call NSString doubleValue
        tipCalc.baseAmountPlusTax = Double((totalTextField.text! as NSString).doubleValue)

        possibleTips = tipCalc.returnPossibleTips()

        let tipRatesKeys = TipCalculatorModel.tipRates.keys

        sortedKeys = tipRatesKeys.sort( {
            (firstKey, secondKey) -> Bool in
                return TipCalculatorModel.tipRates[firstKey] < TipCalculatorModel.tipRates[secondKey] })

        tableView.reloadData()
    }

    @IBAction func taxPercentageChanged(sender : AnyObject) {
        tipCalc.taxRateFractional = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }

    @IBAction func viewTapped(sender : AnyObject) {
        // call resignFirstResponder to dismiss keyboard
        totalTextField.resignFirstResponder()
    }

    func refreshUI() {
        totalTextField.text = String(format: "%0.2f", tipCalc.baseAmountPlusTax)
        // http://stackoverflow.com/questions/24029163/finding-index-of-character-in-swift-string?rq=1
        //let baseAmountPlusTax = "\(tipCalc.baseAmountPlusTax)"
        // TODO depends upon locale, could be , !
        //var rangeOfSeparator = text.rangeOfString(".")

        //let total : NSString = NSString(format: "%0.2f", tipCalc.baseAmountPlusTax)
        //let total = NSString(format: "%0.2f", tipCalc.baseAmountPlusTax)
        //totalTextField.text = (total as String)

        taxPctSlider.value = Float(tipCalc.taxRateFractional) * 100.0
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
    }

    // MARK: - UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)

        let keyForRow = sortedKeys[indexPath.row]
        let tipRateFractional = TipCalculatorModel.tipRates[keyForRow]
        let tipAmount = possibleTips[keyForRow]!.tipAmount
        let basePlusTaxPlusTip = possibleTips[keyForRow]!.basePlusTaxPlusTip

        cell.textLabel?.text = "\(Int(tipRateFractional! * 100)) %:"
        cell.detailTextLabel?.text = String(format:"Tip: $%-.2f, Total: $%0.2f", tipAmount, basePlusTaxPlusTip)
        return cell
    }

}
