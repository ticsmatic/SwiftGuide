//
//  MemorySafetyController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// swift也会有做内存的安全访问、比如说坏内存访问、数组越界、并发读写等

// inout 冲突访问

// mutating能够修改结构体里面的self

// 访问属性冲突

import UIKit
class MemorySafetyController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        var stepSize = 1
        // 写
        func increment(_ number: inout Int) {
            // 读
            number += stepSize
        }
        // increment(&stepSize)
        // Error: conflicting accesses to stepSize
        // Make an explicit copy.
        var copyOfStepSize = stepSize
        increment(&copyOfStepSize)
        
        // Update the original.
        stepSize = copyOfStepSize
        // stepSize is now 2
        
        
    }
}

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}
extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

