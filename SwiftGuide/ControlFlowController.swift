//
//  ControlFlowController.swift
//  SwiftGuide
//
//  Created by ticsmatic on 2018/10/24.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// while, for-in
// if guard switch
// break continue

// Swift’s switch statement is more powerful than its counterpart in many C-like languages

// for-in stride(from:to:by:)

// 总结：swift的switch语句支持的case值比较广泛，所以相对比价强大；同时还有一个guard true else语句

import UIKit

class ControlFlowController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        // MARK: For-In Loops
        
        // array, ranges of numbers, or characters in a string, dictionary
        let names = ["Anna", "Alex", "Brian", "Jack"]
        for name in names {
            print("Hello, \(name)!")
        }
        
        let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        for (animalName, legCount) in numberOfLegs {
            print("\(animalName)s have \(legCount) legs")
        }
        
        for index in 1...5 {
            print("\(index) times 5 is \(index * 5)")
        }
        
        // stride(from:to:by:)
        for tickMark in stride(from: 0, to: 60, by: 5) {
            // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
        }
        // stride(from:through:by:)  and possibly including, an end value
        for tickMark in stride(from: 3, through: 12, by: 3) {
            // render the tick mark every 3 hours (3, 6, 9, 12)
        }
      
        
        // MARK: While Loops
        var sum = 0
        var i = 0
        while i < 10 {
            sum += i;
            i += 1
        }
        print(sum)
        
        // Repeat-While do-while
        repeat {
            sum += i
            i += 1
        } while i < 20
        print(sum)
        
        
        // MARK: Conditional Statements
        // If
        var temperatureInFahrenheit = 90
        if temperatureInFahrenheit <= 32 {
            print("It's very cold. Consider wearing a scarf.")
        } else if temperatureInFahrenheit >= 86 {
            print("It's really warm. Don't forget to wear sunscreen.")
        } else {
            print("It's not that cold. Wear a t-shirt.")
        }
        // Prints "It's really warm. Don't forget to wear sunscreen."
        
        // Switch
        let someCharacter: Character = "z"
        switch someCharacter {
        case "a":
            print("The first letter of the alphabet")
        case "z":
            print("The last letter of the alphabet")
        default:
            print("Some other character")
        }

        let anotherCharacter: Character = "a"
        switch anotherCharacter {
        case "x": break // Invalid, the case has an empty body
        case "A", "a":
            print("The letter A")
        default:
            print("Not the letter A")
        }
        
        let approximateCount = 62
        let countedThings = "moons orbiting Saturn"
        let naturalCount: String
        switch approximateCount {
        case 0:
            naturalCount = "no"
        case 1..<5:
            naturalCount = "a few"
        case 5..<12:
            naturalCount = "several"
        case 12..<100:
            naturalCount = "dozens of"
        case 100..<1000:
            naturalCount = "hundreds of"
        default:
            naturalCount = "many"
        }
        print("There are \(naturalCount) \(countedThings).")
        // Prints "There are dozens of moons orbiting Saturn."
        
        // Tuples
        let somePoint = (1, 1)
        switch somePoint {
        case (0, 0):
            print("\(somePoint) is at the origin")
        case (_, 0):
            print("\(somePoint) is on the x-axis")
        case (0, _):
            print("\(somePoint) is on the y-axis")
        case (-2...2, -2...2):
            print("\(somePoint) is inside the box")
        default:
            print("\(somePoint) is outside of the box")
        }
        // Prints "(1, 1) is inside the box"
        
        // Value Bindings
        // A switch case can name the value or values it matches to temporary constants or variables, for use in the body of the case
        let anotherPoint = (2, 0)
        switch anotherPoint {
        case (let x, 0):
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y):
            print("somewhere else at (\(x), \(y))")
        }
        // Prints "on the x-axis with an x value of 2"
        
        // Where
        // A switch case can use a where clause to check for additional conditions.
        let yetAnotherPoint = (1, -1)
        switch yetAnotherPoint {
        case let (x, y) where x == y:
            print("(\(x), \(y)) is on the line x == y")
        case let (x, y) where x == -y:
            print("(\(x), \(y)) is on the line x == -y")
        case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        // Prints "(1, -1) is on the line x == -y"
        

        let stillAnotherPoint = (9, 0)
        switch stillAnotherPoint {
        case (let distance, 0), (0, let distance):
            print("On an axis, \(distance) from the origin")
        default:
            print("Not on an axis")
        }
        // Prints "On an axis, 9 from the origin"
        
        
        
        // MARK: Control Transfer Statements
        // continue
        // break
        // fallthrough
        // return
        // throw
        
        // continue
        let puzzleInput = "great minds think alike"
        var puzzleOutput = ""
        let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
        for character in puzzleInput {
            if charactersToRemove.contains(character) {
                continue
            }
            puzzleOutput.append(character)
        }
        print(puzzleOutput)
        // Prints "grtmndsthnklk"
        
        // Break
        // Break in a Loop Statement
        // Break in a Switch Statement
        
        // Fallthrough
        // The fallthrough keyword does not check the case conditions for the switch case that it causes execution to fall into. The fallthrough keyword simply causes code execution to move directly to the statements inside the next case (or default case) block, as in C’s standard switch statement behavior.
        
        let myInterger = 11
        switch myInterger {
        case let x where x > 5:
            print("大于10，fallthrough 关键字，落入下一个case语句并继续执行")
            fallthrough
        case 10:
            print(10)
        case 11:
            print(11)
        default:
            print("这是default")
        }
        
        
        // Labeled Statements 给语句起一个标签名，用于复杂嵌套时，指明break或者continue哪个语句
        let finalSquare = 25
        var square = 0
        var diceRoll = 0
        var board = [Int](repeating: 0, count: finalSquare + 1)
        gameLoop: while square != finalSquare {
            diceRoll += 1
            if diceRoll == 7 { diceRoll = 1 }
            switch square + diceRoll {
            case finalSquare:
                // diceRoll will move us to the final square, so the game is over
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                // diceRoll will move us beyond the final square, so roll again
                continue gameLoop
            default:
                // this is a valid move, so find out its effect
                square += diceRoll
                square += board[square]
            }
        }
        print("Game over!")

        
        // MARK: Early Exit
        // A guard statement, like an if statement, executes statements depending on the Boolean value of an expression.
        // You use a guard statement to require that a condition must be true !
        // in order for the code after the guard statement to be executed. Unlike an if statement, a guard statement always has an else clause—the code inside the else clause is executed if the condition is not true.
        // guard else
        func greeting(person: [String: String]) {
            guard let name = person["name"] else {
                return
            }
            print("Hello \(name)!")

            guard let location = person["location"] else {
                print("I hope the weather is nice near you.")
                return
            }
            print("I hope the weather is nice in \(location).")
        }
        greeting(person: ["name": "wxq", "location": "bj"])
        
        
        
        // MARK: Checking API Availability
        // if #available(<#T##Platform...##Platform#>, *)
        if #available(iOS 10, macOS 10.12, *) {
            
        } else {
            
        }
    }

}
