//
//  TourViewController.swift
//  swiftTour
//
//  Created by ticsmatic on 2018/10/18.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//  swift是一门比较新的语言，意味着它在设计之初，必然会吸取其它现代语言的特点，结果是简洁、灵活，有各种你属性的语言的影子，比如说js，java，设置和kotlin的相似性
//  swift是一门值得尝试的语言，和objc相比它的简洁程度就值得一试
//  注意在学习的时候考虑该语言的作者为什么这么设计，以及语言的共通性，其它语言是如何表示的

import UIKit

class TourViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        print("Hello, world!")
        // 简单的值
        simpleValues()
        
        // 控制流
        controlFlow()
        
        // 函数和闭包
        functionsAndClosures()
        
        // 对象和类
        ObjectsAndClasses()
        
        // 枚举和结构体
        enumerationsAndStructures()
        
        // 错误处理
        errorHandling()
        
        // 泛型
        generics()
    }
    
    /// swift 中的一些变量，字符串，数组的快速入门
    func simpleValues() {
        // 变量
        var myVariable = 42
        myVariable = 50
        let myConstant = 42
        
        
        // 声明类型
        let implicitInteger = 70
        let implicitDouble = 70.0
        let explicitDouble: Double = 70
        let explicitConstantFloadt: Float = 4.0
        
        
        // 类型转换
        let label = "The width is "
        let width = 94
        let widthLabel = label + String(width)
        
        // 有一种更简单的把值转换成字符串的方法：把值写到括号中，并且在括号之前写一个反斜杠（\）。例如：
        let apples = 3
        let oranges = 5
        let appleSummary = "I have \(apples) apples."
        
        // 使用一对三个单引号（"""）来包含多行字符串内容，字符串中的内容（包括引号、空格、换行符等）都会保留下来
        let quotation = """
        I said "I have \(apples) apples."
        And then I said "I have \(apples + oranges) pieces of fruit."
        """
        
        
        // 数组
        // 使用方括号 [] 来创建数组和字典，并使用下标或者键（key）来访问元素。最后一个元素后面允许有个逗号
        var shoppingList = ["water", "fish", "toufu", "milk"]
        // 修改某个元素
        shoppingList[0] = "bottle of water"
        var occupations = [
            "Tom": "Captain",
            "Jack": "Mechanic"
        ]
        occupations["Jayne"] = "Public Relations"
        print(occupations)
        
        // 空数组
        let emptyArray = [String]()
        let emptyDictionary = [String: Float]()
        
        shoppingList = []
        occupations = [:]
    }
    
    /// 控制流，如 if switch for while
    func controlFlow() {
        let individualScores = [75, 43, 103, 87, 12]
        var teamScore = 0
        for score in individualScores {
            // if的判断条件必须是bool表达式
            if score > 50 {
                teamScore += 3
            } else {
                teamScore += 1
            }
        }
        print(teamScore)
        
        
        // 可选值 和 if
        // Write a question mark (?) after the type of a value to mark the value as optional
        var optionalString: String? = "hhhhhhh"
        print(optionalString == nil)
        
        var optionalName: String? = "John Appleseed"
        var greeting = "Hello!"
        if let name = optionalName {
            greeting = "hello, \(name)"
        }
        print(greeting)
        
        // Another way to handle optional values is to provide a default value using the ?? operator. If the optional value is missing, the default value is used instead.
        let nickName: String? = nil
        let fullName: String = "John Appleseed"
        // 如果??前面的可选值为空，就会用一个默认值fullName来替代
        let informalGreeting = "Hi \(nickName ?? fullName)"
        
        
        // switch
        let vegtable = "red pepper"
        // 匹配到之后就会执行完并退出，所以不用写break
        switch vegtable {
        case "celery":
            print("Add some raisins and make ants on a log.")
        case "cucumber", "watercress":
            print("That would make a good tea sandwich.")
        case let x where x.hasSuffix("pepper"):
            print("Is it a spicy \(x)?")
        default:
            print("Everything tastes good in soup.")
        }
        
        
        // forin
        let interestingNumbers = [
            "Prime": [2, 3, 5, 7, 11, 13],
            "Fibonacci": [1, 1, 2, 3, 5, 8],
            "Square": [1, 4, 9, 16, 25],
            ]
        var largest = 0
        var largestNumKind: String? = nil
        for (kind, numbers) in interestingNumbers {
            for number in numbers {
                if number > largest {
                    largest = number
                    largestNumKind = kind
                }
            }
        }
        print(largestNumKind!, largest)
        // Prints "25"
        
        
        // while
        var n = 0
        var whileSum = 0
        while n < 100 {
            n += 1
            whileSum += n
        }
        print(n , whileSum)
        // Prints "100 5050"
        
        var m = 2
        repeat {
            m *= 2
        } while m < 100
        print(m)
        // Prints "128"
        
        
        // ..< to make a range of indexes, ..< to make a range that omits its upper value, and use ... to make a range that includes both values
        var total = 0
        for i in 0..<4 {
            total += i;
        }
        print(total)
        // Prints "6"
    }
    
    /// 函数和闭包
    func functionsAndClosures() {
        /// Use func to declare a function. Call a function by following its name with a list of arguments in parentheses. Use -> to separate the parameter names and types from the function’s return type.
        func greet(person: String, day: String) -> String {
            return "Hello \(person), today is \(day)."
        }
        greet(person: "Bob", day: "Tuesday")
        
        /// 参数名称前可以自定义参数标签，或者使用 _ 表示不使用参数标签
        func greet2(_ person: String, on day: String ) -> String {
            return "Hello \(person), today is \(day)"
        }
        greet2("Mick", on: "Wednesday")
        
        /// 函数返回多个值
        func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
            var min = scores[0];
            var max = scores[0];
            var sum = 0;
            
            for score in scores {
                if score > max {
                    max = score
                }
                if score < min {
                    min = score
                }
                sum += score
            }
            
            return (min, max, sum)
        }
        let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
        print(statistics.sum)
        // Prints "120"
        print(statistics.2)
        // Prints "120"
        
        
        /// 函数可以嵌套，嵌套函数可以访问外部函数逇变量，使用嵌套函数可以重构一个长的或者复杂的函数
        func returnFifteen() ->Int {
            var y = 10
            func add() {
                y += 5
            }
            add()
            return y
        }
        returnFifteen()
        
        /// Functions are a first-class type. This means that a function can return another function as its value. 函数可以返回另一个函数
        func makeIncrementer() -> ((Int) -> Int) {
            func addOne(number: Int) -> Int {
                return 1 + number
            }
            return addOne
        }
        // 这个函数的返回值是另一个函数
        var increment = makeIncrementer()
        increment(7)
        
        /// A function can take another function as one of its arguments. 函数的参数可以为函数
        func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
            for item in list {
                if condition(item) {
                    return true;
                }
            }
            return false
        }
        func lessThanTen(number: Int) -> Bool {
            return number < 10
        }
        var numbers = [20, 19, 7, 12]
        hasAnyMatches(list: numbers, condition: lessThanTen)
        
        
        /// 函数是一种特殊的闭包:它是一段能之后被调取的代码。闭包中的代码能访问闭包作用域中的变量和函数，即使闭包是在一个不同的作用域被执行的 - 你已经在嵌套函数的例子中看过了。你可以使用 {} 来创建一个匿名闭包。使用 in 将参数和返回值类型的声明与闭包函数体进行分离。
        numbers.map {
            (number: Int) -> Int in
            let result = 3 * number
            return result
        }
        numbers.map {
            (number: Int) -> Int in
            if number % 2 == 0 {
                return number
            } else {
                return 0
            }
        }
        
        // 有很多种创建更简洁的闭包的方法。如果一个闭包的类型已知，比如作为一个代理的回调，你可以忽略参数，返回值，甚至两个都忽略。单个语句闭包会把它语句的值当做结果返回。
        let mappedNumbers = numbers.map({number in 3 * number})
        print(mappedNumbers)
        
        // 你可以通过序号而不是名字来引用参数，这在短闭包中很有用。当一个闭包作为最后一个参数传给一个函数的时候，它可以直接跟在括号后面。当一个闭包是传给函数的唯一参数，你可以完全忽略括号
        let sortedNumbers = numbers.sorted { $0 < $1 }
        print(sortedNumbers)
    }
    
    /// 对象和类
    func ObjectsAndClasses() {
        // Use class followed by the class’s name to create a class. A property declaration in a class is written the same way as a constant or variable declaration, except that it is in the context of a class
        
        class Shape {
            var numberOfSides = 0
            func simpleDescription() -> String {
                return "A shape with \(numberOfSides) sides."
            }
        }
        // 使用点语法来访问属性和方法
        var shape = Shape()
        shape.numberOfSides = 100
        shape.simpleDescription()
        
        // 初始化方法
        // an initializer to set up the class when an instance is created. Use init to create one.
        class NamedShape {
            var numberOfSides: Int = 0
            var name: String
            
            /// 构造函数
            init(name: String) {
                self.name = name
            }
            
            /// 销毁的析构函数
            deinit {
                
            }
            
            func simpleDescription() -> String {
                return "A shape with \(numberOfSides) sides."
            }
        }
        var namedShape = NamedShape(name: "长方形")
        
        // 在对象被销毁前的析构函数 deinit
        // Use deinit to create a deinitializer if you need to perform some cleanup before the object is deallocated.
        
        // 子类，没有根类
        // 子类如果要重写父类的方法的话，需要用 override 标记——如果没有添加 override 就重写父类方法的话编译器会报错。编译器同样会检测 override 标记的方法是否确实在父类中。
        class Square: NamedShape {
            var sideLength: Double
            
            init(sideLength: Double, name: String) {
                self.sideLength = sideLength
                super.init(name: name)
                numberOfSides = 4
            }
            
            func area() -> Double {
                return sideLength * sideLength
            }
            
            /// override
            override func simpleDescription() -> String {
                return "A square with sides of length \(sideLength)."
            }
        }
        let test = Square(sideLength: 5.5, name: "my test square")
        test.area()
        test.simpleDescription()
        
        
        // 除了存储简单的属性，属性还有getter和setter
        class EquilateralTriangle: NamedShape {
            var sideLength: Double = 0.0
            
            init(sideLength: Double, name: String) {
                self.sideLength = sideLength
                super.init(name: name)
                numberOfSides = 3
            }
            
            /// 类中一个变量的get和set方法
            var perimeter: Double {
                get {
                    return 3.0 * sideLength
                } set {
                    sideLength = newValue / 3.0
                }
            }
            
            override func simpleDescription() -> String {
                return "An equilateral triangle with sides of length \(sideLength)."
            }
        }
        var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
        print(triangle.perimeter)
        // Prints "9.3"
        triangle.perimeter = 9.9
        print(triangle.sideLength)
        // Prints "3.3000000000000003"
        // 定义 EquilateralTriangle 类的过程，主要分这三步
        // 1.设置子类声明
        // 2.调用父类构造器
        // 3.改变父类定义的属性的值，setter和getter也可以在这个过程完成
        
        
        // willSet didSet, 在构造函数中不能触发
        class TriangleAndSquare {
            // 对象的属性方法
            var triangle: EquilateralTriangle {
                willSet {
                    print("will Set hook")
                    triangle.sideLength = newValue.sideLength
                }
            }
            
            var square: Square {
                willSet {
                    square.sideLength = newValue.sideLength
                }
            }
            
            init(size: Double, name: String) {
                square = Square(sideLength: size, name: name)
                triangle = EquilateralTriangle(sideLength: size, name: name)
            }
        }
        var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
        print(triangleAndSquare.square.sideLength)
        // Prints "10.0"
        print(triangleAndSquare.triangle.sideLength)
        // Prints "10.0"
        triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
        print(triangleAndSquare.triangle.sideLength)
        // Prints "50.0"
        
        
        // 当使用可选值的时候，可以在操作前使用？，如果可选值是nil，？后面的操作都会忽略，整个表达式的值会为nil。否则? 之后的东西都会被运行
        let optionalSquare: Square? = Square(sideLength: 2.5, name: "e hehhe ")
        let sideLength = optionalSquare?.sideLength
    }
    
    /// 枚举和结构体
    func enumerationsAndStructures() {
        // 枚举可以包含方法
        
        enum Rank: Int {
            case ace = 1
            case two, three, four, five, six, seven, eight, nine, ten
            case jack, queen, king
            
            func simpleDescription() -> String {
                switch self {
                case .ace:
                    return "ace"
                case .jack:
                    return "jack"
                case .queen:
                    return "queen"
                case .king:
                    return "king"
                default:
                    // raw type 对应原始值.
                    return String(self.rawValue)
                }
            }
        }
        let ace = Rank.ace
        // rawValue属性来访问一个枚举成员的原始值
        let aceRawValue = ace.rawValue
        
        // 枚举的构造函数，传递参数3
        if let convertedRank = Rank(rawValue: 3) {
            let threeDescription = convertedRank.simpleDescription()
        }
        // 枚举中的case是真实值，而不是原始值（rawValue）
        enum Suit {
            case spades, hearts, diamonds, clubs
            
            func simpleDescription() -> String {
                switch self {
                case .spades:
                    return "spades"
                case .hearts:
                    return "hearts"
                case .diamonds:
                    return "diamonds"
                case .clubs:
                    return "clubs"
                }
            }
            func color() -> String {
                switch self {
                case .spades, .clubs:
                    return "black"
                case .hearts, .diamonds:
                    return "red"
                }
            }
        }
        let hearts = Suit.hearts
        let heartsDescription = hearts.simpleDescription()
        
        
        // 如果枚举中有原始值，这些值在声明的时候就已经确定了，这意味着不同枚举实例的枚举成员总会有一个相同的原始值。
        // 当然我们也可以为枚举成员设定关联值，关联值是在创建实例时决定的。这意味着不同的枚举成员的关联值都可以不同。
        // 你可以把关联值想象成枚举成员的寄存属性。例如，考虑从服务器获取日出和日落的时间的情况。服务器会返回正常结果或者错误信息。
        enum ServerResponse {
            case result(String, String)
            case failure(String)
        }
        
        let success = ServerResponse.result("6:00 am", "8:09 pm")
        let failure = ServerResponse.failure("Out of cheese.")
        
        // 判断枚举值
        switch success {
        case let .result(sunrise, sunset):
            print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
        case let .failure(message):
            print("Failure...  \(message)")
        }
        // Prints "Sunrise is at 6:00 am and sunset is at 8:09 pm."
        
        
        /// struct
        /// 结构体像类一样支持很多行为，如方法和构造器。和类最主要的区别是结构体是传值，类是传递引用
        struct Card {
            var rank: Rank
            var suit: Suit
            func simpleDescription() -> String {
                return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
            }
        }
        let threeOfSpades = Card(rank: .three, suit: .spades)
        let threeOfSpadesDescription = threeOfSpades.simpleDescription()
    }
    
    /// 协议和继承
    func ProtocolAndExtensions() {
        // 类，枚举，结构体都可以遵守协议
        // 遵守协议就需要实现协议里的属性和方法
        class SimpleClass: ExampleProtocol {
            var simpleDescription: String = "A very simple class."
            var anotherProperty: Int = 69105
            
            func adjust() {
                simpleDescription += "  Now 100% adjusted."
            }
        }
        var a = SimpleClass()
        a.adjust()
        let aDescription = a.simpleDescription
        
        /// 结构体遵守协议
        struct SimpleStructure: ExampleProtocol {
            var simpleDescription: String = "A simple structure"
            
            mutating func adjust() {
                simpleDescription += " (adjusted)"
            }
        }
        var b = SimpleStructure()
        b.adjust()
        let bDescription = b.simpleDescription
        
        struct MyStruce {
            var var1 = 1
        }
        
        // mutating
        // 注意声明 SimpleStructure 时候 mutating 关键字用来标记一个会修改结构体的方法。
        // SimpleClass 的声明不需要标记任何方法，因为类中的方法通常可以修改类属性（类的性质）
        
        
        // extension
        // 使用extension关键字为已存在的类型添加新的功能，比如说方法和计算属性，可以给一个协议增加实现，也可以给系统类增加extension
        7.simpleDescription
        // Prints "The number 7"
        
        let protocolValue: ExampleProtocol = a
        print(protocolValue.simpleDescription)
    }
    
    /// 错误处理
    func errorHandling() {
        // 扩展：在swift中，协议的使用要比objc普遍的多，协议是一个类型，使用起来更加灵活，包括上面学习的枚举和结构体，要比objc的灵活很多
        
        // 使用遵守Error协议的类型来表示错误
        enum PrinterError: Error {
            case outOfPaper
            case noToner
            case onFire
        }
        
        // throw
        // 用throw关键字抛出错误，如果抛出错误一个错误，这个函数会立马返回，并且调用该函数的代码会进行错误处理
        func send(job: Int, toPrinter printerName: String) throws -> String {
            if printerName == "Never Has Toner" {
                throw PrinterError.noToner
            }
            return "Job send"
        }
        
        // 错误处理之do-catch
        do {
            let printerResponse = try send(job: 1024, toPrinter: "Bi Sheng")
            print(printerResponse)
        } catch PrinterError.onFire  {
            print("I'll just put this over here, with the rest of the fire.")
        } catch let printerError as PrinterError {
            print("Printer error: \(printerError).")
        } catch {
            print(error)
        }
        
        // 错误处理之 try?
        // try? to convert the result to an optional. If the function throws an error, the specific error is discarded and the result is nil
        let printerSuccess = try? send(job: 111, toPrinter: "Mergenthaler")
        let printerError = try? send(job: 90909, toPrinter: "Never Has Toner")
        
        // defer
        // Use defer to write a block of code that is executed after all other code in the function, just before the function returns.The code is executed regardless of whether the function throws an error.. You can use defer to write setup and cleanup code next to each other, even though they need to be executed at different times.
        var fridgeIsOpen = false
        let fridgeContent = ["milk", "eggs", "leftovers"]
        func fridgeContains(_ food: String) -> Bool {
            fridgeIsOpen = true
            defer {
                fridgeIsOpen = false
            }
            let result = fridgeContent.contains(food)
            return result
        }
        fridgeContains("banana")
        print(fridgeIsOpen)
    }
    
    /// 泛型
    func generics() -> Void {
        // Write a name inside angle brackets to make a generic function or type.
        func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
            // var result = [String]()
            var result = [Item]()
            for _ in 0..<numberOfTimes {
                result.append(item)
            }
            return result
        }
        let ret = makeArray(repeating: "knock", numberOfTimes: 4)
        print(ret)
        
        // You can make generic forms of functions and methods, as well as classes, enumerations, and structures.
        // 创建泛型函数，类，枚举，结构体
        enum OptionalValue<Wrapped> {
            case none
            case some(Wrapped)
        }
        var possibleInteger: OptionalValue<Int> = .none
        possibleInteger = .some(10)
        
        // where
        // Use where right before the body to specify a list of requirements—for example, to require the type to implement a protocol, to require two types to be the same, or to require a class to have a particular superclass.
        // where限定要求
        func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool where T.Element: Equatable, T.Element == U.Element {
            for lhsItem in lhs {
                for rhsItem in rhs {
                    if lhsItem == rhsItem {
                        return true
                    }
                }
            }
            return false
        }
        anyCommonElements([1, 2, 3], [3])
    }
}

extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "number is \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}

/// protocol
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}
