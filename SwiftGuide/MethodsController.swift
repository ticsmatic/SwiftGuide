//
//  MethodsController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// structures and enumerations can define methods in Swift is a major difference from C and Objective-C

// mutating 可变

// 在swift中，类型方法用static关键字，很似静态方法, 可以类方法和实例方法共同修改实例属性的值

import UIKit

class MethodsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        // MARK: Instance Methods
        // Instance methods are functions that belong to instances of a particular class, structure, or enumeration
        class Counter {
            var count = 0
            func increment() {
                count += 1
            }
//            func increment() {
//                self.count += 1
//            }
            func increment(by amout: Int) {
                count += amout
            }
            func reset() {
                count = 0
            }
        }
        let counter = Counter()
        counter.increment()
        counter.increment(by: 5)
        counter.reset()
        
        
        // The self Property
        // Every instance of a type has an implicit property called self, which is exactly equivalent to the instance itself. You use the self property to refer to the current instance within its own instance methods.
//        func increment() {
//            self.count += 1
//        }
        // 在实例方法中，我们通常不必要写self关键字来访问每个属性
        // In practice, you don’t need to write self in your code very often. If you don’t explicitly write self
        
        
        // Modifying Value Types from Within Instance Methods
        // Structures and enumerations are value types. By default, the properties of a value type cannot be modified from within its instance methods.
        // However, if you need to modify the properties of your structure or enumeration within a particular method, you can opt in to mutating behavior for that method
        struct Point {
            var x = 0.0, y = 0.0
            // The mutating keyword is added to its definition to enable it to modify its properties.
            mutating func moveBy(x deltaX: Double, y deltaY: Double) {
                x += deltaX
                y += deltaY
            }
        }
        var somePoint = Point(x: 1.0, y: 1.0)
        somePoint.moveBy(x: 2.0, y: 3.0)
        
        
        // Assigning to self Within a Mutating Method
        struct Point2 {
            var x = 0.0, y = 0.0
            mutating func moveBy(x deltaX: Double, y deltaY: Double) {
                self = Point2(x: x + deltaX, y: y + deltaY)
            }
        }
        
        enum TriStateSwitch {
            case off, low, high
            mutating func next() {
                switch self {
                case .off:
                    self = .low
                case .high:
                    self = .low
                case .low:
                    self = .high
                }
            }
        }
        var ovenLight = TriStateSwitch.low
        ovenLight.next()
        // ovenLight is now equal to .high
        ovenLight.next()
        // ovenLight is now equal to .off
        
        
        
        // MARK: Type Methods 类方法和允许子类重洗的方法
        //  You can also define methods that are called on the type itself. These kinds of methods are called type methods. You indicate type methods by writing the static keyword before the method’s func keyword. Classes may also use the class keyword to allow subclasses to override the superclass’s implementation of that method.
        // In Objective-C, you can define type-level methods only for Objective-C classes. In Swift, you can define type-level methods for all classes, structures, and enumerations. Each type method is explicitly scoped to the type it supports.
        class SomeClass {
            // 类方法
            class func someTypeMethod() {
                // type method implementation goes here
            }
        }
        SomeClass.someTypeMethod()
        
        // the implicit self property refers to the type itself
        struct LevelTracker {
            static var highestUnlockedLevel = 1
            var currentLevel = 1
            
            static func unlock(_ level: Int) {
                if level > highestUnlockedLevel { highestUnlockedLevel = level }
            }
            
            static func isUnlocked(_ level: Int) -> Bool {
                return level <= highestUnlockedLevel
            }
            
            // Apply this attribute to a function or method declaration to suppress the compiler warning when the function or method that returns a value is called without using its result.
            // more: https://docs.swift.org/swift-book/ReferenceManual/Attributes.html
            @discardableResult
            mutating func advance(to level: Int) -> Bool {
                if LevelTracker.isUnlocked(level) {
                    currentLevel = level
                    return true
                } else {
                    return false
                }
            }
        }
        
        class Player {
            var tracker = LevelTracker()
            let playerName: String
            func complete(level: Int) {
                LevelTracker.unlock(level)
                tracker.advance(to: level + 1)
            }
            init(name: String) {
                playerName = name
            }
        }
        var player = Player(name: "Argyrios")
        player.complete(level: 1)
        print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
        // Prints "highest unlocked level is now 1"
        
        
        player = Player(name: "Beto")
        if player.tracker.advance(to: 6) {
            print("player is now on level 6")
        } else {
            print("level 6 has not yet been unlocked")
        }
        // Prints "level 6 has not yet been unlocked"
    }

}
