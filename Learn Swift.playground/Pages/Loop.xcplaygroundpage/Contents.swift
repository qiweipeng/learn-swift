import Foundation

//: # 循环控制结构

// for-in 循环
// _表示不使用
for _ in -2...2 {
    print("Hello")
}

for i in stride(from: 0, to: 10, by: 2) {
    print(i) // 0 2 4 6 8
}

for i in stride(from: 0, through: 10, by: 2) {
    print(i) // 0 2 4 6 8 10
}

// while 循环
var a = 0

while a < 3 {
    a += 1
}

//: - Note:
//: 由于 do 这个关键字已经被错误处理占用, 因此 Swift 中使用 repeat-while 代替 do-while

var b = 0

repeat {
    b += 1
} while b < 0

// 控制转移 break 和 continue

//: [Previous](@previous) | [Next](@next)
