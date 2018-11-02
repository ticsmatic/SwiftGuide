//
//  OptionalChainingController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil. If the optional contains a value, the property, method, or subscript call succeeds;
// Optional chaining in Swift is similar to messaging nil in Objective-C, but in a way that works for any type, and that can be checked for success or failure.

// 本章节没什么重点，主要是讲类结构体等的属性有些是可选值属性，对这个可选属性访问、赋值

import UIKit

class OptionalChainingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        // MARK: Optional Chaining as an Alternative to Forced Unwrapping
        class Person {
            var residence: Residence2?
        }
        class Residence {
            var numberOfRooms = 1
        }
        let john = Person()
        
        // let roomCount = john.residence!.numberOfRooms
        // this triggers a runtime error
        
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        
        john.residence = Residence2()
        
        
        
        // MARK: Defining Model Classes for Optional Chaining
        class Residence2 {
            var rooms = [Room]()
            var numberOfRooms: Int {
                return rooms.count
            }
            subscript(i: Int) -> Room {
                get {
                    return rooms[i]
                }
                set {
                    rooms[i] = newValue
                }
            }
            func printNumberOfRooms() {
                print("The number of rooms is \(numberOfRooms)")
            }
            var address: Address?
        }
        
        class Room {
            let name: String
            init(name: String) { self.name = name }
        }
        
        class Address {
            var buildingName: String?
            var buildingNumber: String?
            var street: String?
            func buildingIdentifier() -> String? {
                if let buildingNumber = buildingNumber, let street = street {
                    return "\(buildingNumber) \(street)"
                } else if buildingName != nil {
                    return buildingName
                } else {
                    return nil
                }
            }
        }
        
        
        
        // MARK: Accessing Properties Through Optional Chaining
        let john2 = Person()
        if let roomCount = john2.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        // Prints "Unable to retrieve the number of rooms."
        
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
        john2.residence?.address = someAddress
        
        func createAddress() -> Address {
            print("Function was called.")
            
            let someAddress = Address()
            someAddress.buildingNumber = "29"
            someAddress.street = "Acacia Road"
            
            return someAddress
        }
        john2.residence?.address = createAddress()
        
        
        
        // MARK: Calling Methods Through Optional Chaining
        // You can use optional chaining to call a method on an optional value, and to check whether that method call is successful. You can do this even if that method does not define a return value.
        if john2.residence?.printNumberOfRooms() != nil {
            print("It was possible to print the number of rooms.")
        } else {
            print("It was not possible to print the number of rooms.")
        }
        // Prints "It was not possible to print the number of rooms."
        
        
        
        // MARK: Accessing Subscripts Through Optional Chaining
        if let firstRoomName = john2.residence?[0].name {
            print("The first room name is \(firstRoomName).")
        } else {
            print("Unable to retrieve the first room name.")
        }
        // Prints "Unable to retrieve the first room name."
        
        // Similarly, you can try to set a new value through a subscript with optional chaining:
        john2.residence?[0] = Room(name: "Bathroom")
        
        let johnsHouse = Residence2()
        johnsHouse.rooms.append(Room(name: "Living Room"))
        johnsHouse.rooms.append(Room(name: "Kitchen"))
        john2.residence = johnsHouse
        
        if let firstRoomName = john2.residence?[0].name {
            print("The first room name is \(firstRoomName).")
        } else {
            print("Unable to retrieve the first room name.")
        }
        // Prints "The first room name is Living Room."

        
        // Accessing Subscripts of Optional Type
        var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
        testScores["Dave"]?[0] = 91
        testScores["Bev"]?[0] += 1
        testScores["Brian"]?[0] = 72
        // the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]
        
        
        
        // MARK: Linking Multiple Levels of Chaining 连接多层可选链式调用
        if let johnsStreet = john2.residence?.address?.street {
            print("John's street name is \(johnsStreet).")
        } else {
            print("Unable to retrieve the address.")
        }
        // Prints "Unable to retrieve the address."
        
        let johnsAddress = Address()
        johnsAddress.buildingName = "The Larches"
        johnsAddress.street = "Laurel Street"
        john2.residence?.address = johnsAddress
        
        
        
        // MARK: Chaining on Methods with Optional Return Values
        if let buildingIdentifier = john2.residence?.address?.buildingIdentifier() {
            print("John's building identifier is \(buildingIdentifier).")
        }
        // Prints "John's building identifier is The Larches."
    }
}
