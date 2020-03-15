import Foundation

//: # 类型转换

//: - Note:
//: Swift 不提供隐式的类型转换, 这也是安全的一个体现

let x: Double = 1.2
let y: Int = 5

// 必须显式进行类型转换, 避免潜在 Bug 出现
let sum = Int(x) + y

// 下面这个例子可以看出, 不同位的 Int 类型之间也需要显示的类型转换, 并且, 一个 UInt16 在转换成 UInt8 的过程中是有可能产生溢出错误的

let a: UInt16 = 1500
let b: UInt8 = 20

let m = a + UInt16(b)
//let n = UInt8(a) + b

//: [Previous](@previous) | [Next](@next)
