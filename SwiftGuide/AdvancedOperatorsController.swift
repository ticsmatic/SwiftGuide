//
//  AdvancedOperatorsController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// 除了基本的运算符，swift还支持高级运算符，比如位运算符、溢出运算符、优先级和结合性、运算符函数、自定义运算符

// 位运算符
// 按位取反运算符
let initialBits: UInt8 = 0b00001111 // 15
let invertedBits = ~initialBits // 等于 0b11110000 240

// 按位与运算符
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits // 等于 00111100

// 按位或运算符
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits // 等于 11111110

// 按位异或运算符
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits // 等于 00010001

// 按位左移、右移运算符 将一个整数左移一位，等价于将这个数乘以 2，同样地，将一个整数右移一位，等价于将这个数除以 2。

// 溢出运算符
// 溢出加法 &+
// 溢出减法 &-
// 溢出乘法 &*
func bitFunc() {
    var unsignedOverflow = UInt8.max
    // unsignedOverflow 等于 UInt8 所能容纳的最大整数 255
    unsignedOverflow = unsignedOverflow &+ 1
    // 此时 unsignedOverflow 等于 0
    // unsignedOverflow 被初始化为 UInt8 所能容纳的最大整数（255，以二进制表示即 11111111）。然后使用了溢出加法运算符（&+）对其进行加 1 运算。这使得它的二进制表示正好超出 UInt8 所能容纳的位数，也就导致了数值的溢出，如下图所示。数值溢出后，留在 UInt8 边界内的值是 00000000，也就是十进制数值的 0。
}

// 运算符函数

// 自定义运算符
// 新的运算符要使用 operator 关键字在全局作用域内进行定义，同时还要指定 prefix、infix 或者 postfix 修饰符：
prefix operator +++

struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}

extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
// toBeDoubled 现在的值为 (2.0, 8.0)
// afterDoubling 现在的值也为 (2.0, 8.0)

import UIKit

class AdvancedOperatorsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        
    }
}
