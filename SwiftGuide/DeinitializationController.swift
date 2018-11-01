//
//  DeinitializationController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

import UIKit

class DeinitializationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        // A deinitializer is called immediately before a class instance is deallocated. You write deinitializers with the deinit keyword, similar to how initializers are written with the init keyword. Deinitializers are only available on class types.
        
        // MARK: How Deinitialization Works
        // Swift handles the memory management of instances through automatic reference counting (ARC)
        // For example, if you create a custom class to open a file and write some data to it, you might need to close the file before the class instance is deallocated.
       
        
        // MARK: Deinitializers in Action
        class Bank {
            static var coinsInBank = 10_000
            static func distribute(coins numberOfCoinsRequested: Int) -> Int {
                let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
                coinsInBank -= numberOfCoinsToVend
                return numberOfCoinsToVend
            }
            static func receive(coins: Int) {
                coinsInBank += coins
            }
        }
        class Player {
            var coinsInPurse: Int
            init(coins: Int) {
                coinsInPurse = Bank.distribute(coins: coins)
            }
            func win(coins: Int) {
                coinsInPurse += Bank.distribute(coins: coins)
            }
            // 玩家死了或者没了，它的💰返回到银行
            deinit {
                Bank.receive(coins: coinsInPurse)
            }
        }
        var playerOne: Player? = Player(coins: 100)
        print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
        // Prints "A new player has joined the game with 100 coins"
        print("There are now \(Bank.coinsInBank) coins left in the bank")
        // Prints "There are now 9900 coins left in the bank"

        playerOne!.win(coins: 2_000)
        print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
        // Prints "PlayerOne won 2000 coins & now has 2100 coins"
        print("The bank now only has \(Bank.coinsInBank) coins left")
        // Prints "The bank now only has 7900 coins left"

        playerOne = nil
        print("PlayerOne has left the game")
        // Prints "PlayerOne has left the game"
        print("The bank now has \(Bank.coinsInBank) coins")
        // Prints "The bank now has 10000 coins"
    }

    // Deinitializers are called automatically, just before instance deallocation takes place.
    deinit {
        // perform the deinitialization
    }
}
