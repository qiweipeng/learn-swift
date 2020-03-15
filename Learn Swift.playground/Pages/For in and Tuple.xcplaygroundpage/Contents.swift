//: Playground - noun: a place where people can play

import UIKit

//: 1. for 循环

//for i in (1..<5).reversed() {
//    print(i) // 打印 5,4,3,2,1
//}

//for i in stride(from: 0, through: 6, by: 2) {
//    print(i) // 打印 0,2,4,6
//}

//for i in stride(from: 0, to: 6, by: 2) {
//    print(i) // 打印 0,2,4
//}

for i in stride(from: 0, to: 1.5, by: 0.3) {
    print(i) // 打印 0.6, 0.9, 1.2
}

//: 2. 元组

// 相同类型元组之间的比较
let score1 = (chinese: 90, math: 95)
let score2 = (chinese: 90, math: 100)
let score3 = (chinese: 100, math: 90)

// 比较规则是先对第一个分量进行比较,如果相等,再按照第二个分量进行比较
score1 < score2
score2 < score3

//: [Next](@next)
