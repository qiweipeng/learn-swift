import Foundation

// if-else 省略

//: # switch 语句

/*:
 - Note:
 1. Swift 中的 Switch 语句默认没有穿透,如果需要穿透, 直接在一个 case 中并列写出就可以了; 这样避免忘写 break 产生 Bug
 2. Switch 语句的 Value 不再局限于整数, 不管是字符串还是小数还是布尔还是元组等都可以, 只要 case 把变量的所有情况都包含就可以
 */

// 基本使用, Switch 语句默认没有穿透
let rating = "A"

switch rating {
case "A", "a":
    print("Great")
case "B":
    print("Just so-so")
default:
    print("Error")
    // 如果 default 中不想写逻辑, 可以仅仅使用一个 break 或者使用一个 ()
}

// 高级使用 Switch 的 case 不仅仅可以判断单个值, 还可以判断区间
let score = 90

switch score {
case 0..<60:
    print("不及格")
case 60..<90:
    print("良好")
case 90...100:
    print("优秀")
default:
    break
}

// Switch 中元组的使用

//: - Note:
//: 如果上面一个 case 的范围是下面 case 的真子集, 那么可以在其最后使用 fallthrough, 代表满足上面的情况一定也满足下面的, 因此跳过判断直接穿透
let vector = (x: -1, y: -1)

switch vector {
case (0, 0):
    print("圆点")
    fallthrough
case (_, 0):
    print("在x轴")
case (-2...2, -2...2):
    print("在 -2 到 2 范围内")
    print(vector.x, vector.y)
default:
    ()
}

// 元组的解包也可以融合在 switch 语句中
let point = (8, 0)

switch point {
case (let x, 0):
    print(x)
case (let x, let y):
    print(x, y)
}

// switch 语句中还可以使用 where 增加条件
let point2 = (3, 3)

switch point2 {
case let (x, y) where x == y:
    print("在 x = y 的轴上")
default:
    ()
}

/*:
 - Note:
 if case, 使用 if-case时从 Swift 3 开始不使用 where 而是直接使用逗号
 if case 使用的非常少
 */

let age = 18

if case 10...30 = age, age > 18 {
    print("age 在这个区间")
}

//: 上面的语法相当于下面的 switch 语句的部分判断

switch age {
case 10...30 where age > 18:
    print("在这个区间")
default:
    print("不在")
}

//: - Note:
//: 在 for 循环中使用 case

for i in 1...100 {
    if i % 3 == 0 {
        print(i)
    }
}

// 下面的代码可以代替上面的
for case let i in 1...100 where i % 3 == 0 {
    print(i)
}

// 但是下面这样写也是可以的
for i in 1...100 where i % 3 == 0 {
    print(i)
}

// 控制转移 break 增强, 这个了解就好, 这实际上就是 goto 语句, 它的使用有很多争议, 实际中不要使用
// 控制转移有 break, continue, fallthrough, return, throw
findAnswer:
    for i in 0..<10 {
        for j in 0..<10 {
            if i * j > 200 {
                print(i, j)
                break findAnswer // 这样就可以直接退出外层循环
            }
        }
}

//: [Previous](@previous) | [Next](@next)
