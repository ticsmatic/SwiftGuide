//
//  AccessControlController.swift
//  SwiftGuide
//
//  Created by Ticsmatic on 2018/10/25.
//  Copyright © 2018年 ticsmatic. All rights reserved.
//

// swift的文件内容访问权限

// swift有module（模块）概念

// 访问等级：
// open、public
// internal (模块、框架)
// fileprivate
// private

// 访问级别的原则：实体内的访问权限级别不能更低（不能在实体内定义访问级别更低的实体）
// 默认访问级别：internal
// 单target的访问级别：默认所有代码都是为这个APPmodule服务，是internal，一般情况不用设置，如果想隐藏一些实现，可以使用fileprivate或private
// framework的访问级别：对外的接口写成public，实现细节可以使用默认的internal
// 单元测试：单元测试是一个target，访问内部代码的话，只有public才可以被访问。然而，如果在模块导入前声明@testable的话，（Build Options -> Enable Testability）单元测试可以访问人一个实体

// 访问控制语法
public class SomePublicClass {} // public internal fileprivate private
public var somePublicVariable = 0 // public internal fileprivate private
fileprivate func someFilePrivateFunction() {} // public internal fileprivate private

// 自定义类型
public class SomePublicClass2 {                  // explicitly public class
    public var somePublicProperty = 0            // explicitly public class member
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

class SomeInternalClass {                       // implicitly internal class
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

fileprivate class SomeFilePrivateClass {        // explicitly file-private class
    func someFilePrivateMethod() {}              // implicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

private class SomePrivateClass {                // explicitly private class
    func somePrivateMethod() {}                  // implicitly private class member
}

// 元组类型
// 是以最严格限制为准。one with internal access and one with private access, the access level for that compound tuple type will be private.

// 方法类型
// 根据元组访问级别的原则，该元组的访问级别是 private 因为该函数返回类型的访问级别是 private，所以你必须使用 private 修饰符，明确指定该函数的访问级别：
private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    // function implementation goes here
    return (SomeInternalClass(), SomePrivateClass())
}

// 枚举类型
// 枚举成员的访问级别和该枚举类型相同，你不能为枚举成员单独指定不同的访问级别。
public enum CompassPoint {
    case North
    case South
    case East
    case West
}
// 枚举定义中的任何原始值或关联值的类型的访问级别至少不能低于枚举类型的访问级别。例如，你不能在一个 internal 的枚举中定义 private 的原始值类型。

// 嵌套类型
// 如果在 public 或者 internal 级别的类型中定义嵌套类型，那么该嵌套类型自动拥有 internal 访问级别\

// 子类
// 子类的访问级别不得高于父类的访问级别。例如，父类的访问级别是 internal，子类的访问级别就不能是 public。但是可以重写父类的方法或属性修改访问级别
// 我们甚至可以在子类中，用子类成员去访问访问级别更低的父类成员，只要这一操作在相应访问级别的限制范围内（也就是说，在同一源文件中访问父类 private 级别的成员，在同一模块内访问父类 internal 级别的成员）：
public class A {
    private func someMethod() {}
}

internal class B: A {
//    override internal func someMethod() {
//        super.someMethod()
//    }
}

// 常量、变量、属性、下标
// 如果常量、变量、属性、下标的类型是 private 级别的，那么它们必须明确指定访问级别为 private：

// Getter 和 Setter
// 常量、变量、属性、下标的 Getters 和 Setters 的访问级别和它们所属类型的访问级别相同。
// Setter 的访问级别可以低于对应的 Getter 的访问级别，这样就可以控制变量、属性或下标的读写权限。在 var 或 subscript 关键字之前，你可以通过 fileprivate(set)，private(set) 或 internal(set) 为它们的写入权限指定更低的访问级别。

// 构造器
// 自定义构造器的访问级别可以低于或等于其所属类型的访问级别。唯一的例外是必要构造器，它的访问级别必须和所属类型的访问级别相同。

// 结构体默认的成员逐一构造器
// 如果结构体中任意存储型属性的访问级别为 private，那么该结构体默认的成员逐一构造器的访问级别就是 private。否则，这种构造器的访问级别依然是 internal。

// 协议 (内部和要求的级别相同)
// 协议中的每一个要求都具有和该协议相同的访问级别。你不能将协议中的要求设置为其他访问级别。这样才能确保该协议的所有要求对于任意采纳者都将可用。

// Extension
// Extension 的成员具有和原始类型成员一致的访问级别。
import UIKit

class AccessControlController: UIViewController {

}
