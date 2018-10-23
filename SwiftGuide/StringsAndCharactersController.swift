//
//  StringsAndCharactersController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/22.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//
// 1.Swift’s String type is bridged with Foundation’s NSString class
// you can access those NSString methods on String without casting

// 2.substrings aren’t suitable for long-term storage

// 总结：字符串是值安全的，会自动做内存优化；子字符串不适合长久存储，如果需要长久存储，创建新的字符串；
// swift字符串和objc里面的很多方法相似

import UIKit

class StringsAndCharactersController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        // MARK: String Literals
        let someString = "Some string literal value"
        
        // Multiline String Literals
        // 首行和尾行的共同缩进为基准
        let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

    "Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""
        print(quotation)
        
        // Special Characters in String Literals
        // The escaped special characters \0 (null character), \\ (backslash), \t (horizontal tab), \n (line feed), \r (carriage return), \" (double quotation mark) and \' (single quotation mark)
        // An arbitrary Unicode scalar value, written as \u{n}, where n is a 1–8 digit hexadecimal number (Unicode is discussed in Unicode below)
        let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
        // "Imagination is more important than knowledge" - Einstein
        let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
        let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
        let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496
        
        let threeDoubleQuotationMarks = """
Escaping the first quotation mark \"""
Escaping all three quotation marks \"\"\"
"""
        print(threeDoubleQuotationMarks)
        
        
        // MARK: Initializing an Empty String 初始化
        var emptyString = ""               // empty string literal
        var anotherEmptyString = String()  // initializer syntax
        // these two strings are both empty, and are equivalent to each other
        if emptyString.isEmpty {
            print("Nothing to see here")
        }
        // Prints "Nothing to see here"
        
        
        // MARK: String Mutability 字符串可变性
        var variableString = "Horse"
        variableString += " and carriage"
        // variableString is now "Horse and carriage"
        
        let constantString = "Highlander"
        // constantString += " and another Highlander"
        // this reports a compile-time error - a constant string cannot be modified
        
        
        // MARK: Strings Are Value Types 字符串是值类型
        // Swift’s copy-by-default String behavior ensures that when a function or method passes you a String value, it’s clear that you own that exact String value, regardless of where it came from. You can be confident that the string you are passed won’t be modified unless you modify it yourself.
        // Behind the scenes, Swift’s compiler optimizes string usage so that actual copying takes place only when absolutely necessary. This means you always get great performance when working with strings as value types.
        
        
        // MARK: Working with Characters 字符(字符变量只能包含一个字符)
        for character in "Dog!🐶" {
            print(character)
        }
        // D
        // o
        // g
        // !
        // 🐶
        
        let exclamationMark: Character = "!"
        let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
        let catString = String(catCharacters)
        print(catString)
        // Prints "Cat!🐱"
        
        
        // MARK: Concatenating Strings and Characters 字符串和字符串联起来
        let string1 = "hello"
        let string2 = " there"
        var welcome = string1 + string2
        // welcome now equals "hello there"
        
        var instruction = "look over"
        instruction += string2
        // instruction now equals "look over there"
        
        let exclamationMark2: Character = "!"
        welcome.append(exclamationMark2)
        // welcome now equals "hello there!"
        
        let badStart = """
one
two
"""
        let end = """
three
"""
        print(badStart + end)
        // Prints two lines:
        // one
        // twothree
        
        let goodStart = """
one
two

"""
        print(goodStart + end)
        // Prints three lines:
        // one
        // two
        // three
        
        
        // MARK: String Interpolation 字符串插值
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
        // message is "3 times 2.5 is 7.5"
        
        
        // MARK: Unicode
        // Swift’s String and Character types are fully Unicode-compliant
        
        // Unicode Scalar Values (Unicode 标量)
        // U+0061 for LATIN SMALL LETTER A ("a"), or U+1F425 for FRONT-FACING BABY CHICK ("🐥").
        
        // Extended Grapheme Clusters 扩展字形聚类，可以组合
        // An extended grapheme cluster is a sequence of one or more Unicode scalars that (when combined) produce a single human-readable character.
        print("\u{61}", "\u{98}", "u{301}")
        let eAcute: Character = "\u{E9}"                         // é
        let combinedEAcute: Character = "\u{65}\u{301}"          // e followed by
        // eAcute is é, combinedEAcute is é
        print("\u{E9}", "\u{65}", "\u{301}")
        
        let precomposed: Character = "\u{D55C}"                  // 한
        let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
        // precomposed is 한, decomposed is 한
        
        
        // MARK: Counting Characters .count
        let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
        print("unusualMenagerie has \(unusualMenagerie.count) characters")
        unusualMenagerie.count
        // Prints "unusualMenagerie has 40 characters"
        
        
        // MARK: Accessing and Modifying a String 访问和修改字符串
        // Each String value has an associated index type, String.Index, which corresponds to the position of each Character in the string
        // As mentioned above, different characters can require different amounts of memory to store, so in order to determine which Character is at a particular position, you must iterate over each Unicode scalar from the start or end of that String. For this reason, Swift strings can’t be indexed by integer values. 不同的字符占的空间不一样，所以不能用证书作索引，只能从startIndex和endIndex来操作
        
        // String Indices 字符串索引
        let greeting = "Guten Tag!"
        greeting.startIndex
        // greeting[greeting.startIndex]
        print(greeting[greeting.startIndex])
        // G
        greeting[greeting.index(before: greeting.endIndex)]
        // !
        greeting[greeting.index(after: greeting.startIndex)]
        // u
        let index = greeting.index(greeting.startIndex, offsetBy: 7) // -1 !
        greeting[index]
        // a

        // 越界错误
        // greeting[greeting.endIndex] // Error
        // greeting.index(after: greeting.endIndex) // Error
        
        // '.indices' all of the indices of individual characters in a string
        for index in greeting.indices {
            print("\(greeting[index]) ", terminator: "")
        }
        // Prints "G u t e n   T a g ! "
        
        
        // Inserting and Removing
        var welcome2 = "hello"
        welcome2.insert("!", at: welcome2.endIndex)
        // welcome2 now equals "hello!"
        
        welcome2.insert(contentsOf: " there", at: welcome2.index(before: welcome2.endIndex))
        // welcome2 now equals "hello there!"
        
        welcome2.remove(at: welcome2.index(before: welcome2.endIndex))
        // welcome2 now equals "hello there"
        
        let range = welcome2.index(welcome2.endIndex, offsetBy: -6)..<welcome2.endIndex
        welcome2.removeSubrange(range)
        // welcome2 now equals "hello"
        
        
        // MARK: Substrings
        let greeting2 = "Hello, world!"
        let index2 = greeting2.index(of: ",") ?? greeting2.endIndex
        let beginning = greeting2[..<index2]
        // beginning is "Hello"

        // Convert the result to a String for long-term storage.
        let newString = String(beginning)
        
        
        // MARK: Comparing Strings
        // Swift provides three ways to compare textual values: string and character equality, prefix equality, and suffix equality.
        
        // String and Character Equality
        let quotation2 = "We're a lot alike, you and I."
        let sameQuotation = "We're a lot alike, you and I."
        if quotation2 == sameQuotation {
            print("These two strings are considered equal")
        }
        // Prints "These two strings are considered equal"
        
        // "Voulez-vous un café?" using LATIN SMALL LETTER E WITH ACUTE
        let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
        // "Voulez-vous un café?" using LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
        let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
        if eAcuteQuestion == combinedEAcuteQuestion {
            print("These two strings are considered equal")
        }
        // Prints "These two strings are considered equal"
        
        // Prefix and Suffix Equality
        // hasPrefix(_:) and hasSuffix(_:)
        let romeoAndJuliet = [
            "Act 1 Scene 1: Verona, A public place",
            "Act 1 Scene 2: Capulet's mansion",
            "Act 1 Scene 3: A room in Capulet's mansion",
            "Act 1 Scene 4: A street outside Capulet's mansion",
            "Act 1 Scene 5: The Great Hall in Capulet's mansion",
            "Act 2 Scene 1: Outside Capulet's mansion",
            "Act 2 Scene 2: Capulet's orchard",
            "Act 2 Scene 3: Outside Friar Lawrence's cell",
            "Act 2 Scene 4: A street in Verona",
            "Act 2 Scene 5: Capulet's mansion",
            "Act 2 Scene 6: Friar Lawrence's cell"
        ]
        var act1SceneCount = 0
        for scene in romeoAndJuliet {
            if scene.hasPrefix("Act 1 ") {
                act1SceneCount += 1
            }
        }
        print("There are \(act1SceneCount) scenes in Act 1")
        // Prints "There are 5 scenes in Act 1"
        
        let dogString = "AabcdDog‼🐶"
        // Unicode Representations of Strings
        // utf8 utf16
        for codeUnit in dogString.utf16 {
            print("\(codeUnit) ", terminator: "")
        }
        // 65 97 98 99 100 68 111 103 226 128 188 240 159 144 182       utf8
        // 65 97 98 99 100 68 111 103 8252 55357 56374                  utf16
        print("")
        
        for scalar in dogString.unicodeScalars {
            print("\(scalar.value) ", terminator: "")
        }
        // 65 97 98 99 100 68 111 103 8252 128054 
        print("")
    }
}
