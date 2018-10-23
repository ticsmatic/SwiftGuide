//
//  CollectionTypesController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/23.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//
// arrays, sets, and dictionaries

// 不需要用可变的就不要用可变的

// 数组可以相加

import UIKit

class CollectionTypesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        // MARK: Mutability of Collections
        // 创建的数组、集合、字典赋值给变量，那么它就是可变的，赋值给let的constant，就是不可变的
        // It is good practice to create immutable collections in all cases where the collection does not need to change. Doing so makes it easier for you to reason about your code and enables the Swift compiler to optimize the performance of the collections you create.
        
        
        // MARK: Arrays
        // An array stores values of the same type in an ordered list. The same value can appear in an array multiple times at different positions.
        // Swift’s Array type is bridged to Foundation’s NSArray class.
        
        // Array Type Shorthand Syntax
        // array is written in full as Array<Element>, shorthand form as [Element]
        
        // Creating an Empty Array
        var someInts = [Int]()
        print("someInts is of type [Int] with \(someInts.count) items.")
        // Prints "someInts is of type [Int] with 0 items."
        someInts.append(3)
        // someInts now contains 1 value of type Int
        someInts = []
        // someInts is now an empty array, but is still of type [Int]
        someInts.append(10)
        
        // Creating an Array with a Default Value
        var threeDoubles = Array(repeating: 0.0, count: 3)
        // threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]
        
        // Creating an Array by Adding Two Arrays Together
        var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
        // anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]
        var sixDoubles = threeDoubles + anotherThreeDoubles
        // sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]

        var shoppingList: [String] = ["Eggs", "Milk"]
        // shoppingList has been initialized with two initial items
        
        
        // Accessing and Modifying an Array 访问和修改
        print("The shopping list contains \(shoppingList.count) items.")
        // Prints "The shopping list contains 2 items."
        // isEmpty
        if shoppingList.isEmpty {
            print("The shopping list is empty.")
        } else {
            print("The shopping list is not empty.")
        }
        
        // append
        shoppingList.append("Flour")
        
        // Alternatively, append an array of one or more compatible items with the addition assignment operator (+=):
        shoppingList += ["Baking Powder"]
        // shoppingList now contains 4 items
        shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
        // shoppingList now contains 7 items
        
        var firstItem = shoppingList[0]
        // firstItem is equal to "Eggs"
        
        // subscript syntax to change an existing value at a given index:
        shoppingList[0] = "Six eggs"
        // the first item in the list is now equal to "Six eggs" rather than "Eggs"

        // replace value at range of index
        shoppingList[4...6] = ["Bananas", "Apples"]
        // shoppingList now contains 6 items
        
        // insert(_:at:)
        shoppingList.insert("Maple Syrup", at: 0)
        // shoppingList now contains 7 items
        // "Maple Syrup" is now the first item in the list
        
        // remove(at:)
        let mapleSyrup = shoppingList.remove(at: 0)
        // the item that was at index 0 has just been removed
        // shoppingList now contains 6 items, and no Maple Syrup
        // the mapleSyrup constant is now equal to the removed "Maple Syrup" string
        
        // removeLast()
        let apples = shoppingList.removeLast()
        
        
        // Iterating Over an Array
        for item in shoppingList {
            print(item)
        }
        // Six eggs
        // Milk
        // Flour
        // Baking Powder
        // Bananas
        
        // .enumerated()
        for (index, value) in shoppingList.enumerated() {
            print("Item \(index + 1): \(value)")
        }
        // Item 1: Six eggs
        // Item 2: Milk
        // Item 3: Flour
        // Item 4: Baking Powder
        // Item 5: Bananas

        
        // MARK: Sets
        // Swift’s Set type is bridged to Foundation’s NSSet class.
        
        // Hash Values for Set Types
        // A type must be hashable in order to be stored in a set
        // A hash value is an Int value that is the same for all objects that compare equally, such that if a == b, it follows that a.hashValue == b.hashValue.
        // All of Swift’s basic types (such as String, Int, Double, and Bool) are hashable by default
        
        // Set Type Syntax
        // The type of a Swift set is written as Set<Element>, where Element is the type that the set is allowed to store. Unlike arrays, sets do not have an equivalent shorthand form.
        
        // Creating and Initializing an Empty Set
        var letters = Set<Character>() // Array<String>() arrays [String]()
        print("letters is of type Set<Character> with \(letters.count) items.")
        // Prints "letters is of type Set<Character> with 0 items."

        letters.insert("a")
        letters = []
        
        // Creating a Set with an Array Literal
        var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
        // favoriteGenres has been initialized with three initial items
        
        //  if you’re initializing it with an array literal that contains values of just one type
        var favoriteGenres2: Set = ["Rock", "Classical", "Hip hop"]
        
        // Accessing and Modifying a Set
        print("I have \(favoriteGenres.count) favorite music genres.")
        
        // isEmpty
        
        // insert(_:)
        favoriteGenres.insert("Jazz")
        
        // remove(_:)  removeAll()
        if let removedGenre = favoriteGenres.remove("Rock") {
            print("\(removedGenre)? I'm over it.")
        } else {
            print("I never much cared for that.")
        }
        // Prints "Rock? I'm over it."
        
        //  contains(_:)
        if favoriteGenres.contains("Funk") {
            print("I get up on the good foot.")
        } else {
            print("It's too funky in here.")
        }
        
        
        // Iterating Over a Set
        for genre in favoriteGenres {
            print("\(genre)")
        }
        
        
        // MARK: Performing Set Operations 集合操作
        // intersection(_:)             交集
        // symmetricDifference(_:)      交集取反
        // union(_:)                    并集
        // subtracting(_:)              余集
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
        oddDigits.union(evenDigits).sorted()
        // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        oddDigits.intersection(evenDigits).sorted()
        // []
        oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
        // [1, 9]
        oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
        // [1, 2, 9]
        
        // Set Membership and Equality
        // isSubset(of:)
        // isSuperset(of:)
        // isStrictSubset(of:)
        // isDisjoint(with:)
        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]
        houseAnimals.isSubset(of: farmAnimals)
        // true
        farmAnimals.isSuperset(of: houseAnimals)
        // true
        farmAnimals.isDisjoint(with: cityAnimals)
        // true
        
        
        // MARK: Dictionaries
        // Swift’s Dictionary type is bridged to Foundation’s NSDictionary class.
        
        // Dictionary Type Shorthand Syntax
        // dictionary is written in full as Dictionary<Key, Value>, shorthand form as [Key: Value]
        
        // Creating an Empty Dictionary
        var namesOfIntegers = [Int: String]()
        // namesOfIntegers is an empty [Int: String] dictionary
        
        namesOfIntegers[16] = "sixteen"
        // namesOfIntegers now contains 1 key-value pair
        print(namesOfIntegers[16])
        namesOfIntegers = [:]
        // namesOfIntegers is once again an empty dictionary of type [Int: String]
        
        // Creating a Dictionary with a Dictionary Literal
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        
        var airports2 = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        
        
        // Accessing and Modifying a Dictionary
        // .count
        // .isEmpty
        airports["LHR"] = "London"
        airports["LHR"] = "London Heathrow"
        // updateValue(_:forKey:)
        // Updates the value stored in the dictionary for the given key, or adds a new key-value pair if the key does not exist.
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        // Prints "The old value for DUB was Dublin."
        
        // You can use subscript syntax to remove a key-value pair from a dictionary by assigning a value of nil for that key:
        airports["APL"] = "Apple International"
        // "Apple International" is not the real airport for APL, so delete it
        airports["APL"] = nil
        // APL has now been removed from the dictionary
        
        if let removedValue = airports.removeValue(forKey: "DUB") {
            print("The removed airport's name is \(removedValue).")
        } else {
            print("The airports dictionary does not contain a value for DUB.")
        }
        
        
        // Iterating Over a Dictionary
        for (airportCode, airportName) in airports {
            print("\(airportCode): \(airportName)")
        }
        // YYZ: Toronto Pearson
        // LHR: London Heathrow
        
        // .keys
        // .values
        let airportCodes = [String](airports.keys)
        // airportCodes is ["YYZ", "LHR"]
        
        let airportNames = [String](airports.values)
        // airportNames is ["Toronto Pearson", "London Heathrow"]
        
        airports2.keys.sorted()
    }

}
