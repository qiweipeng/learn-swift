import Foundation

//: # 整型

// Int
var imInt: Int = 17
// 拿到 Int 类型的最大值和最小值
Int.max
Int.min

// UInt
var imUInt = 80
// 拿到 UInt 的最大值和最小值
UInt.max
UInt.min

// Int8, 类似还有 UInt8, Int16, UInt16, Int32, UInt32, Int64, UInt64
Int8.max
Int8.min
//: - Note:
//: Swift 中溢出是一种编译错误, 这也是 Swift 是一种安全的语言的表现之一; 在 OC 中, 如果把一个较大的数赋值给一个 Int8 类型的变量, 那么结果是会取其最后 8 位表示成一个数字, 这个数显然是无意义的, 也使得 Bug 容易出现了, Swift 在这里就避免了这种风险
//let num: Int8 = 129

//: - Note:
//: 如果运算中我们故意需要溢出，那么 Swift 提供了溢出运算符，比如 &+, &-

//let overflow = Int8.max &+ 1 // -128

//: - Note:
//: 但是实际使用中一般只使用 Int 类型, 苹果也推荐只使用 Int 类型，它在 32 位平台就是 Int32，在 64 位平台就是 Int64

// 使用二进制、八进制、十六进制
var decimalInt: Int = 17
var binaryInt: Int = 0b10001
var octalInt: Int = 0o21
var hexInt: Int = 0x11

// 使用_给数字分隔, 增强阅读性
var x = 1_000_000

//: [Previous](@previous) | [Next](@next)
