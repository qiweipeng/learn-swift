import Foundation

//: # 枚举

//: ## 基本

//: > Swift 3 以后, 枚举的每个 case 应该是小写开头

//: > Swift 语言中, 枚举的每一个值可以和整型没有关系
enum Direction {
    case east
    case south
    case west
    case north
}

//: > 当然如果我们愿意,也可以建立这种关系, 那就是 Raw Value; 如果是整数, 如下面这样也可以只写第一个 = 1, 后面的都可以省略
enum Month: Int {
    case january = 1
    case february = 2
    case march = 3
    case april = 4
    case may = 5
    case june = 6
    case july = 7
    case august = 8
    case september = 9
    case october = 10
    case november = 11
    case december = 12
}

//: > Raw Value 的使用例子; 注意只有定义了 Raw Value 才能使用, 第一个枚举由于没有定义 Raw Value 所有不能使用
// 定义这样一个函数, 传入一个月份, 看看距离新年还有几个月
func monthsBeforeNewYear(month: Month) -> Int {
    return 12 - month.rawValue
}

//: > 有了 Raw Value 我们还能通过 Raw Value 来创建枚举变量
let mayMonth = Month(rawValue: 5) // 这样就创建了一个枚举变量, 这样创建的返回值是可选型

// 下面这个枚举, 没有给任何一个枚举值设初值, 但是设置了其类型是 Int, 那么默认 F 的 Raw Value 就是 0, E 就是 1,以此类推; 如果不设置枚举值, 那么枚举类型后面就不要加冒号类型
enum Grade: Int {
    case f, e, d, c, b, a
}

let grade: Grade = .c
grade.rawValue

//: > Swift 中, Raw Value 可以不是连续的, 想给几都行
enum Coin: Int {
    case penny = 1
    case nickel = 5
    case dime = 10
    case quarter = 25
}

//: > Swift 中, Raw Value 不仅仅可以是整型,实际上几乎可以是任何类型
enum ProgrammingLanguage: String {
    case objectiveC = "Objective-C" // 对于字符串类型, 可以这样写上 Raw Value, 如果不写, 默认就是本身那个的字符串
    case swift
    case java
    case python
}

ProgrammingLanguage.java.rawValue

//: ## 枚举的关联值(相关值), 即 Associate Value

//: > 在 Swift 语言中, 对枚举变量进行了一个非常重要的扩展, 这就是枚举的关联值, 也就是枚举变量中, 每一种可能性可以和一个变量进行连接
//: > 下面这个例子中可以看出, 首先不同情况的关联值可以是不同的类型, 其次这些关联值是可变的; 关联值不是必须的, 可以有的有, 有的没有; 但是 Associate Value 和 Raw Value 是互斥的, 如果定义了关联值就不能再定义 Raw Value
enum ATMStatus {
    case success(Int)
    case error(String)
}

// 账户余额 1000 元
var balance = 1000

func withdraw(_ amount: Int) -> ATMStatus {
    if balance >= amount {
        balance -= amount
        return .success(balance)
    } else {
        return .error("Not enough money")
    }
}

let result = withdraw(200)

//: > 关联值可以通过如下方式进行解包
switch result {
case let .success(newBalance):
    print("\(newBalance) Yuan left in your acount")
case let .error(errorMessage):
    print("Error: \(errorMessage)")
}

//: > 关联值不仅仅可以关联一个值, 还能关联多个值, 并且还能给每个关联值命名, 事实上, 关联多个值的情况实际上是关联了一个元组而已
enum Shape {
    case square(side: Double)
    case rectangle(width: Double, height: Double)
    case circle(centerx: Double, centery: Double, radius: Double)
    case point
}

let square = Shape.square(side: 10)
let rectangle = Shape.rectangle(width: 20, height: 30)
let circle = Shape.circle(centerx: 0, centery: 0, radius: 15)
let point = Shape.point

// 根据形状的不同分别求面积
func area(shape: Shape) -> Double {
    
    switch shape {
    case let .square(side):
        return side * side
    case let .rectangle(width, height):
        return width * height
    case let .circle(_, _, radius):
        return .pi * radius * radius
    case .point:
        return 0
    }
}

//: ## 可选型的实质是枚举

// 我们声明一个可选型通常是这样的, 但它其实是把一个枚举类型进行了包装, 这个枚举类型就是 Optional
var website1: String? = "google.com"
// 这个可选型还可以赋值为 nil
//website1 = nil

//: > 可选型的实质是类型为 Optional 的枚举, 只是由于其经常被使用, Swift 在这里将可选型的语法作了简化, 在编译层面帮程序员做好了, 下面就开始还原
//: > String? 可以换成 Optional<String>, 是等价的; “google.com” 只是它的其中一种情况 some 的关联值
var website2: Optional<String> = Optional.some("google.com")
//: nil 其实就是 Optional.none
//website2 = .none // 或者完整写成 Optional.none

//: > 通常可选型解包可以使用 if let
if let website1 = website1 {
    print(website1)
} else {
    print("nil")
}

//: > 实际上枚举关联值的解包, 可选型的解包可以看作是下面枚举关联值解包的语法简化
switch website2 {
case let .some(website2):
    print(website2)
case .none:
    print("none")
}

//: ## 枚举递归, 一般用不到, 用到再学 主要是加一个 indirect 关键字

//: [Previous](@previous) | [Next](@next)
