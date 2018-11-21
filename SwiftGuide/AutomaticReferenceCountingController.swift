//
//  AutomaticReferenceCountingController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// swift 内存回收使用的是ARC机制，和objc中的ARC一样

// swift也会有循环引用的发生，为何发生不解释。
// 解决方法就是使用weak和unowned关键字
// weak和unowned关键字使用区别：
// weak修饰的属性会在属性被销毁的时候自动置为nil，所以只能用var修饰  var apartment: Apartment?
// unowned reference修饰的属性声明期更长，像“信用对象”里面的“人”的属性，人的生命期更长，“有信用肯定有人”，而weak相反

// 闭包中的使用（objc的Block）
class HTMLElement {
    
    let name: String
    let text: String?
    
    // 在闭包中，一般我们显示的指明self，用来指明这个闭包内部引用self
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}



import UIKit

class AutomaticReferenceCountingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        lazy var someClosure: (Int, String) -> String = {
//            [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
//            // closure body goes here
//        }
    }

}
