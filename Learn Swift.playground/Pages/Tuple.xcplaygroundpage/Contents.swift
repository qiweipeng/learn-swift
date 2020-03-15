import Foundation

//: # 元组

//: ## 元组的声明

/*:
 - Note:
 所谓元组就是将多个数据放在一个数据类型中, 有些像 C 中的结构体. 元组的一个应用就是可以使一个函数 (方法) 返回多个数据, 这几个数据使用一个元组包装一下就可以了
 */

// 可以存储一个平面上的坐标点, 也就是同类型的值
var point = (2, 3)

// 也可以存储不同类型的值
var httpResponse = (404, "Not Found")

// 也可以显式声明类型
var httpResponse2: (Int, String) = (200, "OK")

//: ## 获取元组中的元素

// 1. 通过解包的方式
let (x, y) = point
x
y

// 2. 通过点语法加下标可以直接拿到元组中的数据
httpResponse.0
httpResponse.1

// 3. 如果元组的每一个分量都已经命名, 那么可以直接通过名字拿到
var httpResponse3 = (statusCode: 200, statusMessage: "OK")
var httpResponse4: (statusCode: Int, statusMessage: String) = (200, "OK")
httpResponse3.statusCode
httpResponse3.statusMessage
httpResponse4.statusCode
httpResponse4.statusMessage

// 解包的时候,如果只需要其中部分分量, 其他的可以使用_忽略掉
let (_, z) = point
z

//: [Previous](@previous) | [Next](@next)
