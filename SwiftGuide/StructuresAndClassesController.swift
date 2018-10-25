//
//  StructuresAndClassesController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// 在swift中，结构体和类是十分的相似

// 不像objc的结构体（CGRect等），swift的结构体可以直接赋值

// Structures and Enumerations Are Value Types. integers, floating-point numbers, Booleans, strings, arrays and dictionaries—are value types, and are implemented as structures behind the scenes
// 以上是对字符串、数组、字典的“拷贝”行为的描述。在你的代码中，拷贝行为看起来似乎总会发生。然而，Swift 在幕后只在绝对必要时才执行实际的拷贝

import UIKit

class StructuresAndClassesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        // Structures and classes are general-purpose, flexible constructs that become the building blocks of your program’s code. You define properties and methods to add functionality to your structures and classes using the same syntax you use to define constants, variables, and functions.
        
        // MARK: Comparing Structures and Classes
        
        // Structures and classes in Swift have many things in common. Both can:
        // Define properties to store values
        // Define methods to provide functionality
        // Define subscripts to provide access to their values using subscript(下标) syntax
        // Define initializers to set up their initial state
        // Be extended to expand their functionality beyond a default implementation
        // Conform to protocols to provide standard functionality of a certain kind

        // Classes have additional capabilities that structures don’t have:
        // Inheritance enables one class to inherit the characteristics of another.
        // Type casting enables you to check and interpret the type of a class instance at runtime.
        // Deinitializers enable an instance of a class to free up any resources it has assigned.
        // Reference counting allows more than one reference to a class instance.
        
        
        // Definition Syntax
        struct Resolution {
            var width = 0
            var height = 0
        }
        class VideoMode {
            var resolution = Resolution()
            var interlaced = false
            var frameRate = 0.0
            var name: String?
        }
        
        
        // Structure and Class Instances
        let someResolution = Resolution()
        let someVideoMode = VideoMode()
        
        
        // Accessing Properties
        someResolution.height
        print("The width of someVideoMode is \(someVideoMode.resolution.width)")
        // Prints "The width of someVideoMode is 0"
        
        someVideoMode.resolution.width = 1024
        print("The width of someVideoMode is \(someVideoMode.resolution.width)")
        // Prints "The width of someVideoMode is 1024"
        
        
        // Memberwise Initializers for Structure Types
        let vga = Resolution(width: 640, height: 480)
        
        
        
        // MARK: Structures and Enumerations Are Value Types
        // A value type is a type whose value is copied when it’s assigned to a variable or constant, or when it’s passed to a function.
        
        // You’ve actually been using value types extensively throughout the previous chapters. In fact, all of the basic types in Swift—integers, floating-point numbers, Booleans, strings, arrays and dictionaries—are value types, and are implemented as structures behind the scenes.
        let hd = Resolution(width: 1920, height: 1080)
        
        enum CompassPoint {
            case north, south, east, west
            mutating func turnNorth() {
                self = .north
            }
        }
        var currentDirection = CompassPoint.west
        let rememberedDirection = currentDirection
        currentDirection.turnNorth()
        // Prints "The current direction is north"
        // Prints "The remembered direction is west"
        
        
        
        // MARK: Classes Are Reference Types
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        // tenEighty is now 30.0
        
        
        // Identity Operators
        // Because classes are reference types, it’s possible for multiple constants and variables to refer to the same single instance of a class behind the scenes
        // It can sometimes be useful to find out whether two constants or variables refer to exactly the same instance of a class. To enable this, Swift provides two identity operators:
        if tenEighty === alsoTenEighty {
            print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
        }
        

        // Pointers
        // is similar to a pointer in C, but isn’t a direct pointer to an address in memory, and doesn’t require you to write an asterisk (*) to indicate that you are creating a reference. Instead, these references are defined like any other constant or variable in Swift
    }

}
