import Foundation

//: # 泛型

//: ## 泛型基础

//: > swap 函数就使用了泛型, 它可以交换 Int, Double, String 等等, 虽然类型不同, 但是交换的逻辑都是一致的, 因此可以使用泛型
var a: Int = 1
var b: Int = 2

swap(&a, &b)

//: > 如果一套逻辑是和类型无关的, 那么就可以使用泛型; 下面我们实现一个自己的 swap 函数, 这里 T 代表 Template, 代表是一种类型
func swapTwoThings<T>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}

var hello = "Hello!"
var bye = "Bye!"

swapTwoThings(&a, &b)
swapTwoThings(&hello, &bye)

//: ## 泛型类型

// 这就是泛型类型
let arr: Array<Int> = [Int]()

//: > 举例1 自己写一个栈结构

// 栈, 本质就是一个数组
struct Stack<T> {
    var items = [T]()
    
    // 判断是否为空
    func isEmpty() -> Bool {
        return items.count == 0
    }
    
    // 入栈, 结构体的方法中如果想改变自己, 需要加入 mutating 关键字
    mutating func push(item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T? {
        guard !self.isEmpty() else { return nil }
        
        return items.removeLast()
    }
}

extension Stack {
    
    // 看看栈顶元素
    func top() -> T? {
        return items.last
    }
}

var s = Stack<Int>()
s.push(item: 1)
s.push(item: 2)
s.pop()

var ss = Stack<String>()
ss.push(item: "Hello")
ss.push(item: "World")
ss.pop()
ss.top()

//: 举例2
struct Pair<T1, T2> {
    var a: T1
    var b: T2
}
var pair = Pair<Int, String>(a: 0, b: "Hello")

//: [Previous](@previous) | [Next](@next)
