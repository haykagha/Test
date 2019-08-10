//
//  ViewController.swift
//  Calculator
//
//  Created by Vahan's MBP on 6/5/19.
//  Copyright © 2019 Vahan's MBP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstNumber: Double = 0
    var secondNumber: Double = 0
    var currentNumber: Double = 0
    var intermediateValue: String?
    var actionIs: String = " "
    var resultIs: String = " "
    var numberWithoutSpaces: Double = 0
    var statusOfAction: actionStatus = .isOff
    var statusOfNumbers: calculatedNumberIs = .first
    var commaStatus: actionStatus = .isOff
    var degreeOfTen: Double = 0
    
    @IBOutlet weak var `return`: UILabel!
    @IBOutlet var buttonsArray: [UIButton]!
    @IBOutlet var actionArray: [UIButton]!
    
    enum actionStatus {
        case isOn
        case isOff
    }
    
    enum calculatedNumberIs {
        case first
        case second
    }
    
    
    func newResult(number: Double) {
        switch `return`.text!.count {
            
        case 1...6:
            `return`.font = UIFont(name: `return`.font.fontName, size: 75)
        case 7:
            `return`.font = UIFont(name: `return`.font.fontName, size: 70)
        case 8...9:
            `return`.font = UIFont(name: `return`.font.fontName, size: 65)
        case 10:
            `return`.font = UIFont(name: `return`.font.fontName, size: 60)
        default:
            break
        }
        
        if `return`.text!.count <= 10 || statusOfAction == .isOn
        {
            removeSpaceBetweenElements()
            switch statusOfAction {
            case .isOn:
                `return`.text = " "
                statusOfAction = .isOff
                fallthrough
            case .isOff:
                if `return`.text == " " {
                    intermediateValue = "0"
                } else {
                    intermediateValue = `return`.text!
                }
                currentNumber = Double(intermediateValue!) ?? numberWithoutSpaces
                
                
                
                if commaStatus == .isOff {
                    if (`return`.text!.prefix(1) == "-" ) {
                        `return`.text = (NSNumber(value: 10 * currentNumber - number)).stringValue
                    } else {
                        `return`.text = (NSNumber(value: 10 * currentNumber + number)).stringValue
                    }
                    addSpaceBetweenElements()
                } else {
                    
                    if (`return`.text!.prefix(1) == "-" ) {
                        `return`.text = (NSNumber(value: currentNumber - number * 10 / pow(10,degreeOfTen))).stringValue
                    } else {
                        `return`.text = (NSNumber(value: currentNumber + number * 10 / pow(10,degreeOfTen))).stringValue
                    }
                }
                degreeOfTen += 1
                definesFirstAndSecondNumbers()
            }
        }
        
        
        
    }
    
    func addSpaceBetweenElements(){
        var char = Array(`return`.text!)
        if `return`.text!.count >= 4  {
            char.insert(" ", at: `return`.text!.count - 3)
            `return`.text! = String(char)
        }
        if `return`.text!.count >= 8  {
            char.insert(" ", at: `return`.text!.count - 7)
            `return`.text! = String(char)
        }
    }
    
    func removeSpaceBetweenElements(){
        if `return`.text!.contains(" ") {
            let intermediateArray = Array(`return`.text!).filter{$0 != " "}
            numberWithoutSpaces = Double(String(intermediateArray))!
        }
    }
    
    func definesFirstAndSecondNumbers(){
        switch statusOfNumbers {
        case .first:
            firstNumber = returnNumberWithoutSpaces()
        case .second:
            secondNumber = returnNumberWithoutSpaces()
        }
    }
    
    func noАction(){
        for action in actionArray {
            action.backgroundColor = #colorLiteral(red: 0.7520115972, green: 0.1245522872, blue: 0.8589860201, alpha: 1)
            action.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControl.State.normal)
        }
    }
    
    func returnNumberWithoutSpaces() -> Double {
        removeSpaceBetweenElements()
        let value =  Double(`return`.text!) ?? numberWithoutSpaces
        return value
    }
    
    
    @IBAction func pressedNumber(_ sender: UIButton) {
        
        switch  sender.currentTitle! {
        case "0":
            newResult(number: 0)
        case "1":
            newResult(number: 1)
        case "2":
            newResult(number: 2)
        case "3":
            newResult(number: 3)
        case "4":
            newResult(number: 4)
        case "5":
            newResult(number: 5)
        case "6":
            newResult(number: 6)
        case "7":
            newResult(number: 7)
        case "8":
            newResult(number: 8)
        case "9":
            newResult(number: 9)
        default:
            break
        }
    }
    
    @IBAction func pressedAction(_ sender: UIButton) {
        commaStatus = .isOff
        degreeOfTen = 0
        statusOfNumbers = .second
        statusOfAction = .isOn
        noАction()
        sender.setTitleColor(#colorLiteral(red: 0.7520115972, green: 0.1245522872, blue: 0.8589860201, alpha: 1), for: UIControl.State.normal)
        sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let action = sender.currentTitle!
        
        switch action {
        case "x":
            actionIs = "x"
        case "÷":
            actionIs = "÷"
        case "+":
            actionIs = "+"
        case "-":
            actionIs = "-"
        default:
            break
        }
        
    }
    
    @IBAction func equal(_ sender: UIButton) {
        noАction()
        statusOfAction = .isOff
        statusOfNumbers = .first
        switch actionIs {
        case "x":
            resultIs = (NSNumber(value:firstNumber * secondNumber)).stringValue
        case "÷":
            resultIs = (NSNumber(value:firstNumber / secondNumber)).stringValue
        case "+":
            resultIs = (NSNumber(value:firstNumber + secondNumber)).stringValue
        case "-":
            resultIs = (NSNumber(value:firstNumber - secondNumber)).stringValue
        default:
            break
        }
        
        if resultIs != " " {
            `return`.text = resultIs
            firstNumber = Double(resultIs)!
        }

        addSpaceBetweenElements()

        if resultIs.count > 10  {
            let eDegrees = resultIs.count - 1
            
            var tenDegrees = 1.0
            for _ in 1...eDegrees {
                tenDegrees *= 10
            }
            let value = Double(resultIs)! / tenDegrees
            let string = String(format: "%.2f", value)
            `return`.text! = string + "e\(eDegrees)"
            
        }
        
        if Double(resultIs)! > pow(10, 10){
            `return`.text! = "I love Swift"
        }
        
        
    }
    
    
    @IBAction func AC(_ sender: UIButton) {
        `return`.text = "0"
        commaStatus = .isOff
        degreeOfTen = 0
        noАction()
    }
    
    @IBAction func minusPlus(_ sender: UIButton) {
        `return`.text! = NSNumber(value: -returnNumberWithoutSpaces()).stringValue
        definesFirstAndSecondNumbers()
        addSpaceBetweenElements()
    }
    
    @IBAction func percent(_ sender: UIButton) {
        `return`.text! = String(returnNumberWithoutSpaces() / 100)
        definesFirstAndSecondNumbers()
    }
    
    @IBAction func addComma(_ sender: UIButton) {
        commaStatus = .isOn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonsArray.forEach {
            $0.layer.cornerRadius = 0.5 * $0.bounds.size.width;
            $0.clipsToBounds = true
            if $0.currentTitle! == "0"{
                $0.layer.cornerRadius = 0.25 * $0.bounds.size.width
            }
        }
    }
    
}



