//
//  ErrorHandlingController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// Swift provides first-class support for throwing, catching, propagating, and manipulating recoverable errors at runtime. 抛、捕、转、处理异常

// do-try defer

import UIKit

class ErrorHandlingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        // MARK: Representing and Throwing Errors
        // In Swift, errors are represented by values of types that conform to the Error protocol.
        enum VendingMachineError: Error {
            case invalidSelection
            case insufficientFunds(coinsNeeded: Int)
            case outOfStock
        }
        
        
        // MARK: Handling Errors
        // Propagating Errors Using Throwing Functions
        struct Item {
            var price: Int
            var count: Int
        }
        
        class VendingMachine {
            var inventory = [
                "Candy Bar": Item(price: 12, count: 7),
                "Chips": Item(price: 10, count: 4),
                "Pretzels": Item(price: 7, count: 11)
            ]
            var coinsDeposited = 0
            
            func vend(itemNamed name: String) throws {
                guard let item = inventory[name] else {
                    // 再抛出去
                    throw VendingMachineError.invalidSelection
                }
                
                guard item.count > 0 else {
                    throw VendingMachineError.outOfStock
                }
                
                guard item.price <= coinsDeposited else {
                    throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
                }
                
                coinsDeposited -= item.price
                
                var newItem = item
                newItem.count -= 1
                inventory[name] = newItem
                
                print("Dispensing \(name)")
            }
        }
        
        let favoriteSnacks = [
            "Alice": "Chips",
            "Bob": "Licorice",
            "Eve": "Pretzels",
            ]
        // 这个方法可能会抛出异常，所以调用的时候前面要加try
        func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
            let snackName = favoriteSnacks[person] ?? "Candy Bar"
            try vendingMachine.vend(itemNamed: snackName)
        }

        struct PurchasedSnack {
            let name: String
            init(name: String, vendingMachine: VendingMachine) throws {
                try vendingMachine.vend(itemNamed: name)
                self.name = name
            }
        }
        
        
        // Handling Errors Using Do-Catch 处理
        /*
         do {
            try expression
            statements
         } catch pattern 1 {
            statements
         } catch pattern 2 where condition {
            statements
         } catch {
            statements
         }
         */
        var vendingMachine = VendingMachine()
        vendingMachine.coinsDeposited = 8
        do {
            try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
            print("Success! Yum.")
        } catch VendingMachineError.invalidSelection {
            print("Invalid Selection.")
        } catch VendingMachineError.outOfStock {
            print("Out of Stock.")
        } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
             print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
        } catch {
            print("Unexpected error: \(error).")
        }
        
        
        // 内部执行，catch is判断错误先处理一部分
        func nourish(with item: String) throws {
            do {
                try vendingMachine.vend(itemNamed: item)
            } catch is VendingMachineError {
                print("Invalid selection, out of stock, or not enough money.")
            }
        }
        do {
            try nourish(with: "Beet-Flavored Chips")
        } catch {
            print("Unexpected non-vending-machine-related error: \(error)")
        }
        // Prints "Invalid selection, out of stock, or not enough money."
        
        
        // Converting Errors to Optional Values
        func someThrowingFunction() throws -> Int {
            // ...
            return 1
        }
        
        let x = try? someThrowingFunction()
        
        let y: Int?
        do {
            y = try someThrowingFunction()
        } catch {
            y = nil
        }
        print(x, y)
        
//        func fetchData() -> Data? {
//            if let data = try? fetchDataFromDisk() { return data }
//            if let data = try? fetchDataFromServer() { return data }
//            return nil
//        }
        
        
        // Disabling Error Propagation
        // loads the image resource at a given path or throws an error if the image can’t be loaded
        // let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
        
        
        
        // MARK: Specifying Cleanup Actions
        // Use defer to write a block of code that is executed after all other code in the function, just before the function returns.The code is executed regardless of whether the function throws an error.. You can use defer to write setup and cleanup code next to each other, even though they need to be executed at different times.
        /*
        func processFile(filename: String) throws {
            if exists(filename) {
                let file = open(filename)
                defer {
                    close(file)
                }
                while let line = try file.readline() {
                    // Work with the file.
                }
                // close(file) is called here, at the end of the scope.
            }
        }
         */
    }
}
