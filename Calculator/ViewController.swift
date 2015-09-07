//
//  ViewController.swift
//  Calculator
//
//  Created by Adam Michael on 9/6/15.
//  Copyright © 2015 Adam LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var userIsTypingANumber = false
    var operandStack = Array<Double>()
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text! = "\(newValue)"
        }
    }

    @IBAction func enter() {
        userIsTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsTypingANumber = true
        }
    }

    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsTypingANumber { enter() }
        switch operation {
        case "×": performOperation2 { $1 * $0 }
        case "÷": performOperation2 { $1 / $0 }
        case "+": performOperation2 { $1 + $0 }
        case "−": performOperation2 { $1 - $0 }
        case "√": performOperation { sqrt($0) }
        default: break
        }
    }
    
    func performOperation2(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
}

