
//
//  EnumerationsController.swift
//  SwiftGuide
//
//  Created by ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// Enumerations in Swift are much more flexible, and do not have to provide a value for each case of the enumeration. If a value (known as a “raw” value) is provided for each enumeration case, the value can be a string, a character, or a value of any integer or floating-point type.

import UIKit

class EnumerationsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        // MARK: Enumeration Syntax
        
        // 不像objc，他们的值并不是0、1、2...
        enum CompassPoint {
            case north
            case south
            case east
            case west
        }
        var directionToHead = CompassPoint.west
        directionToHead = .east
        
        
        //  MARK: Matching Enumeration Values with a Switch Statement
        directionToHead = .south
        switch directionToHead {
        case .north:
            print("Lots of planets have a north")
        case .south:
            print("Watch out for penguins")
        case .east:
             print("Where the sun rises")
        case .west:
            print("Where the skies are blue")
//        default:
//            <#code#>
        }
        
        // Swift 4.2 available
        // MARK: Iterating over Enumeration Cases
//        enum Beverage: CaseIterable {
//            case coffee, tea, juice
//        }
//        let numberOfChoices = Beverage.allCases.count
//        for beverage in Beverage.allCases {
//            print(beverage)
//        }
        
        
        // MARK: Associated Values
        enum Barcode {
            case upc(Int, Int, Int, Int)
            case qrCode(String)
        }
        var productBarcode = Barcode.upc(8, 85909, 51226, 3)
        productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
        
        switch productBarcode {
        case .upc(let numberSystem, let manufacturer, let product, let check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .qrCode(let productCode):
            print("QR code: \(productCode).")
        }
        
        switch productBarcode {
        case let .upc(numberSystem, manufacturer, product, check):
            print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
        case let .qrCode(productCode):
            print("QR code: \(productCode).")
        }
        
        
        // MARK: Raw Values
        enum ASCIIControlCharacter: Character {
            case tab = "\t"
            case lineFeed = "\n"
            case carriageReturn = "\r"
        }
        enum Planet: Int {
            case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
        }
        
        enum CompassPoint2: String {
            case north, south, east, west
        }
        let earthsOrder = Planet.earth.rawValue
        // earthsOrder is 3
        
        let sunsetDirection = CompassPoint2.west.rawValue
        // sunsetDirection is "west"
        
        
        // Initializing from a Raw Value
        let possiblePlanet = Planet(rawValue: 7)
        // possiblePlanet is of type Planet? and equals Planet.uranus
        
        let positionToFind = 11
        if let somePlanet = Planet(rawValue: positionToFind) {
            switch somePlanet {
            case .earth:
                print("Mostly harmless")
            default:
                print("Not a safe place for humans")
            }
        } else {
            print("There isn't a planet at position \(positionToFind)")
        }
        // Prints "There isn't a planet at position 11"
        
        
        // MARK: Recursive Enumerations 递归枚举
        enum ArithmeticExpression {
            case number(Int)
            indirect case addition(ArithmeticExpression, ArithmeticExpression)
            indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
        }
        
        // all
        indirect enum ArithmeticExpression2 {
            case number(Int)
            case addition(ArithmeticExpression2, ArithmeticExpression2)
            case multiplication(ArithmeticExpression2, ArithmeticExpression2)
        }
        
        
        let five = ArithmeticExpression.number(5)
        let four = ArithmeticExpression.number(4)
        let sum = ArithmeticExpression.addition(five, four)
        let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
        
        func evaluate(_ expression: ArithmeticExpression) -> Int {
            switch expression {
            case let .number(value):
                return value
            case let .addition(left, right):
                return evaluate(left) + evaluate(right)
            case let .multiplication(left, right):
                return evaluate(left) * evaluate(right)
            }
        }
        
        print(evaluate(product))
        // Prints "18"
    }

}
