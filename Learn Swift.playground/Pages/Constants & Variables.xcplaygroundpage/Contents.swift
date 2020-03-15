import Foundation

//: # 常量和变量

// 常量, 声明后无法改变
let maxNum = 100
//maxNum = 200

// 变量, 声明后可以改变
var index = 2
index = 3

// 同时声明多个常量或变量
var x = 1, y = 2, z = 3

//: - Note:
//: Swift 是强类型语言, 甚至无法给一个整形变量赋值一个小数, 但是声明变量的时候可以不显式地声明类型, Swift 会使用 Type Inference (类型推断) 来确定变量的类型
//x = 1.5

// 当然也可以显式地声明一个变量
var doubleNum: Double = 5
var name: String = "Jack"

//: [Next](@next)
