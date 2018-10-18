//
//  BasicOperatorsController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/18.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//  https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html

//  +, -, *, /, % += ... && ?? ?:

//  这一部分大多都源于C语言的结构，没有大的变化。除了多了一个??，以及shell中的区间运算符

import UIKit

class BasicOperatorsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
        // MARK: Assignment Operator
        // =
        let b = 10
        var a = 5
        a = b
        // a is now equal to 10
        let (x, y) = (1, 2)
        

        
        // MARK: Arithmetic Operators
        // +, -, *, /
        "hello," + "wxq"         // equals "hello, wxq"
        
        
        // Remainder Operator
        // %
        9 % 4    // equals 1
        
        
        // Unary Minus Operator
        // 负号
        let three = 3
        let minusThree = -three       // minusThree equals -3
        let plusThree = -minusThree   // plusThree equals 3, or "minus minus three"
        
        
        // Unary Plus Operator
        // 正号
        let minusSix = -6
        let alsoMinusSix = +minusSix  // alsoMinusSix equals -6
        
        

        // MARK: Compound Assignment Operators
        var a2 = 1
        a2 += 2
        // a is now equal to 3
        
        
        
        // MARK: Comparison Operators
        1 == 1   // true because 1 is equal to 1
        2 != 1   // true because 2 is not equal to 1
        2 > 1    // true because 2 is greater than 1
        1 < 2    // true because 1 is less than 2
        1 >= 1   // true because 1 is greater than or equal to 1
        2 <= 1   // false because 2 is not less than or equal to 1
        let name = "world"
        if name == "world" {
            print("hello, world")
        } else {
            print("I'm sorry \(name), but I don't recognize you")
        }
        // Prints "hello, world", because name is indeed equal to "world".
        
        // compare two tuples
        (1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" are not compared
        (3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
        (4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"
        // ("blue", false) < ("purple", true)  // Error because < can't compare Boolean values
        
        
        
        // MARK: Ternary Conditional Operator 三目运算
        let contentHeight = 40
        let hasHeader = true
        let rowHeight = contentHeight + (hasHeader ? 50 : 20)
        // rowHeight is equal to 90
        
        
        
        // MARK: Nil-Coalescing Operator ??默认值
        // (a ?? b)
        // unwraps an optional a if it contains a value, or returns a default value b if a is nil.The expression a is always of an optional type. The expression b must match the type that is stored inside a
        let defaultColorName = "red"
        var userDefinedColorName: String?   // defaults to nil
        
        var colorNameToUse = userDefinedColorName ?? defaultColorName
        // userDefinedColorName is nil, so colorNameToUse is set to the default of "red"
        
        userDefinedColorName = "green"
        colorNameToUse = userDefinedColorName ?? defaultColorName
        // userDefinedColorName is not nil, so colorNameToUse is set to "green"
        print(colorNameToUse)
        
        
        
        // MARK: Range Operators 区间运算符
        // Closed Range Operator
        // 1 2 3 4 5
        for index in 1...5 {
            print("\(index) times 5 is \(index * 5)")
        }
        
        
        // Half-Open Range Operator
        let names = ["Anna", "Alex", "Brian", "Jack"]
        let count = names.count
        // 0 1 2 3
        for i in 0..<count {
            print("Person \(i) is called \(names[i])")
        }

        
        // One-Sided Ranges
        // 2 3
        for name in names[2...] {
            print(name)
        }
        // Brian
        // Jack
        
        // 0 1 2
        for name in names[...2] {
            print(name)
        }
        // Anna
        // Alex
        // Brian
        
        // 0 1
        for name in names[..<2] {
            print(name)
        }
        // Anna
        // Alex

        
        let range = ...5
        print(range)        // Prints PartialRangeThrough<Int>(upperBound: 5)
        range.contains(7)   // false
        range.contains(4)   // true
        range.contains(-1)  // true
        
        
        
        // MARK: Logical Operators
        // Swift supports the three standard logical operators found in C-based languages:
        // Logical NOT (!a)
        // Logical AND (a && b)
        // Logical OR (a || b)
        
        // Logical NOT Operator
        let allowedEntry = false
        if !allowedEntry {
            print("ACCESS DENIED")
        }
        // Prints "ACCESS DENIED"
        
        
        // Logical AND Operator
        let enteredDoorCode = true
        let passedRetinaScan = false
        if enteredDoorCode && passedRetinaScan {
            print("Welcome!")
        } else {
            print("ACCESS DENIED")
        }
        // Prints "ACCESS DENIED"

        
        // Logical OR Operator
        let hasDoorKey = false
        let knowsOverridePassword = true
        if hasDoorKey || knowsOverridePassword {
            print("Welcome!")
        } else {
            print("ACCESS DENIED")
        }
        // Prints "Welcome!"
        
        
        // Combining Logical Operators
        if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
            print("Welcome!")
        } else {
            print("ACCESS DENIED")
        }
        // Prints "Welcome!"
        
        
        // Explicit Parentheses 使用括号
        // It’s sometimes useful to include parentheses when they’re not strictly needed, to make the intention of a complex expression easier to read.
        if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
            print("Welcome!")
        } else {
            print("ACCESS DENIED")
        }
        // Prints "Welcome!"

    }


}
