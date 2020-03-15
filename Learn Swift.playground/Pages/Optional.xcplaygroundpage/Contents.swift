import Foundation

//: # 可选型

//: > 通常在其他语言中, nil 本质上就是 0, 用 0 代表没有; 但是 Swift 认为, 0 并不是没有, nil 就是空, 不应该使用 0, 于是就有了可选型
//: > 可选型本质上是一个枚举, 如 Int? 类型, 这个枚举值有两种情况, 一种是 nil, 一种是一个 Int 类型的值

//: ## 基本介绍

//: > 这是一个整型的可选型, 可选型的声明必须显式声明类型, 因为 Swift 无法通过 Type Inference 推断出;
//: > 可选型一般都是变量, 因为声明成常量为啥还要声明成可选型呢?
var errorCode: String? = "404"

// 只有可选型可以被设置为 nil
//errorCode = nil

//: ## 可选型的解包

// 可选型不能直接使用, 我们是要使用可选型中的内容, 因此需要解包, 首先是强制解包, 强制解包代表程序员保证这个可选型不为 nil, 强制解包存在风险, 一旦可选型为 nil 就会崩溃
"The errorCode is " + errorCode!

// 为了安全,可以在强制解包前做判断
if errorCode != nil {
    "The errorCode is " + errorCode!
}

//: > Swift 语言提供了 if let 方便可选型的判空, 这里相当于新声明一个常量, 如果可选型不为空, 就把值赋给这个常量, 然后在 if 语句内部就直接使用这个常量就好了, 当然它的作用域仅限于 if 语句内部;
//: > 当然也可以有 if var 如果需要改变值的话
if let errorCode = errorCode {
    "The errorCode is " + errorCode
}

//: > 如果有多个可选型同时需要解包, 可以通过逗号分隔, 同时如果需要加入条件, 也可以使用逗号分隔
var errorMessage: String? = "Not Found"

if let errorCode = errorCode, errorCode == "404", let errorMessage = errorMessage {
    "The errorCode is " + errorCode
    "The errorMessage is " + errorMessage
}

//: ## Optional Chaining

// 对于上面的 errorMessage 如果想要把字符串中的字母全部变为大写, 通常做法需要先解包, 然后调用大写的方法
if let errorMessage = errorMessage {
    errorMessage.uppercased()
}

//: > 通过 Optional Chaining, 可选型可以直接调用该方法, 只不过返回值仍然是一个可选型而已, 这个链条可以进行多次, 中间任意一次返回如果为 nil, 最终的返回值就是 nil; 下面的写法和上面的写法功能上完全一致
errorMessage?.uppercased()

//: ## nil coalesce

// 最麻烦的写法
// Xcode 10 中已经无法这样先声明再赋值了
//let message: String
//
//if let errorMessage = errorMessage {
//    message = errorMessage
//} else {
//    message = "No error"
//}

// 使用三目
let message2 = errorMessage == nil ? "No error" : errorMessage!


// 上面代码可以使用下面代码替换
let message3 = errorMessage ?? "No error"

//: ## 可选型在元组中的使用

// 这个元组的第二个分量是一个可选型, 但是元组本身不是可选型
var error1: (errorCode: Int, errorMessage: String?) = (404, "Not Found")
// 这个元组本身是可选型
var error2: (errorCode: Int, errorMessage: String)? = (404, "Not Found")

//: ## 可选型的实际应用

var ageInput: String = "xyz"

// Int 的构造器提供了将字符串转换为整形的功能, 但是显然并不是所有字符串都可以被转换, 因此这个函数的返回值就是一个可选型
var age = Int(ageInput)

//: ## 隐式可选型 !!!
/*:
 > 隐式可选型多数的使用是在使用类的时候, 特别是创建类的构造函数的时候
 > 隐式可选型是使用叹号, 如 String!, 它和可选型是一样的, 也是可以存储 nil, 但是它的一个重要特点是, 使用的时候不需要解包可以直接使用; 也就是说, 程序员必须保证这个可选型在使用的时候已经不为 nil 了才行
 > 隐式可选型基本只用在创建类的时候, 类的某些变量需要设置为隐式可选型, 这个变量刚创建的时候可以为 nil, 随着构造函数的执行, 这个变量就会被赋值, 当用户使用这个类的时候, 这个变量一定不为 nil
 */
var errorMessage2: String! = nil

errorMessage2 = "Not Found"
// 可见它的使用不需要解包, 但是如果没有值, 就会崩溃
"The errorMessage is " + errorMessage2

//: ## 隐式可选型应用举例

class City {
    
    let cityName: String
    unowned var country: Country
    
    init(cityName: String, country: Country) {
        self.cityName = cityName
        self.country = country
    }
}

class Country {
    
    let countryName: String
    // 这里如果不使用可选型, 因为类的所有成员变量还没有被全部赋值, 下面就无法在构造函数中使用 self, 但是程序员又可以保证这个类的对象一旦创建, 这个属性一定不为 nil, 所以这里使用了隐式可选型
    var capitalCity: City!
    
    init(countryName: String, capitalCity: String) {
        self.countryName = countryName
        self.capitalCity = City(cityName: capitalCity, country: self)
    }
}

//: [Previous](@previous) | [Next](@next)
