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
    
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    var possibleTips = Dictionary<Int, (tipAmt: Double, total: Double)>()
    var sortedKeys:[Int] = []

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

        // Currently Swift String class doesn't have a method to convert to Double
        // Use as NSString to convert Swift String to NSString
        // then call NSString doubleValue
        tipCalc.total = Double((totalTextField.text! as NSString).doubleValue)

        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = Array(possibleTips.keys).sort()
        tableView.reloadData()
    }

    @IBAction func taxPercentageChanged(sender : AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }

    @IBAction func viewTapped(sender : AnyObject) {
        // call resignFirstResponder to dismiss keyboard
        totalTextField.resignFirstResponder()
    }

    func refreshUI() {
        totalTextField.text = String(format: "%0.2f", tipCalc.total)
        // http://stackoverflow.com/questions/24029163/finding-index-of-character-in-swift-string?rq=1
        //String total = "\(tipCalc.total)"
        // TODO depends upon locale, could be , !
        //var rangeOfSeparator = text.rangeOfString(".")

        //let total : NSString = NSString(format: "%0.2f", tipCalc.total)
        //let total = NSString(format: "%0.2f", tipCalc.total)
        //totalTextField.text = (total as String)

        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
    }

    // MARK UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        let tipPct = sortedKeys[indexPath.row]

        let tipAmt = possibleTips[tipPct]!.tipAmt
        let total = possibleTips[tipPct]!.total

        cell.textLabel?.text = "\(tipPct)%:"
        cell.detailTextLabel?.text = String(format:"Tip: $%-.2f, Total: $%0.2f", tipAmt, total)
        return cell
    }

}
