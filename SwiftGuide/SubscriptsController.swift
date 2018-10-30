//
//  SubscriptsController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// Subscripts 下标 快捷方式

// Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence. You use subscripts to set and retrieve values by index without needing separate methods for setting and retrieval 下标可以定义在类、结构体和枚举中，是访问集合、列表或序列中元素的快捷方式。可以使用下标的索引，设置和获取值，而不需要再调用对应的存取方法

import UIKit

class SubscriptsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        // Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence. You use subscripts to set and retrieve values by index without needing separate methods for setting and retrieval
        // You can define multiple subscripts for a single type
        
        // MARK: Subscript Syntax
        // Subscripts enable you to query instances of a type by writing one or more values in square brackets after the instance name
        // subscripts can be read-write or read-only

        struct TimesTable {
            var multiplier: Int
            subscript(index: Int) -> Int {
                return index * multiplier
            }
        }
        let threeTimesTable = TimesTable(multiplier: 3)
        print("six times three is \(threeTimesTable[6])")
        // Prints "six times three is 18" shortcuts一步到位
        
        
        
        // MARK: Subscript Usage
        // Dictionary subscripting
        var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        numberOfLegs["bird"] = 2
        //  returns a value of type Int?, or “optional int”
        var a = numberOfLegs["bird"]
        
        
        
        // MARK: Subscript Options
        // Subscripts can take any number of input parameters, and these input parameters can be of any type. Subscripts can also return any type. Subscripts can use variadic parameters, but they can’t use in-out parameters or provide default parameter values.
        struct Matrix {
            let rows, columns: Int
            var grid: [Double]
            init(rows: Int, columns: Int) {
                self.rows = rows
                self.columns = columns
                grid = Array(repeating: 0.0, count: rows * columns)
            }
            func indexIsValid(row: Int, column: Int) -> Bool {
                return row >= 0 && row < rows && column >= 0 && column < columns
            }
            subscript(row: Int, column: Int) -> Double {
                get {
                    assert(indexIsValid(row: row, column: column), "out of range")
                    return grid[row * columns + column]
                }
                set {
                    assert(indexIsValid(row: row, column: column), "out of range")
                    grid[row * columns + column] = newValue
                }
            }
        }
        var matrix = Matrix(rows: 2, columns: 2)
        matrix[0, 1] = 1.5
        matrix[1, 0] = 3.2
        print(matrix[1, 1])
    }
    
    subscript(index: Int) -> Int {
        get {
            // return an appropriate subscript value here
            return 1
        }
        set {
            // perform a suitable setting action here
        }
    }
}
