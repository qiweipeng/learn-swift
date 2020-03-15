import Foundation

//: # 布尔类型

// Bool 类型只有 true 和 false
var isTrue = true // 类型为 Bool

//: # if 语句

//: - Note:
//: Swift 中没有非 0 即真的概念, if 语句的 Condition 中只能是一个 Bool 变量

if isTrue {
    print("Yes, it is true!") // print 函数还有两个参数已经赋了默认值，分别是 separator 和 terminator, 这两个参数的默认值分别是空格和回车, 我们也可以自己指定
}

// 这样写是不对的
//if 1 {
//    print("Not 0")
//}

//: [Previous](@previous) | [Next](@next)
