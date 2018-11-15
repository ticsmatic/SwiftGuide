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
        return lastRandom
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
        
        
    }
}



