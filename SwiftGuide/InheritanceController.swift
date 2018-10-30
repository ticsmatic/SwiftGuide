//
//  InheritanceController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// A class can inherit methods, properties, and other characteristics from another class
// Classes in Swift can call and access methods, properties, and subscripts belonging to their superclass and can provide their own overriding versions of those methods, properties, and subscripts to refine or modify their behavior 可以继承和重写方法、属性、下标
// Classes can also add property observers to inherited properties in order to be notified when the value of a property changes. Property observers can be added to any property, regardless of whether it was originally defined as a stored or computed property.

// 继承和其它语言没什么区别，有个override关键字，还有个final关键字用来防止重写，final关键字可以修饰final var, final func, final class func, and final subscript

// 今天看到swift和Kotlin语言的对比，和Kotlin相似的地方实在是太多了，编程的未来一段时间属于Kotlin、swift、python等简洁语言的天下

import UIKit

class InheritanceController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        // MARK: Defining a Base Class
        // Swift classes do not inherit from a universal base class. Classes you define without specifying a superclass automatically become base classes for you to build upon.
        class  Vehicle {
            var currentSpped = 0.0
            var description: String {
                return "traveling at \(currentSpped) miles per hour"
            }
            func makenoise() -> Void {
                // do notiong, will be customized by subclass
            }
        }
        let someVehicle = Vehicle()
        
        // MARK: Subclassing
        // The subclass inherits characteristics from the existing class, which you can then refine. You can also add new characteristics to the subclass.
        class Bicycle: Vehicle {
            var hasBasket = false
        }
        let bicycle = Bicycle()
        bicycle.hasBasket = false
        bicycle.currentSpped = 15.0
        print("Bicycle: \(bicycle.description)")
        
        class Tandem: Bicycle {
            var currentNumberOfPassengers = 0
        }
        
        let tandem = Tandem()
        tandem.hasBasket = true
        tandem.currentSpped = 10.0
        tandem.currentSpped = 2
        print("Tandem: \(tandem.description)")
        
        
        
        // MARK: Overriding
        // A subclass can provide its own custom implementation of an instance method, type method, instance property, type property, or subscript that it would otherwise inherit from a superclass. This is known as overriding.
        // override keyword
        
        
        // Accessing Superclass Methods, Properties, and Subscripts
        // When you provide a method, property, or subscript override for a subclass, it is sometimes useful to use the existing superclass implementation as part of your override
        
        
        // Overriding Methods
        // You can override an inherited instance or type method to provide a tailored or alternative implementation of the method within your subclass.
        class Train: Vehicle {
            override func makenoise() {
                print("哐， 哐， 哐...")
            }
        }
        let train = Train()
        train.makenoise()
        // print("哐， 哐， 哐...")
        
        
        // Overriding Properties
        // You can override an inherited instance or type property to provide your own custom getter and setter for that property, or to add property observers to enable the overriding property to observe when the underlying property value changes.
        
        // Overriding Property Getters and Setters
        class Car: Vehicle {
            var gear = 1;
            override var description: String {
                return super.description + "in gear \(gear)"
            }
        }
        let car = Car()
        car.currentSpped = 88.0
        car.gear = 4
        print("Car: \(car.description)")
        
        // Overriding Property Observers
        class AutomaticCar: Car {
            override var currentSpped: Double {
                didSet {
                    gear = Int(currentSpped / 10.0) + 1
                }
            }
        }
        let automatic = AutomaticCar()
        automatic.currentSpped = 35.0
        print("AutomaticCar: \(automatic.description)")
        
        
        
        // MARK: Preventing Overrides
        // final
        // You can prevent a method, property, or subscript from being overridden by marking it as final. Do this by writing the final modifier before the method, property, or subscript’s introducer keyword (such as final var, final func, final class func, and final subscript).
        final class WxqCar: AutomaticCar {
            
        }
        let myCar = WxqCar()
        myCar.currentSpped = 300.0
        print(myCar.description)
        
        // compile-time error :Inheritance from a final class 'WxqCar'
//        class ErrorSubClass: WxqCar {
//
//        }
    }

}
