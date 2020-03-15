import Foundation

//: # 运算符

//: ## 基本运算符

// 赋值运算符
var a = 2
a = 3

//: - Note:
//: 注意赋值运算符是没有返回值的, 因此不能用在 if 语句中, 这也是 Swift 在避免潜在的 Bug 产生, 因为程序员很容易把 a = 2 和 a == 2 写混, 产生不必要的 Bug,  Swift 中直接避免了这种情况的发生

//if a = 2 {
//    print("这样是不对的")
//}

// +, -, *, /, % 等运算符就不展示了

// 一元运算符

//: - Note:
//: Swift 中没有 ++ 和 -- 运算符了, 这也挺好因为我每次使用都要反应一下, 所以这并不是一个很好的运算符
var x = 3
x += 1

//: ## 比较运算符和逻辑运算符

let money = 100
let price = 70

if money > price {
    print("比较运算符返回一个 Bool 值")
}

if money > 50 && price > 50 {
    print("逻辑运算符包括 && 和 ||")
}

//: ## 变量初始化

//: - Important:
//: 在 Xcode 10 中, Playground 已经不能直接按照下面这样写了, 必须赋初值
//: （可能是 Bug，现在又可以了）

//: - Note:
//: 常量或变量并不一定非要在一开始就赋初值, 也可以在后面的逻辑中赋初值, 但是注意的是, 赋初值前一定不能使用; 如果是常量, 一旦赋值就无法再改变
let aInt: Int

if money > 50 {
    aInt = 10
} else {
    aInt = 20
}

//: ## 三目运算符

//: - Note:
//: 三目运算符的其中一个优点是, 不给变量声明和赋值直接留空隙, 这样就避免了变量在赋初值之前就使用的情况
let number = money > 50 ? 10 : 5

//: ## 区间运算符和 for-in

/*:
 - Note:
 对于 for-in
 
 首先大括号是不能省略的, 即使只有一行代码, 这是为了安全考虑, 防止程序员多行代码也忘记添加大括号产生 Bug
 
 其次下面这个 index 是一个常量, 也就是说在循环内部不能改变它的值
 */
// 表示从 1 到 10,两边闭区间
for index in 1...10 {
    index
}

// 表示从 0 到 9, 包含 0 不包含 10
for index in 0..<10 {
    index
}

let numbers = [3, 5, 7, 12]
let name = "Jack"

// 数组可以使用 for-in 进行遍历, 事实上, 所有遵守 Sequence 协议的类型都是可以使用 for-in 的, 比如 String, Dictionary 等
for number in numbers {
    number
}
// 也可以使用原始的方法
for i in 0..<numbers.count {
    numbers[i]
}

for c in name {
    c
}

//: [Previous](@previous) | [Next](@next)
