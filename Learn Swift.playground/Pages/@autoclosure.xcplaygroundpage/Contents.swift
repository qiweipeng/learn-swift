//: [Previous](@previous)

import Foundation

//: 1. @autoclosure

// 先介绍 ?? 聚合运算符

let username: String? = "qiweipeng"
let screenname: String
if let username = username {
    screenname = username
} else {
    screenname = "Guset"
}

// 上述 if-else 可以使用下面代替
//let screenname2 = username != nil ? username! : "Guest"

// 但是真实情况可能是 username 是通过下面这个函数获得的
func login(username: String, password: String) -> String? {
    // 很复杂的逻辑中...
    print("login...")
    return username
}

//let screenname3 = login(username: "qiweipeng", password: "123456") != nil ? login(username: "qiweipeng", password: "123456")! : "Guest"
// 上面这个逻辑中, login 函数需要被执行两次才行

// 使用 ?? 得以解决
//let screenname4 = login(username: "qiweipeng", password: "123456") ?? "Guest"

func generateNickName() -> String {
    
    // 一个复杂的生成函数
    print("generating...")
    return "Guest"
}

//: > ?? 有个特点,当 ?? 前面成立的情况下,后面是不会被运行的,这是怎么实现的呢?
//let screenname5 = login(username: "qiweipeng", password: "123456") ?? generateNickName()

//: > 我们尝试自己实现一个聚合运算符

//infix operator ???
//func ???<T>(optional: T?, defaultValue: T) -> T {
//    if let value = optional {
//        return value
//    }
//    return defaultValue
//}

// 我们发现,使用我们自己定义的聚合运算符时,不管前面是否为 nil,后面的函数都会执行,这显然是影响性能的
//let screenname6 = login(username: "qiweipeng", password: "123456") ??? generateNickName()

// 解决办法是,将defaultValue 的类型改成一个函数,对于函数来说,只有被调用的时候才会被执行;
//infix operator ???
//func ???<T>(optional: T?, defaultValue: () -> T) -> T {
//    if let value = optional {
//        return value
//    }
//    return defaultValue()
//}

// 然后调用的时候去掉 ()
//let screenname7 = login(username: "qiweipeng", password: "123456") ??? generateNickName

// 但是这样的结果是 如果我还想写 "Guest" 呢就很麻烦了
//let screenname8 = login(username: "qiweipeng", password: "123456") ??? { return "Guest" }

//: > 正确的解决方案就是在函数中加入 @autoclosure; 它的意思是虽然 defaultValue 的类型被我们写成了函数,但是这个函数是可以被我们的编译器自动转换的,如果用户传入的是个值的话,编译器就会自动将其转换成闭包的形式
infix operator ???
func ???<T>(optional: T?, defaultValue: @autoclosure () -> T) -> T {
    if let value = optional {
        return value
    }
    return defaultValue()
}

//: > 此时可以看到,我们自定义的聚合运算符和 ?? 作用基本一致了
let screenname9 = login(username: "qiweipeng", password: "123456") ??? generateNickName()

let screenname10 = login(username: "qiweipeng", password: "123456") ??? "Guest"

//: > 简单理解,@autoclosure 的作用就是如果加了 @autoclosure, 原来这个参数传入的是个函数,现在只需要传入这个函数的返回值
func demo(param: @autoclosure () -> Int) {
    print(param())
}

demo(param: 10)

//: [Next](@next)
