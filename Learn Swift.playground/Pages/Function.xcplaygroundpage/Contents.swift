import Foundation

//: # 函数

//: ## 函数基本

// 创建一个函数, 这个函数拥有一个参数和一个返回值

/// 打招呼
///
/// - Parameter name: 人名
/// - Returns: 打招呼语句
func sayHello(to name: String) -> String {
    return "Hello " + name
}
// 函数的调用
sayHello(to: "Jack")

// 无参数无返回值的函数
func printHello() {
    print("Hello")
}

//: ## 函数中元组的应用, 可以使用元组作为返回值
func findMaxAndMin(numbers: [Int]) -> (max: Int, min: Int)? {
    guard numbers.count > 0 else {
        return nil
    }
    var minValue = numbers[0]
    var maxValue = numbers[0]
    for number in numbers {
        minValue = minValue < number ? minValue : number
        maxValue = maxValue > number ? maxValue : number
    }
    
    return (maxValue, minValue)
}

findMaxAndMin(numbers: [4, 5, 2, 2, 6, 6, 1]) // 结果是 (6, 1)

//: ## 内部、外部参数名

// 上述 sayHello 函数就是使用了内、外部参数名, 外部看不到内部参数名
// 如果把外部参数名用_代替, 则会产生调用时看到内部参数名, 但是包含在了提示中的效果
func mutiply(_ num1: Int, _ num2: Int) -> Int {
    return num1 * num2
}
mutiply(4, 5)

//: ## 默认参数值

// 带默认值的参数可以在任何位置
func sayHi(to name: String, with greetingWord: String = "Hello", puctuation: String = "!") -> String {
    return "\(greetingWord), \(name)\(puctuation)"
}

// 此时输入函数名会有两个提示, 一个忽略默认参数, 一个带全参数
sayHi(to: "Jack")
sayHi(to: "Lucy", with: "Hi!!", puctuation: "!!!")

// 事实上我们还可以敲出全参数那个, 然后把不需要更改默认值的删掉, 只给一部分带默认值的参数赋值
sayHi(to: "Lily", with: "Hi??")

//: ## 参数个数不定的函数, 即变长的参数类型

//: > 一个函数中只能有一个变长的参数

func mean(numbers: Double...) -> Double {
    
    var sum: Double = 0
    for number in numbers {
        sum += number
    }
    
    return sum / Double(numbers.count)
}

mean(numbers: 3, 4, 5)

//: ## 常量参数、变量参数和 inout 参数
//: > 通常情况下, Swift 函数的参数都是常量, 默认的函数参数在函数内部无法改变

// 如果需要参数是个 var 需要在内部再声明一个 var 来使用
func toBinary(number: Int) -> String {
    
    var number = number // 再声明一个 var
    var res = ""
    
    repeat {
        res = String(number % 2) + res
        number /= 2
    } while number != 0
    
    return res
}

toBinary(number: 5)

//: > 通常情况下, Swift 函数的参数在函数内部的改变不会影响其本身, 也就是参数是按值传入的, 如果希望其改变, 就要按引用传入, 也就是加入 inout 关键字

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    (a, b) = (b, a)
    //    let t = a
    //    a = b
    //    b = t
}

var x = 3
var y = 5

swapTwoInts(&x, &y) // 调用函数的时候, 含有 inout 关键字的变量前面会有一个 &, 表示地址
x
y

//: 其实 Swift 默认就提供了 swap 函数, 并且还使用了范型
swap(&x, &y)

//: ## 使用函数类型

//: > 函数可以作为一个变量, 这为函数式编程打下基础
func add(num1 a: Int, num2 b: Int) -> Int {
    return a + b
}

// 把函数名直接赋值给一个常量/变量, 此时 anotherAdd 就也是一个函数了, 它的类型是 (Int, Int) -> Int
let anotherAdd = add
// 所以也可以显式声明类型
//let anotherAdd: (Int, Int) -> Int = add

// 可以看到两者调用方式还是略有不同
add(num1: 3, num2: 5)
anotherAdd(3, 5)

// 如果是无参数无返回值的函数
func hello() {
    print("Hi")
}

let anotherHello: () -> Void = hello

// 下面举例说明函数作为常量/变量的应用

// 创建一个数组, 里面是 0 到 999 的随机数
var arr: [Int] = []
for _ in 0..<100 {
    arr.append(Int(arc4random()%1000))
}

// 直接调用 sorted 函数, 此时只能从小到大排序
arr.sorted() // 不改变原数组的值
// arr.sort() // 改变原数组的值

// 但是, 调用 sorted(by:) 后面放一个函数, 此时就可以按照自己编写的函数的逻辑去排序了
func biggerNumberFirst(_ num1: Int, _ num2: Int) -> Bool {
    return num1 > num2
}  
arr.sorted(by: biggerNumberFirst)

// 同样可以设计一个按照字符串方式排序
func cmpByNumberString(_ a: Int, _ b: Int) -> Bool {
    return String(a) < String(b)
}

arr.sorted(by: cmpByNumberString)

// 离 500 近的排在前面
func near500(_ a: Int, _ b: Int) -> Bool {
    return abs(a - 500) < abs(b - 500) ? true : false
}

arr.sorted(by: near500)

//: ## 函数式编程入门

//: > 上一节尝试了系统的 sorted 函数, 本节尝试自己创造一个将函数作为参数的函数, 下面是两个修改成绩的函数, 这两个函数拥有共性, 都是将一个整型数组传入然后将每个元素以一定的规则修改

// 将所有分数开平方后乘以 10
func changeScores1(scores: inout [Int]) {
    
    for (index, score) in scores.enumerated() {
        scores[index] = Int(sqrt(Double(score)) * 10)
    }
}

// 所有分数除以 1.5
func changeScores2(scores: inout [Int]) {
    
    for (index, score) in scores.enumerated() {
        scores[index] = Int(Double(score) / 150 * 100)
    }
}

var scores1 = [36, 61, 78, 89, 99]
//changeScores1(scores: &scores1)
var scores2 = [88, 101, 124, 137, 150]
//changeScores2(scores: &scores2)

//: > 因此我们可以抽象出一个高阶函数, 那么具体到设置规则,就简单实现一下这个 (Int) -> Int 函数就好了
func changeScores(scores: inout [Int], by changeScore: (Int) -> Int) {
    
    for (index, score) in scores.enumerated() {
        scores[index] = changeScore(score)
    }
}

func changeScore3(score: Int) -> Int {
    return Int(sqrt(Double(score)) * 10)
}

func changeScore4(score: Int) -> Int {
    return Int(Double(score) / 150 * 100)
}

//changeScores(scores: &scores1, by: changeScore3)
//changeScores(scores: &scores2, by: changeScore4)

// 这时如果需要其他规则, 比如在每个分数的基础上加 3, 那么只需要写一个新的规则函数就好了
func changeScore5(score: Int) -> Int {
    return score + 3
}


//: > 事实上, Swift 为我们提供了更通用的函数, 就是 map 操作, 这个函数被定义在数组上, 我们只需要传入一个改变, 不管是从整型到字符串, 还是整型到整型都可以, 这样这个数组的每一个元素就都会按照这个改变去执行
//scores1.map(changeScore5)

// 我们可以定义一个 (Int) -> Bool 的函数来看成绩是否及格了
func isPass(by score: Int) -> Bool {
    return score >= 60 ? true : false
}

scores1.map(isPass)

//: > 类似地还有 filter 函数, filter 函数中当作参数传入的函数的返回值应当是 Bool 类型, 这个函数会将数组中所有元素操作后返回值为 true 的重新组成一个新的数组返回
scores1.filter(isPass) // 直将原数组中分数及格的重新组成一个数组

//: > 类似还有 reduce 函数, 这个函数有两个参数, 第一个参数是起始值, 后一个参数传入一个函数, 设计运算规则, 之后, 数组中的所有元素就会按照这个规则最终聚合为一个值
// 所有元素相加
scores1.reduce(0, +)

// 可以设计这样一个运算, 数组中每两个元素相加然后再乘以 2, 然后再和下一个元素相加, 然后再乘以 2
func plusMul2(_ result: Int, _ num: Int) -> Int {
    return (result + num) * 2
}
scores1.reduce(0, plusMul2) // 相当于 ((((0 + 36) * 2 + 78) * 2 + 89) * 2 + 99) * 2

// 甚至可以将所有的整型元素拼接成一个字符串
func concatenate(str: String, num: Int) -> String {
    return str + String(num) + " "
}

scores1.reduce("", concatenate) // "36 61 78 89 99" 这样一个字符串

//: ## 函数作为返回值

//: > 使用一个案例介绍

// 按照重量的 1 倍计算邮费
func tier1MailFeeByWeight(weight: Int) -> Int {
    return 1 * weight
}

// 按照重量的 3 倍计算邮费
func tier2MainFeeByWeight(weight: Int) -> Int {
    return 3 * weight
}

// 根据重量的不同, 选择不同的邮费计算方式, 当重量小于等于 10 的时候选择 1 倍计算邮费, 否则选择 3 倍计算邮费
func chooseMailFeeCalculationByWeight(weight: Int) -> (Int) -> Int {
    return weight <= 10 ? tier1MailFeeByWeight : tier2MainFeeByWeight
}

func feeByUnitPrice(price: Int, weight: Int) -> Int {
    
    // 这里根据参数的不同, 可以得到不同的函数作为返回值
    let mailFeeByWeight = chooseMailFeeCalculationByWeight(weight: weight)
    return mailFeeByWeight(weight) + price * weight
    
}

//scores1.redu

//: [Previous](@previous) | [Next](@next)
