import Foundation

//: # 字符串

//: ## 声明字符串

// 空字符串
let emptyString = ""
let emptyString2 = String()

//: ## 字符串的基本操作
var str1 = "Hello"
let str2 = "World"
str1.isEmpty // 判空

str1 + str2 // 字符串相加,返回一个新的字符串
str1 += str2 // 给 str 接上一个 str2

print("Hi, \(str1)") // 使用 \(), 即字符串插值

//: ## 字符串的 Character
// 这里面 c 就是一个 Character 类型的常量
for c in str1 {
    c
}
// 倒着遍历
for c in str1.reversed() {
    c
}

// 显式声明可以声明一个 Character 类型常量/变量
let imCharacter: Character = "A"

var cafe = "café"
var cafe2 = "cafe\u{0301}"

// String 的判等更加高级,上面两个字符串在 Swift 中会被判断为相等
cafe == cafe2

//: ## 字符串的进阶操作
let aStr = "Hello! World!"

aStr.prefix(5) // "Hello"
aStr.suffix(5) // "orld!"
aStr.dropFirst() // "H"
aStr.dropLast() // "!"

var str = "来He你好l 米lo!"

// 拿到字符串的开始索引
let startIndex = str.startIndex

// 字符串的字一个字符, 是 Character 类型
str[startIndex]
// 拿到字符串的第四个字符
str[str.index(startIndex, offsetBy: 3)]

// 拿到空格所在的索引,即从头向后数6个位置
let spaceIndex = str.index(startIndex, offsetBy: 6)

// 拿到空格前面和后面的字符
str[str.index(before: spaceIndex)]
str[str.index(after: spaceIndex)]

let range = startIndex..<str.index(before: spaceIndex)
str.replaceSubrange(range, with: "Hi") // 变成 "Hil 米lo!"
str.removeSubrange(range) // 变成 "lo!"

// 更多字符串操作
let str3 = " Hello, swift  "
str3.uppercased()
str3.lowercased()
str3.capitalized // 每个单词首字母大写
str3.contains("llo")
str3.hasPrefix("He")
str3.hasSuffix("ift")
str3.trimmingCharacters(in: .whitespaces) // 去除字符串前后的空格

//: [Previous](@previous) | [Next](@next)
