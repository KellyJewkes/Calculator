//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Kelly Jewkes on 2/26/18.
//  Copyright © 2018 LightWing. All rights reserved.
//

import UIKit

//MARK: - Operations Enum
enum Operation:String {
    case Add = "+"
    case Subtract = "-"
    case Divide = "/"
    case Multiply = "*"
    case NULL = "Null"
}

class CalculatorViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: - Variables
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation:Operation = .NULL
    
    
    //MARK: - Outlets
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var convertedFrom: UIPickerView!
    @IBOutlet weak var convertedTo: UIPickerView!
    
    @IBOutlet weak var outputLabel: UILabel!
    
    
    //MARK: - Arrays
    let measurments = ["Inches", "Feet", "Centimeters", "Meters"]
    let measurments2 = ["Inches", "Feet", "Centimeters", "Meters"]
    
    let inch = "Inches"
    let foot = "Feet"
    let cm = "Centimeters"
    let m = "Meters"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertedFrom.delegate = self
        convertedFrom.dataSource = self
        convertedTo.delegate = self
        convertedTo.dataSource = self
        outputLabel.text = "0"
    }
    
    
    //MARK: - Picker Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == convertedFrom {
            return measurments.count
        } else {
            return measurments2.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == convertedFrom {
            return measurments[row]
        } else {
            return measurments2[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == convertedFrom {
            return fromLabel.text = measurments[row]
        } else {
            if pickerView == convertedTo {
                return toLabel.text = measurments2[row]
            }
        }
        toLabel.text = measurments[row]
        fromLabel.text = measurments2[row]
        
    }
    
    @IBAction func convertTapped(_ sender: UIButton) {
        

        var currentNum = outputLabel.text
        if fromLabel.text == toLabel.text {
            return
        } else if fromLabel.text == inch && toLabel.text == foot {
            let intoInt = (outputLabel.text! as NSString) .doubleValue
            outputLabel.text = "\(intoInt / 12)"
            
        }else if fromLabel.text == inch && toLabel.text == cm {
            let intoInt = (outputLabel.text! as NSString) .doubleValue
            outputLabel.text = "\(intoInt * 2.54)"
        
        }else if fromLabel.text == inch && toLabel.text == m {
            let intoInt = (outputLabel.text! as NSString) .doubleValue
            outputLabel.text = "\(intoInt * 0.0254)"
        }
    
        
    }
    //use tags for each number... one action!//
    @IBAction func numberTapped(_ sender: UIButton) {
        if runningNumber.count <= 9 {
            runningNumber += "\(sender.tag)"
            outputLabel.text = runningNumber
        }
    }
    @IBAction func allClearTapped(_ sender: UIButton) {
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .NULL
        outputLabel.text = "0"
        
    }
    @IBAction func dotTapped(_ sender: UIButton) {
        if runningNumber.count <= 8 {
            runningNumber += "."
            outputLabel.text = runningNumber
            
        }
    }
    @IBAction func equalTapped(_ sender: UIButton) {
        operation(operation: currentOperation)
    }
    @IBAction func addTapped(_ sender: UIButton) {
        operation(operation: .Add)
    }
    @IBAction func subtractTapped(_ sender: UIButton) {
        operation(operation: .Subtract)
    }
    @IBAction func multiplyTapped(_ sender: UIButton) {
        operation(operation: .Multiply)
    }
    @IBAction func divideTapped(_ sender: UIButton) {
        operation(operation: .Divide)
    }
    
    func operation(operation: Operation) {
        if currentOperation != .NULL {
            if runningNumber != "" {
                rightValue = runningNumber
                runningNumber = ""
                
                if currentOperation == .Add {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }else if currentOperation == .Subtract {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                }else if currentOperation == .Multiply {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                }else if currentOperation == .Divide {
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                }
                leftValue = result
                if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double(result)!))"
                }
                outputLabel.text = result
            }
            currentOperation = operation
        }else{
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
}





