//
//  ExtensionsController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// 协议，pretty important
/*
Extensions add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you do not have access to the original source code (known as retroactive modeling). Extensions are similar to categories in Objective-C. (Unlike Objective-C categories, Swift extensions do not have names.)

Extensions in Swift can:

Add computed instance properties and computed type properties
Define instance methods and type methods
Provide new initializers
Define subscripts
Define and use new nested types
Make an existing type conform to a protocol
In Swift, you can even extend a protocol to provide implementations of its requirements or add additional functionality that conforming types can take advantage of. For more details, see Protocol Extensions.

NOTE

Extensions can add new functionality to a type, but they cannot override existing functionality.
*/

import UIKit

class ExtensionsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // MARK: Extension Syntax
        // Declare extensions with the extension keyword:
        // An extension can extend an existing type to make it adopt one or more protocols.
        
        // MARK: Computed Properties
        let oneInch = 25.4.mm
        print("One inch is \(oneInch) meters")
        // Prints "One inch is 0.0254 meters"
        let threeFeet = 3.ft
        
        let aMarathon = 42.km + 195.m
        print("A marathon is \(aMarathon) meters long")
        // Prints "A marathon is 42195.0 meters long"
        
        // NOTE 扩展是不能加属性存储的，和ojc的原则一直
        // Extensions can add new computed properties, but they cannot add stored properties, or add property observers to existing properties.
        
        
        
        // MARK: Initializers
        // Extensions can add new initializers to existing types.
        let defaultRect = Rect()
        let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                                  size: Size(width: 5.0, height: 5.0))
        
        let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                              size: Size(width: 3.0, height: 3.0))


        
        // MARK: Methods
        // Extensions can add new instance methods and type methods to existing types.
        2.repetitions {
            print("☁️☁️")
        }
        
        
        // Mutating Instance Methods
        // Instance methods added with an extension can also modify (or mutate) the instance itself. Structure and enumeration methods that modify self or its properties must mark the instance method as mutating, just like mutating methods from an original implementation.
        var someInt = 3
        someInt.square()
        // someInt is now 9

        
        
        // MARK: Subscripts
        // Extensions can add new subscripts to an existing type.
        746381295[0]
        // returns 5
        746381295[1]
        // returns 9
        
        
        
        // MARK: Nested Types
        // Extensions can add new nested types to existing classes, structures, and enumerations:
        func printIntegerKinds(_ numbers: [Int]) {
            for number in numbers {
                switch number.kind {
                case .negative:
                    print("- ", terminator: "")
                case .zero:
                    print("0 ", terminator: "")
                case .positive:
                    print("+ ", terminator: "")
                }
            }
            print("")
        }
        printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
        // Prints "+ + - 0 - 0 + "
    }
}

// MARK: - Extensions can add new nested types to existing classes, structures, and enumerations:
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var  kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x < 0:
            return .negative
        default:
            return .positive
        }
    }
    
}

// MARK: - Int类型传递一个小数点个数
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

// MARK: - 修改instance
extension Int {
    mutating func square() -> Void {
        self = self * self
    }
}

// MARK: - 通过扩展的方式，增加一个方法
extension Int {
    func repetitions(task: () -> Void) -> Void {
        for _ in 0..<self {
            task()
        }
    }
}

// MARK: - 通过扩展的方式，增加一个初始化方法
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - size.width / 2
        let originY = center.y - size.height / 2
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

// MARK: - 把数据换算成米
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_1000.0 }
    var ft: Double { return self / 3.28084 }
}
