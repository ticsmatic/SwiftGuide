//
//  PropertiesController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

//  有个默认值叫newValue

import UIKit

class PropertiesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        
        
        // MARK: Stored Properties
        struct FixedLengthRange {
            var firstValue: Int
            let length: Int
        }
        var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
        // the range represents integer values 0, 1, and 2
        rangeOfThreeItems.firstValue = 6
        
        
        // Lazy Stored Properties
        // You must always declare a lazy property as a variable (with the var keyword), because its initial value might not be retrieved until after instance initialization completes. Constant properties must always have a value before initialization completes, and therefore cannot be declared as lazy.
        class DataImporter {
            var filename = "data.txt"
        }
        
        class DataManager {
            lazy var importer = DataImporter()
            var data = [String]()
        }
        

        
        // MARK: Computed Properties
        struct Point {
            var x = 0.0, y = 0.0
        }
        struct Size {
            var width = 0.0, height = 0.0
        }
        struct Rect {
            var origin = Point()
            var size = Size()
            var center: Point {
                get {
                    let centerX = origin.x + size.width / 2
                    let centerY = origin.y + size.height / 2
                    return Point(x: centerX, y: centerY)
                }
//                set (newCenter) {
//                    origin.x = newCenter.x - size.width / 2
//                    origin.y = newCenter.y - size.height / 2
//                }
                set {
                    origin.x = newValue.x - size.width / 2
                    origin.y = newValue.y - size.height / 2
                }
            }
        }
        var square = Rect(origin: Point(x: 0.0, y: 0.0),
                          size: Size(width: 10.0, height: 10.0))
        let initialSquareCenter = square.center
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
        
        
        // Read-Only Computed Properties
        struct Cuboid {
            var width = 0.0, height = 0.0, depth = 0.0
            // A computed property with a getter but no setter is known as a read-only computed property
            var volume: Double {
                return width * height * depth
            }
        }
        
        
        
        // MARK: Property Observers
        // except for lazy stored properties
        // The willSet and didSet observers
        class StepCounter {
            var totalSteps: Int = 0 {
                willSet(newTotalSteps) {
                    print("About to set totalSteps to \(newTotalSteps)")
                }
                didSet {
                    if totalSteps > oldValue  {
                        print("Added \(totalSteps - oldValue) steps")
                    }
                }
            }
        }
        let stepCounter = StepCounter()
        stepCounter.totalSteps = 200
        // About to set totalSteps to 200
        // Added 200 steps
        stepCounter.totalSteps = 360
        // About to set totalSteps to 360
        // Added 160 steps
        stepCounter.totalSteps = 896
        // About to set totalSteps to 896
        // Added 536 steps
        
        
        
        // MARK: Global and Local Variables
        struct SomeStructure {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 1
            }
        }
        enum SomeEnumeration {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 6
            }
        }
        class SomeClass {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 27
            }
            class var overrideableComputedTypeProperty: Int {
                return 107
            }
        }
        
        
        // Querying and Setting Type Properties
        print(SomeStructure.storedTypeProperty)
        // Prints "Some value."
        SomeStructure.storedTypeProperty = "Another value."
        print(SomeStructure.storedTypeProperty)
        // Prints "Another value."
        print(SomeEnumeration.computedTypeProperty)
        // Prints "6"
        print(SomeClass.computedTypeProperty)
        // Prints "27"
        
        struct AudioChannel {
            static let thresholdLevel = 10
            static var maxInputLevelForAllChannels = 0
            var currentLevel: Int = 0 {
                didSet {
                    if currentLevel > AudioChannel.thresholdLevel {
                        // cap the new audio level to the threshold level
                        currentLevel = AudioChannel.thresholdLevel
                    }
                    if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                        // store this as the new overall maximum input level
                        AudioChannel.maxInputLevelForAllChannels = currentLevel
                    }
                }
            }
        }
        
        
        // MARK: Type Properties
    }

}
