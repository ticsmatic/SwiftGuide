//
//  InitializationController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that is required before the new instance is ready for use.
// Unlike Objective-C initializers, Swift initializers do not return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they are used for the first time.
// deinitializer, which performs any custom cleanup just before an instance of that class is deallocated

// 构造函数参数区分

// 默认值

// 结构体的属性默认生成逐一构造

import UIKit

class InitializationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        // MARK: Setting Initial Values for Stored Properties
        // 初始化方法不会触发value observer
        
        // Initializers
        struct Fahrenheit {
            var temperature: Double
            init() {
                temperature = 32.0
            }
        }
        var f = Fahrenheit()
        print(f.temperature)
        

        // Default Property Values
        struct Fahrenheit2 {
            var temperature = 32.0
        }
        
        
        
        // MARK: Customizing Initialization
        // You can customize the initialization process with input parameters and optional property types, or by assigning constant properties during initialization, as described in the following sections.
        
        // Initialization Parameters
        struct Celsius {
            var temperatureInCelsius: Double
            init(fromFahrenheit fahrenheit: Double) {
                temperatureInCelsius = (fahrenheit - 32.0) / 1.8
            }
            init(fromKelvin kelvin: Double) {
                temperatureInCelsius = kelvin - 273.15
            }
            init(_ celsius: Double) {
                temperatureInCelsius = celsius
            }
        }
        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
        // boilingPointOfWater.temperatureInCelsius is 100.0
        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
        // freezingPointOfWater.temperatureInCelsius is 0.0
        let bodyTemperature = Celsius(37.0)
        // bodyTemperature.temperatureInCelsius is 37.0
        
        
        // Parameter Names and Argument Labels
        // initializers do not have an identifying function name before their parentheses in the way that functions and methods do. Therefore, the names and types of an initializer’s parameters play a particularly important role in identifying which initializer should be called.
        struct Color {
            var red, green, blue: Double
            init(red: Double, green: Double, blue: Double) {
                self.red = red
                self.green = green
                self.blue = blue
            }
            init(white: Double) {
                red = white
                green = white
                blue = white
            }
        }
        let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
        let halfGray = Color(white: 0.5)
        // it is not possible to call these initializers without using argument labels.
        
        
        // Initializer Parameters Without Argument Labels
//        init(_ celsius: Double) {
//            temperatureInCelsius = celsius
//        }
        
        
        // Optional Property Types
        class SurveyQuestion {
            var text: String
            var response: String?
            init(text: String) {
                self.text = text
            }
            func ask() -> Void {
                print(text)
            }
        }
        let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
        cheeseQuestion.ask()
        cheeseQuestion.response = "yes, i do like cheese."
        
        
        // Assigning Constant Properties During Initialization
        // You can assign a value to a constant property at any point during initialization, as long as it is set to a definite value by the time initialization finishes. Once a constant property is assigned a value, it can’t be further modified.
        class SurveyQuestion2 {
            let text: String
            var response: String?
            init(text: String) {
                self.text = text
            }
            func ask() {
                print(text)
            }
        }
        let beetsQuestion = SurveyQuestion2(text: "How about beets?")
        beetsQuestion.ask()
        // Prints "How about beets?"
        beetsQuestion.response = "I also like beets. (But not with cheese.)"

        
        
        // MARK: Default Initializers 默认值
        class ShoppingListItem {
            var name: String?
            var quantity = 1
            var purchased = false
        }
        var item = ShoppingListItem()

        
        // Memberwise Initializers for Structure Types
        // The memberwise initializer is a shorthand way to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name.
        // The Size structure automatically receives an init(width:height:) memberwise initializer, which you can use to initialize a new Size instance:
        struct Size {
            var width = 0.0, height = 0.0
        }
        let twoByTwo = Size(width: 2.0, height: 2.0)
        
        // MARK: Initializer Delegation for Value Types 值类型的构造器代理
        // Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers.
        // Value types (structures and enumerations) do not support inheritance, and so their initializer delegation process is relatively simple
        struct Size2 {
            var width = 0.0, height = 0.0
        }
        struct Point2 {
            var x = 0.0, y = 0.0
        }
        struct Rect2 {
            var origin = Point2()
            var size = Size2()
            init() {}
            init(origin: Point2, size: Size2) {
                self.origin = origin
                self.size = size
            }
            init(center: Point2, size: Size2) {
                let originX = center.x - size.width / 2
                let originY = center.y - size.height / 2
                self.init(origin: Point2(x: originX, y: originY), size: size)
            }
        }
        let basicRect = Rect2()
        // basicRect's origin is (0.0, 0.0) and its size is (0.0, 0.0)
        let originRect = Rect2(origin: Point2(x: 2.0, y: 2.0),
                               size: Size2(width: 5.0, height: 5.0))
        let centerRect = Rect2(center: Point2(x: 4.0, y: 4.0),
                             size: Size2(width: 3.0, height: 3.0))
        
        
        
        // MARK: Class Inheritance and Initialization
        // All of a class’s stored properties—including any properties the class inherits from its superclass—must be assigned an initial value during initialization.
        
        // Designated Initializers and Convenience Initializers
        // Classes tend to have very few designated initializers, and it is quite common for a class to have only one.
        // Convenience initializers are secondary
        // You do not have to provide convenience initializers if your class does not require them.
        
        // Syntax for Designated and Convenience Initializers
//        init(parameters) {
//            statements
//        }
//        convenience init(parameters) {
//            statements
//        }
        
        
        // Initializer Delegation for Class Types
        class Vehicle {
            var numberOfWheels = 0
            var description: String {
                return "\(numberOfWheels) wheel(s)"
            }
        }
        let vehicle = Vehicle()
        print("Vehicle: \(vehicle.description)")
        // Vehicle: 0 wheel(s)
        class Bicycle: Vehicle {
            override init() {
                super.init()
                numberOfWheels = 2
            }
        }
        let bicycle = Bicycle()
        print("Bicycle: \(bicycle.description)")
        // Bicycle: 2 wheel(s)
        
        class Hoverboard: Vehicle {
            var color: String
            init(color: String) {
                self.color = color
                // super.init() implicitly called here
            }
            override var description: String {
                return "\(super.description) in a beautiful \(color)"
            }
        }
        let hoverboard = Hoverboard(color: "silver")
        print("Hoverboard: \(hoverboard.description)")
        // Hoverboard: 0 wheel(s) in a beautiful silver
        
        
        // Automatic Initializer Inheritance
        class Food {
            var name: String
            init(name: String) {
                self.name = name
            }
            convenience init() {
                self.init(name: "[Unnamed]")
            }
        }
        let namedMeat = Food(name: "Bacon")
        // namedMeat's name is "Bacon"
        let mysteryMeat = Food()
        // mysteryMeat's name is "[Unnamed]"
        
        class RecipeIngredient: Food {
            var quantity: Int
            init(name: String, quantity: Int) {
                self.quantity = quantity
                super.init(name: name)
            }
            override convenience init(name: String) {
                self.init(name: name, quantity: 1)
            }
        }
        let oneMysteryItem = RecipeIngredient()
        let oneBacon = RecipeIngredient(name: "Bacon")
        let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
        
        class ShoppingListItem2: RecipeIngredient {
            var purchased = false
            var description: String {
                var output = "\(quantity) x \(name)"
                output += purchased ? " ✔" : " ✘"
                return output
            }
        }
        var breakfastList = [
            ShoppingListItem2(),
            ShoppingListItem2(name: "Bacon"),
            ShoppingListItem2(name: "Eggs", quantity: 6),
            ]
        breakfastList[0].name = "Orange juice"
        breakfastList[0].purchased = true
        for item in breakfastList {
            print(item.description)
        }
        // 1 x Orange juice ✔
        // 1 x Bacon ✘
        // 6 x Eggs ✘
        
        
        
        // MARK: Failable Initializers
        //  (init?)
        let wholeNumber: Double = 12345.0
        let pi = 3.14159
        if let valueMaintained = Int(exactly: wholeNumber) {
            print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
        }
        // Prints "12345.0 conversion to Int maintains value of 12345"
        
        let valueChanged = Int(exactly: pi)
        // valueChanged is of type Int?, not Int
        
        if valueChanged == nil {
            print("\(pi) conversion to Int does not maintain value")
        }
        // Prints "3.14159 conversion to Int does not maintain value"

        struct Animal {
            let species: String
            init?(species: String) {
                if species.isEmpty { return nil }
                self.species = species
            }
        }
        let someCreature = Animal(species: "Giraffe")
        if let giraffe = someCreature {
            print("An animal was initialized with a species of \(giraffe.species)")
        }
        
        let anonymousCreature = Animal(species: "")
        if anonymousCreature == nil {
            print("The anonymous creature could not be initialized")
        }
        
        
        // Failable Initializers for Enumerations
        enum TemperatureUnit {
            case kelvin, celsius, fahrenheit
            init?(symbol: Character) {
                switch symbol {
                case "K":
                    self = .kelvin
                case "C":
                    self = .celsius
                case "F":
                    self = .fahrenheit
                default:
                    return nil
                }
            }
        }
        let fahrenheitUnit = TemperatureUnit(symbol: "F")
        if fahrenheitUnit != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }
        
        let unknownUnit = TemperatureUnit(symbol: "X")
        if unknownUnit == nil {
            print("This is not a defined temperature unit, so initialization failed.")
        }
        
        
        // Failable Initializers for Enumerations with Raw Values
        //  init?(rawValue:)
        enum TemperatureUnit2: Character {
            case kelvin = "K", celsius = "C", fahrenheit = "F"
        }
        let fahrenheitUnit2 = TemperatureUnit2(rawValue: "F")
        if fahrenheitUnit2 != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }

        
        // Propagation of Initialization Failure
        class Product {
            var name: String
            init?(name: String) {
                if name.isEmpty {
                    return nil
                }
                self.name = name
            }
        }
        class CartItem: Product {
            let quantity: Int
            init?(name: String, quantity: Int) {
                if quantity < 1 {
                    return nil
                }
                self.quantity = quantity
                super.init(name: name)
            }
        }
        if let twoSocks = CartItem(name: "sock", quantity: 2) {
            print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
        }
        // Prints "Item: sock, quantity: 2"
        if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
            print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
        } else {
            print("Unable to initialize zero shirts")
        }
        // Prints "Unable to initialize zero shirts"
        
        
        // Overriding a Failable Initializer
        class Document {
            var name: String?
            init() {}
            init?(name: String) {
                if name.isEmpty { return nil }
                self.name = name
            }
        }
        class AutomaticallyNamedDocument: Document {
            override init() {
                super.init()
                self.name = "[Untitled]"
            }
            override init?(name: String) {
                super.init()
                if name.isEmpty {
                    self.name = "[Untitled]"
                } else {
                    self.name = name
                }
            }
        }
        class UntitledDocument: Document {
            override init() {
                super.init(name: "[Untitled]")!
            }
        }
        
        
        // The init! Failable Initializer
        // (init!)
        // Alternatively, you can define a failable initializer that creates an implicitly unwrapped optional instance of the appropriate type. Do this by placing an exclamation mark after the init keyword (init!) instead of a question mark.
        // You can delegate from init? to init! and vice versa, and you can override init? with init! and vice versa. You can also delegate from init to init!, although doing so will trigger an assertion if the init! initializer causes initialization to fail.
       
    
        
        // MARK: Required Initializers
        // indicate that every subclass of the class must implement that initializer:
        class SomeClass {
            required init() {
                // initializer implementation goes here
            }
        }
        // You must also write the required modifier before every subclass implementation of a required initializer
        class SomeSubclass: SomeClass {
            required init() {
                // subclass implementation of the required initializer goes here
            }
        }
        
        
        
        // MARK: Setting a Default Property Value with a Closure or Function
        // If a stored property’s default value requires some customization or setup, you can use a closure or global function to provide a customized default value for that property.
        struct Chessboard {
            let boardColors: [Bool] = {
                var temporaryBoard = [Bool]()
                var isBlack = false
                for i in 1...8 {
                    for j in 1...8 {
                        temporaryBoard.append(isBlack)
                        isBlack = !isBlack
                    }
                    isBlack = !isBlack
                }
                return temporaryBoard
            }()
            func squareIsBlackAt(row: Int, column: Int) -> Bool {
                return boardColors[(row * 8) + column]
            }
        }
        let board = Chessboard()
        print(board.squareIsBlackAt(row: 0, column: 1))
        // Prints "true"
        print(board.squareIsBlackAt(row: 7, column: 7))
        // Prints "false"
    }

}
