//: [Previous](@previous)

import UIKit

//: 1. Never 关键字

// 这个函数中,我们保证除数不为0,否则执行 fatalError() 中断程序
func mod1(_ a: Int, _ b: Int) -> Int {
    guard b != 0 else {
        fatalError()
    }
    
    return a % b
}

//mod1(10, 0)

//: > 但是有的时候我们可能在之前需要进行一系列的逻辑,我们就自定一个函数,在执行完一些逻辑后,再调用 fatalError

//func myFatalError() {
//    print("!!!!")
//    fatalError()
//}

//func mod2(_ a: Int, _ b: Int) -> Int {
//    guard b != 0 else {
//        myFatalError()
//    } // 但是这里提示了 'guard' body may not fall through, consider using a 'return' or 'throw' to exit the scope
//
//    return a % b
//}

//: > 也就是说,guard 后面的大括号必须中断,但是在那里放一个函数,系统不知道我们在函数里其实已经设置了中断;解决办法是,给这个函数增加一个叫做 Never 的返回类型,它的意思是,只要正常就永远不会有返回

func myFatalError() -> Never {
    print("!!!!")
    fatalError()
}

func mod3(_ a: Int, _ b: Int) -> Int {
    guard b != 0 else {
        myFatalError()
    }
    
    return a % b
}

//: 2. 隐式可选型推测

let a: Int! = 5
let b = a // 此时 b 变成了 Int? 即显式可选型
let c = a + 1 // 此时 c 是 Int 型
let d: Int = a // 此时显然 d 是 Int 型

//: 3. #keyPath

let superviewColor = #keyPath(UIView.superview.backgroundColor)

let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
let label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
view.backgroundColor = .blue
view.addSubview(label)

label.value(forKeyPath: superviewColor)
label.superview?.backgroundColor

//: 4. Index

let arr = [10, 20, 30, 40]

let i = arr.startIndex
let next = arr.index(after: i)

let str = "Hello, Swift 3"

let j = str.startIndex
let k = str.index(j, offsetBy: 4)

str[k]

//: 5. FloatingPoint 协议 (Swift 3 新增)

// 勾股定理
func hypotnuse1(_ a: Float, _ b: Float) -> Float {
    return (a * a + b * b).squareRoot()
}

let aFloat1: Float = 3.0
let bFloat1: Float = 4.0
hypotnuse1(aFloat1, bFloat1)

let aCGGloat1: CGFloat = 3.0
let bCGFLoat1: CGFloat = 4.0
//hypotnuse1(aCGGloat1, bCGFLoat1)

//: > 上面这个函数是无法计算 CGFloat 类型的,通过使用泛型,使用 FloatingPoint 协议就好了

func hypotnuse<T: FloatingPoint>(_ a: T, _ b: T) -> T {
    return (a * a + b * b).squareRoot()
}

let aFloat: Float = 3.0
let bFloat: Float = 4.0
hypotnuse(aFloat, bFloat)

let aCGFloat: CGFloat = 3.0
let bCGFloat: CGFloat = 4.0
hypotnuse(aCGFloat, bCGFloat)

// 同样, Double 类型也支持

//: > pi 这个类型常量(static var pi)就是定义在 FloatingPoint 协议中的,并且给了默认实现了,这样, 所有浮点型都是可以调用它的

let alpha: Float = 2
alpha * .pi

let beta: CGFloat = 3
beta * .pi

//: > inifinity 也是一个类似 pi 的常量,它也是 FloatingPoint 定义的,代表正无穷

// 这个函数可以从一个数组中找到最小值,只要这个数组的元素都是遵守 FloatingPoint 协议的
func findMin<T: FloatingPoint>(values: [T]) -> T {
    
    var res = T.infinity
    for value in values {
        res = value < res ? value : res
    }
    
    return res
}

findMin(values: [3.2, 8.2, 1.3, -0.9])

//: > NaN (Not a Number)

//: > NaN 不是一个数字,它却定义在了 Double 等这种数字类型上,原因是很多时候我们进行数学运算的时候,计算的结果可能不是一个合法的数字
let myNaN = Double.nan
let myNaN2 = CGFloat.nan

myNaN >= 0 // false
myNaN < 0 // false

// 如果没有 NaN ,这个函数的返回值可能就要改成可选型了,使用 NaN 就可以返回一个必选值
func divide<T: FloatingPoint>(_ a: T, _ b: T) -> T {
    if b.isZero {
        return T.nan
    }
    return a / b
}

divide(10, 0).isNaN

let temperatureData = ["21.5", "19.25", "27", "no data", "28.25", "no data", "23"]
//let tempsCelsius = temperatureData.map { (data) -> Double in
//    return Double(data) ?? Double.nan
//}
let tempsCelsius = temperatureData.map {Double($0) ?? .nan }
tempsCelsius

//: [Next](@next)
