//
//  GenericsController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// Generic code enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define. You can write code that avoids duplication and expresses its intent in a clear, abstracted manner.

import UIKit

class GenericsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // MAKR: The Problem That Generics Solve
        // 问题：做两个Int类型值的交换方法，、两个Double的交换、String的交换，他们接受的类型不同，但是实现都一样
        // 解决：泛型，不指定具体类型，进行交换
        
        
        
        // MARK: Generic Functions
        func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
            let temperaryA = a
            a = b
            b = temperaryA
        }
        var someInt = "3"
        var anotherInt = "107"
        swapTwoValues(&someInt, &anotherInt)
        print(someInt, anotherInt)
        
        
        
        // MARK: Type Parameters 语法
        // 写在方法名后面， 用尖括号括起来，然后可以在方法参数、返回值中使用
        
        
        
        // MARK: Naming Type Parameters 命名类型参数 这个语法和objc很像
        // In most cases, type parameters have descriptive names, such as Key and Value in Dictionary<Key, Value> and Element in Array<Element>, which tells the reader about the relationship between the type parameter and the generic type or function it’s used in. However, when there isn’t a meaningful relationship between them, it’s traditional to name them using single letters such as T, U, and V, such as T in the swapTwoValues(_:_:) function above.
        
        
        
        // MARK: Generic Types 泛型类型
        // In addition to generic functions, Swift enables you to define your own generic types. These are custom classes, structures, and enumerations that can work with any type, in a similar way to Array and Dictionary.
        struct IntStack {
            var items = [Int]()
            mutating func push(_ item: Int) {
                items.append(item)
            }
            
            mutating func pop() ->Int {
                return items.removeLast()
            }
        }
        
        
        var stackOfStrings = Stack<String>()
        stackOfStrings.push("uno")
        stackOfStrings.push("dos")
        stackOfStrings.push("tres")
        stackOfStrings.push("cuatro")
        let fromTheTop = stackOfStrings.pop()
        
        
        
        // MARK: Extending a Generic Type 泛型的扩展
        
        // MARK: Type Constraints 约束到继承自某个类型
        // The swapTwoValues(_:_:) function and the Stack type can work with any type. However, it’s sometimes useful to enforce certain type constraints on the types that can be used with generic functions and generic types. Type constraints specify that a type parameter must inherit from a specific class, or conform to a particular protocol or protocol composition.
        
        // Type Constraint Syntax
        func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
            // function body goes here
        }
        func ass<SomeClass, SomeProtocol>(s: SomeClass, u: SomeProtocol) {
            
        }
        
        // Type Constraints in Action
        func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
            for (index, value) in array.enumerated() {
                if value == valueToFind {
                    return index
                }
            }
            return nil
        }
        func findIndex2<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
            for (index, value) in array.enumerated() {
                if value == valueToFind {
                    return index
                }
            }
            return nil
        }
        
        
        
        // MARK: Associated Types 关联类型
        // When defining a protocol, it’s sometimes useful to declare one or more associated types as part of the protocol’s definition. An associated type gives a placeholder name to a type that is used as part of the protocol. The actual type to use for that associated type isn’t specified until the protocol is adopted. Associated types are specified with the associatedtype keyword.
        struct IntStack2: Container {
            var items = [Int]()
            mutating func push(_ item: Int) {
                items.append(item)
            }
            
            mutating func pop() ->Int {
                return items.removeLast()
            }
            
            // conformance to the Container protocol
            typealias Item = Int
            mutating func append(_ item: Item) {
                items.append(item)
            }
            var count: Int {
                return items.count
            }
            subscript(i: Int) -> Item {
                return items[i]
            }
        }
        
        
        
        // Extending an Existing Type to Specify an Associated Type
        // extension Array: Container {}
        
        // Adding Constraints to an Associated Type
        // associatedtype Item: Equatable
        
        var stackOfInts = Stack2<Int>()
        stackOfInts.append(10)
        stackOfInts.append(20)
        stackOfInts.append(30)
        let suffix = stackOfInts.suffix(2)
        // suffix contains 20 and 30
        
        
        
        // MARK: Generic Where Clauses 泛型where语句
        
        
        
        // MARK: Extensions with a Generic Where Clause
        // You can also use a generic where clause as part of an extension. The example below extends the generic Stack structure from the previous examples to add an isTop(_:) method.
        
        
        
        // MARK: Associated Types with a Generic Where Clause
    }
}

// 定义一个自定义的泛型类型
struct Stack<Element> {
    // 不指定具体类型
    var items = [Element]()
    mutating func push (_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
// 泛型的扩展When you extend a generic type, you don’t provide a type parameter list as part of the extension’s definition. Instead, the type parameter list from the original type definition is available within the body of the extension, and the original type parameter names are used to refer to the type parameters from the original definition.
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

protocol Container {
    // define placeholder name
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

protocol Container2 {
    // define placeholder name
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct Stack2<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    mutating func append(_ item: Element) {
        items.append(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

// Extending an Existing Type to Specify an Associated Type，Array类型已经实现了Container协议的方法，秩序做一个关联即可
extension Array: Container {}

// Using a Protocol in Its Associated Type’s Constraints
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack2: SuffixableContainer {
    func suffix(_ size: Int) -> Stack2 {
        var result = Stack2()
        for index in (count - size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack.
}

func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {
        
        // Check that both containers contain the same number of items.
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // Check each pair of items to see if they're equivalent.
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // All items match, so return true.
        return true
}

extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

protocol Container3 {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    // 关联where语句
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}



// MARK: Generic Subscripts
extension Container {
    // 泛型在下标中使用
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result = [Item]()
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}
