//
//  ProtocolsController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//
// defines a blueprint
// A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol.
// In addition to specifying requirements that conforming types must implement, you can extend a protocol to implement some of these requirements or to implement additional functionality that conforming types can take advantage of. 可以给协议搞一些默认实现
import UIKit
// MARK: 1.Protocol Syntax
// You define protocols in a very similar way to classes, structures, and enumerations:
//protocol SomeProtocol {
//    // protocol definition goes here
//}
//struct SomeStructure: FirstProtocol, AnotherProtocol {
//    // structure definition goes here
//}
// If a class has a superclass, list the superclass name before any protocols it adopts, followed by a comma: 继承和协议融合
//class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
//    // class definition goes here
//}
// MARK: 2.Property Requirements
// A protocol can require any conforming type to provide an instance property or type property with a particular name and type. The protocol doesn’t specify whether the property should be a stored property or a computed property—it only specifies the required property name and type. The protocol also specifies whether each property must be gettable or gettable and settable.
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}
// Always prefix type property requirements with the static keyword when you define them in a protocol. This rule pertains even though type property requirements can be prefixed with the class or static keyword when implemented by a class:
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}
protocol FullyNamed {
    var fullName: String { get }
}
struct Person: FullyNamed {
    var fullName: String
}
class Starship: FullyNamed {
    var fullName: String {
        return (prefix != nil ? prefix! + " " : " ") + name
    }
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
        // Cannot assign to property: 'fullName' is a get-only property
        // self.fullName = name
    }
}
// MARK: 3.Method Requirements
// Protocols can require specific instance methods and type methods to be implemented by conforming types.
// As with type property requirements, you always prefix type method requirements with the static keyword when they’re defined in a protocol. This is true even though type method requirements are prefixed with the class or static keyword when implemented by a class:
protocol SomeProtocol2 {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
    
    static func someTypeMethod()
    func random() -> Double
}
protocol RandomNumberGenerator {
    func random() -> Double
}
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    // 协议方法的实现
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
// MARK: 4.Mutating Method Requirements
// It’s sometimes necessary for a method to modify (or mutate) the instance it belongs to.
// For instance methods on value types (that is, structures and enumerations) you place the mutating keyword before a method’s func keyword to indicate that the method is allowed to modify the instance it belongs to and any properties of that instance.
protocol Togglable {
    mutating func toggle()
}
enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
// MARK: 5.Initializer Requirements
// Protocols can require specific initializers to be implemented by conforming types. You write these initializers as part of the protocol’s definition in exactly the same way as for normal initializers, but without curly braces or an initializer body:
protocol SomeProtocol3 {
    init(someParameter: Int)
}
// Class Implementations of Protocol Initializer Requirements
class SomeClass: SomeProtocol3 {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
    // The use of the required modifier ensures that you provide an explicit or inherited implementation of the initializer requirement on all subclasses of the conforming class, such that they also conform to the protocol.
}
// If a subclass overrides a designated initializer from a superclass, and also implements a matching initializer requirement from a protocol, mark the initializer implementation with both the required and override modifiers:
protocol SomeProtocol4 {
    init()
}
class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}
class SomeSubClass: SomeSuperClass, SomeProtocol4 {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}
// Failable Initializer Requirements
// Protocols can define failable initializer requirements for conforming types, as defined in Failable Initializers.
// MARK: 6.Protocols as Types 协议是个类型
// Protocols don’t actually implement any functionality themselves. Nonetheless, any protocol you create will become a fully-fledged type for use in your code.
// Because it’s a type, you can use a protocol in many places where other types are allowed
class Dice {
    var sides: Int
    var generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides;
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
// MARK: 7.Delegation
// Delegation is a design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type.This design pattern is implemented by defining a protocol that encapsulates the delegated responsibilities, such that a conforming type (known as a delegate) is guaranteed to provide the functionality that has been delegated. Delegation can be used to respond to a particular action, or to retrieve data from an external source without needing to know the underlying type of that source.
/// 定义某个玩游戏的协议
protocol DiceGame {
    var dice: Dice { get }
    func play()
}
/// The DiceGameDelegate protocol can be adopted to track the progress of a DiceGame.
protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}
// To prevent strong reference cycles, delegates are declared as weak references.
class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice: Dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
    }
    weak var delegate: DiceGameDelegate?
    
    func play() {
        square = 0
        // 代理回调
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(_game: self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    
    func game(_game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
    
}


// MARK: 8.Adding Protocol Conformance with an Extension 在类型扩展里添加协议遵循
// You can extend an existing type to adopt and conform to a new protocol, even if you don’t have access to the source code for the existing type. Extensions can add new properties, methods, and subscripts to an existing type, and are therefore able to add any requirements that a protocol may demand. For more about extensions, see Extensions.
protocol TextRepresentable {
    var textualDescription: String { get }
}

/// Dice并没有遵守这个协议，但是它的扩展遵守了。 给Dice类增加一个扩展，并在扩展里对它遵守的协议进行实现
extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}
extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}

// Conditionally Conforming to a Protocol 有条件的遵守协议
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

// Declaring Protocol Adoption with an Extension
// If a type already conforms to all of the requirements of a protocol, but has not yet stated that it adopts that protocol, you can make it adopt the protocol with an empty extension:
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hasmster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

// MARK: 10.Protocol Inheritance 协议继承
// A protocol can inherit one or more other protocols and can add further requirements on top of the requirements it inherits. The syntax for protocol inheritance is similar to the syntax for class inheritance, but with the option to list multiple inherited protocols, separated by commas:
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // protocol definition goes here
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}


// MARK: 11.Class-Only Protocols
// You can limit protocol adoption to class types (and not structures or enumerations) by adding the AnyObject protocol to a protocol’s inheritance list.
//protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
//    // class-only protocol definition goes here
//}
// In the example above, SomeClassOnlyProtocol can only be adopted by class types. It’s a compile-time error to write a structure or enumeration definition that tries to adopt SomeClassOnlyProtocol.


// MARK: 12.Protocol Composition 协议合成
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person2: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person2(name: "Malcolm", age: 21)

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)


// MARK: 13.Checking for Protocol Conformance 检查协议的实现
// You can use the is and as operators described in Type Casting to check for protocol conformance, and to cast to a specific protocol. Checking for and casting to a protocol follows exactly the same syntax as checking for and casting to a type:
// is as? as!
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double = 0.0
    var area: Double {
        return pi * radius * radius
    }
    init(radius: Double) {
        self.radius = radius
    }
}

class Country: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]


// MARK: 14.Optional Protocol Requirements 协议的可选实现
// You can define optional requirements for protocols, These requirements don’t have to be implemented by types that conform to the protocol.Optional requirements are prefixed by the optional modifier as part of the protocol’s definition. Optional requirements are available so that you can write code that interoperates with Objective-C. Both the protocol and the optional requirement must be marked with the @objc attribute. Note that @objc protocols can be adopted only by classes that inherit from Objective-C classes or other @objc classes. They can’t be adopted by structures or enumerations.
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}


// MARK: 15.Protocol Extensions 协议扩展
// Protocols can be extended to provide method, initializer, subscript, and computed property implementations to conforming types. This allows you to define behavior on protocols themselves, rather than in each type’s individual conformance or in a global function.
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

// Providing Default Implementations 利用协议扩展提供默认实现
// You can use protocol extensions to provide a default implementation to any method or computed property requirement of that protocol. If a conforming type provides its own implementation of a required method or property, that implementation will be used instead of the one provided by the extension.
extension PrettyTextRepresentable {
    // 给这个协议提供一个默认的实现
    var prettyTextualDescription: String {
        return textualDescription
    }
}

// Adding Constraints to Protocol Extensions 给协议扩展添加约束
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            // Equatable 协议方法
            if element != self.first {
                return false
            }
        }
        return true
    }
}


class ProtocolsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let john = Person(fullName: "John Appleseed")
        print(john.fullName)
        
        var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
        print(ncc1701.fullName)
        
        let generator = LinearCongruentialGenerator()
        print("Here's a random number: \(generator.random())")
        // Prints "Here's a random number: 0.3746499199817101"
        print("And another one: \(generator.random())")
        // Prints "And another one: 0.729023776863283"
        
        var lightSwitch = OnOffSwitch.off
        lightSwitch.toggle()
        
        // 传递一个遵守并实现协议的对象
        var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
        for _ in 1...5 {
            print("Random dice roll is \(d6.roll())")
        }
        
        // 游戏的代理
        let tracker = DiceGameTracker()
        // 游戏
        let game = SnakesAndLadders()
        // 设置游戏代理
        game.delegate = tracker
        // 游戏开始
        game.play()
        
        let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
        print(d12.textualDescription)
        // Prints "A 12-sided dice"
        
        print(game.textualDescription)
        // Prints "A game of Snakes and Ladders with 25 squares"
        
        let myDice = [d6, d12]
        print(myDice.textualDescription)
        // Prints "[A 6-sided dice, A 12-sided dice]"
        
        // Instances of Hamster can now be used wherever TextRepresentable is the required type:
        let simonTheHamster = Hamster(name: "Simon")
        let somethingTextRepresentable: TextRepresentable = simonTheHamster
        print(somethingTextRepresentable.textualDescription)
        
        // MARK: 9.Collections of Protocol Types
        // A protocol can be used as the type to be stored in a collection such as an array or a dictionary, as mentioned in Protocols as Types. This example creates an array of TextRepresentable things:
        let things: [TextRepresentable] = [game, d12, simonTheHamster]
        for thing in things {
            print(thing.textualDescription)
        }
        
        print(game.prettyTextualDescription)
        
        // 协议合成，传递一个参数，这个参数是连个协议合成后的类型，比如说Person2类
        wishHappyBirthday(to: birthdayPerson)
        
        beginConcert(in: seattle)
        // Prints "Hello, Seattle!"
        
        // 13.协议的遵守情况判断
        for object in objects {
            if let objectWithArea = object as? HasArea {
                print("Area is \(objectWithArea.area)")
            } else {
                print("Something that doesn't have an area")
            }
        }
        
        // 14.可选协议
        var counter = Counter()
        counter.dataSource = ThreeSource()
        for _ in 1...4 {
            counter.increment()
            print(counter.count)
        }
        // 3
        // 6
        // 9
        // 12
        
        counter.count = -4
        counter.dataSource = TowardsZeroSource()
        for _ in 1...5 {
            counter.increment()
            print(counter.count)
        }
        // -3
        // -2
        // -1
        // 0
        // 0
        
        // 15.协议扩展
        let generator2 = LinearCongruentialGenerator()
        print("Here's a random number: \(generator2.random())")
        // Prints "Here's a random number: 0.3746499199817101"
        // 利用extension，给RandomNumberGenerator协议了一个randomBool方法
        print("And here's a random Boolean: \(generator2.randomBool())")
        // Prints "And here's a random Boolean: true"
        
        let equalNumbers = [100, 100, 100, 100, 100]
        let differentNumbers = [100, 100, 200, 100, 200]
        print(equalNumbers.allEqual())
        // Prints "true"
        print(differentNumbers.allEqual())
        // Prints "false"
    }
}
