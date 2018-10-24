//
//  FunctionsController.swift
//  SwiftGuide
//
//  Created by ticsmatic on 2018/10/24.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// Every function in Swift has a type, as parameter, as return value

// tuple return value

// nested functions

import UIKit

class FunctionsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        
        // pass functions as parameters to other functions, and to return functions from functions. Functions can also be written within other functions to encapsulate useful functionality within a nested function scope.
        func greeting(person: String, alreadyGreeted: Bool) -> String {
            return "Hello" + person + "!"
        }
        greeting(person: "Anna", alreadyGreeted: false)
        
        // MARK: Function Parameters and Return Values
        // Functions with Multiple Return Values
        func minMax(array: [Int]) -> (min: Int, max: Int)? {
            if array.isEmpty { return nil }
            var min = array[0]
            var max = array[0]
            for i in array {
                if i < min {
                    min = i
                } else if i > max {
                    max = i
                }
            }
            return (min, max)
        }
        print(minMax(array: [1, 2, 3, 10, 88, 82, 71]))
        print([1, 2, 3, 10, 88, 82, 71].max())
        
        if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
            print("min is \(bounds.min) and max is \(bounds.max)")
        }
        // Prints "min is -6 and max is 109"
        
        
        // MARK: Function Argument Labels and Parameter Names
        
        // Specifying Argument Labels
        func someFunction(argumentLabel parameterName: Int) {
            // In the function body, parameterName refers to the argument value
            // for that parameter.
        }
        
        // Omitting Argument Labels
        func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
            // In the function body, firstParameterName and secondParameterName
            // refer to the argument values for the first and second parameters.
        }
//        someFunction(1, secondParameterName: 2)
        
        // Default Parameter Values
        func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
            // If you omit the second argument when calling this function, then
            // the value of parameterWithDefault is 12 inside the function body.
        }
        someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
        someFunction(parameterWithoutDefault: 4) // parameterWithDefault is 12
        
        
        // Variadic Parameters ... 可变参数
        func arithmeticMean(_ numbers: [Double]) -> Double {
            var total: Double = 0
            for number in numbers {
               total += number
            }
            return total / Double(numbers.count)
        }
        arithmeticMean([1, 2, 3, 4, 5])
        // returns 3.0, which is the arithmetic mean of these five numbers
        
        
        // In-Out Parameters 参数指针传递
        // you can’t change the value of a parameter. If you want a function to modify a parameter’s value, and you want those changes to persist after the function call has ended, define that parameter as an in-out parameter instead.
        func swapTwoInts(_ a: inout Int, _ b: inout Int) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
        // Prints "someInt is now 107, and anotherInt is now 3"
        
        
        // MARK: Function Types
        // The type of both of these functions is (Int, Int) -> Int.
        func addTwoInts(_ a: Int, _ b: Int) -> Int {
            return a + b
        }
        
        // Using Function Types
        // 方法指针对象
        var mathFunction: (Int, Int) -> Int = addTwoInts
        print("Result: \(mathFunction(2, 3))")
        // Prints "Result: 5"
        
        // Function Types as Parameter Types
        func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
            print("Result: \(mathFunction(a, b))")
        }
        printMathResult(addTwoInts, 1, 2)
        
        // Function Types as Return Types
        func stepForward(_ input: Int) -> Int {
            return input + 1
        }
        func stepBackward(_ input: Int) -> Int {
            return input - 1
        }
        func chooseStepFunction(backward: Bool) -> (Int) -> Int {
            if backward {
                return stepBackward
            } else {
                return stepForward
            }
        }
        
        
        // MARK: Nested Functions 方法内部定义方法
        // You can also define functions inside the bodies of other functions, known as nested functions.
        func chooseStepFunction2(backward: Bool) -> (Int) -> Int {
            func stepForward2(input: Int) -> Int { return input + 1 }
            func stepBackward2(input: Int) -> Int { return input - 1 }
            return backward ? stepBackward2 : stepForward2
        }
        var currentValue = -4
        let moveNearerToZero = chooseStepFunction2(backward: currentValue > 0)
    }
}
