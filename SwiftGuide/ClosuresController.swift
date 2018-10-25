//
//  ClosuresController.swift
//  SwiftGuide
//
//  Created by ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

//  Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages

// names.sorted { (s1: String, s2: String) -> Bool in
//    return s1 > s2
// }

// 如果一个值会被闭包改变，闭包是持有的引用
// 如果一个值不会被闭包改变，或者在闭包创建后不会改变，Swift 可能会改为捕获并保存一份对值的拷贝。Swift 也会负责被捕获变量的所有内存管理工作，包括释放不再需要的变量。

// 闭包相比于objc的Block更加简洁，而且花样更多；Python也有闭包，意思也是一样的

import UIKit

class ClosuresController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        
        // .Global functions are closures that have a name and do not capture any values.
        // .Nested functions are closures that have a name and can capture values from their enclosing function.
        // .Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.

        // Swift’s closure expressions have a clean, clear style, with optimizations that encourage brief, clutter-free syntax in common scenarios. These optimizations include:
        // .Inferring parameter and return value types from context
        // .Implicit returns from single-expression closures
        // .Shorthand argument names
        // .Trailing closure syntax

        
        // MARK: Closure Expressions
        
        // 以系统的sorted(by:)使用为例
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        func backward(_ s1: String, _ s2: String) -> Bool {
            return s1 > s2
        }
        var reversedNames = names.sorted(by: backward)
        // reversedNames is equal to ["Ewa", "Daniella", "Chris", "Barry", "Alex"]
        
        
        // Closure Expression Syntax
        // { (parameters) -> return type in
        //    statements
        // }
        
        reversedNames = names.sorted { (s1: String, s2: String) -> Bool in
            return s1 > s2
        }
        // on a single line
        reversedNames = names.sorted { (s1: String, s2: String) -> Bool in return s1 > s2 }
        
        // Inferring Type From Context
        reversedNames = names.sorted { (s1: String, s2: String) in
            return s1 > s2
        }
        reversedNames = names.sorted { (s1, s2) in
            return s1 > s2
        }
        reversedNames = names.sorted { s1, s2 in
            return s1 > s2
        }
        
        
        // Implicit Returns from Single-Expression Closures
        reversedNames = names.sorted{ s1, s2 in s1 > s2}
        
        
        // Shorthand Argument Names
        // $0 and $1 refer to the closure’s first and second String arguments.
        names.sorted(by: { $0 > $1 })
        
        
        // Operator Methods
        reversedNames = names.sorted(by: >)
        
        
        // MARK: Trailing Closures
        // If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead. A trailing closure is written after the function call’s parentheses, even though it is still an argument to the function. When you use the trailing closure syntax, you don’t write the argument label for the closure as part of the function call.
        // 把函数作为一个参数和这个闭包的样子很像
        func someFunctionThatTakesAClosure(closure: () -> Void) {
            // function body goes here
        }
        
        // Here's how you call this function without using a trailing closure:
        someFunctionThatTakesAClosure(closure: {
            // closure's body goes here
        })
        
        // Here's how you call this function with a trailing closure instead:
        someFunctionThatTakesAClosure() {
            // trailing closure's body goes here
        }
        // as a trailing closure:
        // reversedNames = names.sorted() { $0 > $1 }
        names.sorted() {
            $0 > $1
        }
        
        // If a closure expression is provided as the function or method’s only argument, you do not need to write a pair of parentheses ()
        reversedNames = names.sorted { $0 > $1 }

        // Trailing closures are most useful when the closure is sufficiently long that it is not possible to write it inline on a single line
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        let strings = numbers.map { (number) -> String in
            var number = number
            var output = ""
            repeat {
                output = digitNames[number % 10]! + output
                print(output)
                number /= 10
            } while number > 0
            return output
        }
        // ["OneSix", "FiveEight", "FiveOneZero"]
        
        
        // MARK: Capturing Values
        // A closure can capture constants and variables from the surrounding context in which it is defined. The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists.
        // the simplest form of a closure that can capture values is a nested function
        // 函数作为返回值
        func makeIncrementer(forIncrement amount: Int) -> () -> Int {
            var runningTotal = 0
            // TODO: Capturing by reference ensures that runningTotal and amount do not disappear when the call to makeIncrementer ends, and also ensures that runningTotal is available the next time the incrementer function is called.
            func incrementer() -> Int {
                runningTotal += amount;
                return runningTotal
            }
            return incrementer
        }
        // As an optimization, Swift may instead capture and store a copy of a value if that value is not mutated by a closure, and if the value is not mutated after the closure is created.
        // Swift also handles all memory management involved in disposing of variables when they are no longer needed.
        let incrementByTen = makeIncrementer(forIncrement: 10)
        incrementByTen()
        // returns a value of 10
        incrementByTen()
        // returns a value of 20
        incrementByTen()
        // returns a value of 30
        
        // If you create a second incrementer, it will have its own stored reference to a new, separate runningTotal variable:
        let incrementBySeven = makeIncrementer(forIncrement: 7)
        incrementBySeven()
        // returns a value of 7
        
        incrementByTen()
        // returns a value of 40
        
        
        
        // MARK: Closures Are Reference Types
        // Whenever you assign a function or a closure to a constant or a variable, you are actually setting that constant or variable to be a reference to the function or closure. In the example above, it is the choice of closure that incrementByTen refers to that is constant, and not the contents of the closure itself.
        
        // This also means that if you assign a closure to two different constants or variables, both of those constants or variables refer to the same closure.
        let alsoIncrementByTen = incrementByTen
        alsoIncrementByTen()
        // returns a value of 50
        
        
        
        // MARK: Escaping Closures 逃逸闭包 指的是闭包逃逸出函数的执行约束，很类似完成回调
        // A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. When you declare a function that takes a closure as one of its parameters, you can write @escaping before the parameter’s type to indicate that the closure is allowed to escape.
        var completionHandlers: [ () -> Void] = []
        func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
            completionHandlers.append(completionHandler)
        }
        
        // Marking a closure with @escaping means you have to refer to self explicitly within the closure. For example
        func someFunctionWithNonescapingClosure(closure: () -> Void) {
            closure()
        }

        class SomeClass {
            var completionHandlers: [ () -> Void] = []
            func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
                completionHandlers.append(completionHandler)
            }

            // Marking a closure with @escaping means you have to refer to self explicitly within the closure. For example
            func someFunctionWithNonescapingClosure(closure: () -> Void) {
                closure()
            }
            
            var x = 10
            func doSomething() {
                someFunctionWithEscapingClosure { self.x = 100 }
                someFunctionWithNonescapingClosure { x = 200 }
            }
        }
        let instance = SomeClass()
        instance.doSomething()
        print(instance.x)
        // Prints "200"
        
        completionHandlers.first?()
        print(instance.x)
        
        
        
        // MARK: Autoclosures
        // An autoclosure is a closure that is automatically created to wrap an expression that’s being passed as an argument to a function. It doesn’t take any arguments, and when it’s called, it returns the value of the expression that’s wrapped inside of it. This syntactic convenience lets you omit braces around a function’s parameter by writing a normal expression instead of an explicit closure.
        
        // An autoclosure lets you delay evaluation,because the code inside isn’t run until you call the closure
        
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)
        // Prints "5"
        
        let customerProvider = { customersInLine.remove(at: 0) }
        print(customersInLine.count)
        // Prints "5"
        
        print("Now serving \(customerProvider())!")
        // Prints "Now serving Chris!" 延时到这里执行
        print(customersInLine.count)
        // Prints "4"
        
        
        // You get the same behavior of delayed evaluation when you pass a closure as an argument to a function.
        // customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
        func serve(customer customerProvider: () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serve(customer: { customersInLine.remove(at: 0) })
        serve { () -> String in
            customersInLine.remove(at: 0)
        }
        // Prints "Now serving Alex!"
        
        // customersInLine is ["Ewa", "Barry", "Daniella"]
        // 你可以将该函数当作接受 String 类型参数（而非闭包）的函数来调用。customerProvider 参数将自动转化为一个闭包，因为该参数被标记了 @autoclosure 特性
        func serve2(customer customerProvider: @autoclosure () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serve2(customer: customersInLine.remove(at: 0))
        // Prints "Now serving Ewa!"
        
        // customersInLine is ["Barry", "Daniella"]
        var customerProviders: [() -> String] = []
        func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
            customerProviders.append(customerProvider)
        }
        collectCustomerProviders(customersInLine.remove(at: 0))
        collectCustomerProviders(customersInLine.remove(at: 0))
        
        print("Collected \(customerProviders.count) closures.")
        // Prints "Collected 2 closures."
        for customerProvider in customerProviders {
            print("Now serving \(customerProvider())!")
        }
        // Prints "Now serving Barry!"
        // Prints "Now serving Daniella!"
    }


}
