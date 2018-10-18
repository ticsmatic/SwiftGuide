//
//  TeeBasicsViewController.swift
//  swiftTour
//
//  Created by Ticsmatic on 2018/10/17.
//  Copyright © 2018年 ticsmatic. All rights reserved.

// Tuples
// enable you to create and pass around groupings of values. You can use a tuple to return multiple values from a function as a single compound value

// Optional
// Using optionals is similar to using nil with pointers in Objective-C, they’re at the heart of many of Swift’s most powerful features.

// Swift is a type-safe language, which means the language helps you to be clear about the types of values your code can work with


import UIKit

class TheBasicsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        // Constants and Variables
        // Declaring Constants and Variables
        let maximumNumberOfLoginAttempts = 10
        var currentLoginAttempt = 0
        var x = 0.0, y = 0.0, z = 0.0
        
        // Type Annotations
        var welcomeMessage: String
        
        var red, green, blue: Double
        
        // Naming Constants and Variables
        // Constant and variable names can contain almost any character, including Unicode characters:
        let π = 3.14159
        let 你好 = "你好世界"
        let 🐶🐮 = "dogcow"
        print("ddadad \(你好) \(🐶🐮)")
        
        var friendlyWelcome = "Hello!"
        friendlyWelcome = "Bonjour!"
        
        // Printing Constants and Variables
        print(friendlyWelcome)

        
        
        // Comments
        // This is a comment.
        
        /* This is also a comment
         but is written over multiple lines. */
        
        // 乱几把嵌套也支持的
        /* This is the start of the first multiline comment.
         /* This is the second, nested multiline comment. */
         This is the end of the first multiline comment. */
        
        
        
        // Semicolons
        // However, semicolons are required if you want to write multiple separate statements on a single line:
        let cat = "🐱"; print(cat)
        // Prints "🐱"
        
        
        
        // Integers
        // UInt8 Int32 UInt32 UInt64
        var myInt: UInt32 = 11
        
        // Integer Bounds
        let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
        let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8 2的8次方=256
        
        //Int
        // On a 32-bit platform, Int is the same size as Int32.
        // On a 64-bit platform, Int is the same size as Int64.
        
        // Floating-Point Numbers
        // Double represents a 64-bit floating-point number.
        // Float represents a 32-bit floating-point number.
        
        
        
        // Type Safety and Type Inference
        // Because Swift is type safe, it performs type checks when compiling your code and flags any mismatched types as errors. This enables you to catch and fix errors as early as possible in the development process.
        //  If you don’t specify the type of value you need, Swift uses type inference to work out the appropriate type. Type inference enables a compiler to deduce the type of a particular expression automatically when it compiles your code, simply by examining the values you provide.
        
        let pi = 3.14159
        // pi is inferred to be of type Double
        // Swift always chooses Double (rather than Float) when inferring the type of floating-point numbers.
        
        let anotherPi = 3 + 0.14159
        // anotherPi is also inferred to be of type Double

        
        
        // Numeric Literals 数值型字面量
        let decimalInteger = 17
        let binaryInteger = 0b10001       // 17 in binary notation
        let octalInteger = 0o21           // 17 in octal notation
        let hexadecimalInteger = 0x11     // 17 in hexadecimal notation
        
        // 1.25e2 means 1.25 x 102, or 125.0.
        // 1.25e-2 means 1.25 x 10-2, or 0.0125.
        let paddedDouble = 000123.456     // Print 123.456
        let oneMillion = 1_000_000        // Print 1000000
        let justOverOneMillion = 1_000_000.000_000_1
        
        // Numeric Type Conversion 数值类型转换
        // An Int8 constant or variable can store numbers between -128 and 127, whereas a UInt8 constant or variable can store numbers between 0 and 255
        let twoThousand: UInt16 = 2_000
        let one: UInt8 = 1
        // They can’t be added together directly, because they’re not of the same type. Instead, this example calls UInt16(one) to create a new UInt16 initialized with the value of one
        let twoThousandAndOne = twoThousand + UInt16(one)
        
        // Integer and Floating-Point Conversion
        let three = 3
        let pointOneFourOneFiveNine = 0.14159
        let pi2 = Double(three) + pointOneFourOneFiveNine
        
        let integerPi = Int(pi2)
        // integerPi equals 3, and is inferred to be of type Int
        
        
        
        // Type Aliases
        // Type aliases define an alternative name for an existing type. You define type aliases with the typealias keyword.
        typealias AudioSample = UInt16
        var maxAmplitudeFound = AudioSample.min
        // maxAmplitudeFound is now 0

        

        // Booleans
        // true false
        let orangesAreOrange = true
        let turnipsAreDelicious = false
        // if 只能用booleans值
        
        
        
        // Tuples 元组
        // Tuples group multiple values into a single compound value 多个值复合成一个值
        let http404Error = (404, "Not Found")
        // http404Error is of type (Int, String), and equals (404, "Not Found")
        
        // 拆解
        // You can decompose a tuple’s contents into separate constants or variables, which you then access as usual:
        let (statusCode, statusMessage) = http404Error
        print("The status code is \(statusCode)")
        // Prints "The status code is 404"
        print("The status message is \(statusMessage)")
        // Prints "The status message is Not Found"
        let (justTheStatusCode, _) = http404Error
        print("The status code is \(justTheStatusCode)")
        // Prints "The status code is 404"
        
        // Alternatively, access the individual element values in a tuple using index numbers
        print("The status code is \(http404Error.0)")
        // Prints "The status code is 404"
        print("The status message is \(http404Error.1)")
        // Prints "The status message is Not Found"
        print((1, "wxq").1)
        
        let http200Status = (statusCode: 200, description: "OK")
        print("The status code is \(http200Status.statusCode)")
        // Prints "The status code is 200"
        print("The status message is \(http200Status.description)")
        // Prints "The status message is OK"
        
        // 用于函数返回值
        // Tuples are particularly useful as the return values of functions
    }
    
    
}
