import Foundation

//: # 闭包

//: ## 闭包基础

// 仍然沿用函数部分的例子, 一个存储了 100 个 0 到 999 的数的数组, 我们进行从大到小排序, 默认可以定义一个函数然后传入 sorted 函数中
var arr:[Int] = []
for _ in 0..<100 {
    arr.append(Int(arc4random()%1000))
}

func biggerFirst(_ a: Int, _ b: Int) -> Bool {
    return a > b
}

arr.sorted(by: biggerFirst)
// 由于上面这个函数和 > 号的含义其实是一样的, 所以还能这么写
arr.sorted(by: >)
//: > 但是如果这个函数只会被此处用到一次, 专门写一个函数还要起名字, 不如使用匿名的闭包, 直接接在后面; 闭包就是一个匿名函数, 因此原本填入函数名的地方现在写一个闭包就可以了, 闭包的完整语法如下
arr.sorted(by: { (a: Int, b: Int) -> Bool in
    return a > b
})

//: > 因为参数类型和返回值类型是固定的, 因此可以省略不写, 两个参数只需要用逗号分隔, 小括号也可以省略, 返回值那里因为只有一句话, return 都可以省略 因此可以简写成下面这样
arr.sorted(by: { a, b in a > b })

// 事实上, 闭包中的参数即使我们不自己命名, 系统也会给一个默认的名字, 分别是 $0, $1, ... 所以还能这么写
arr.sorted(by: { $0 > $1 })

//: ## 尾随闭包

//: > 当闭包是函数的最后一个参数的时候, 闭包可以提到小括号外部, 如果已经没有其他参数需要传递, 小括号也可以省略, 同时, 函数最后的那个参数名可以省略, 我们写代码的时候, 如果遇到闭包就敲回车, 当是尾随闭包的时候, Xcode 会自动将其整理成尾随闭包的语法格式
arr.sorted { (a, b) -> Bool in
    return a > b
}

// 同样后面的简写也都能改写
arr.sorted { $0 > $1 }

// 使用 map 函数应用闭包
arr.map { (number) -> String in
    return String(number)
}

//: ## 内容捕获

//: > 某些情况下, 闭包是有优势的, 可以实现函数无法实现的功能, 那就是内容捕获

var number = 500

arr.sorted { (a, b) -> Bool in
    abs(a - number) < abs(b - number)
}

//: ## 闭包和函数都是引用类型
func runningMetersWithMetersPerDay(_ metersPerDay: Int) -> () -> Int {
    
    var totalMeters = 0
    return {
        totalMeters += metersPerDay
        return totalMeters
    }
}

var planA = runningMetersWithMetersPerDay(2000)
planA()
planA()
var anotherPlan = planA
anotherPlan()

//var planA = run

//: [Previous](@previous) | [Next](@next)
