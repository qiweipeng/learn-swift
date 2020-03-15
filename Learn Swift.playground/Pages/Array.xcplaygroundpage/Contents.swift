import Foundation

//: # 数组

//: ## 初始化数组

var numbers = [3,4,6,2,7,4]
var vowels = ["A", "E", "I", "O", "U"]

// 显式声明
var numbers1: [Int] = [1, 2, 4]
var numbers2: Array<Int> = [1, 2, 4] // 使用范型的方式

// 空数组

//: > 空数组和数组的可选型可不是一回事, 空数组也是一个数组, 不是 nil

//var emptyArray = [] // 这种方法是不可以的, 因为数组是确定元素类型的
var emptyArray1: [Int] = []
var emptyArray2: Array<Int> = []

//: > 下面两种方式相当于使用了构造函数, 因为 [Int] 也是一种数据类型

var emptyArray3 = [Int]()
var emptyArray4 = Array<Int>()
// 由上面两种创建方式可知, 下面的也是可以的
var emptyArray5: [Int] = Array()
var emptyArray6: Array<Int> = Array()

// 创建若干个相同元组的数组
var allZeros = [Int](repeating: 0, count: 5)

//: ## 数组的基本使用

numbers.count // 数组长度
numbers.isEmpty // 是否是空数组
numbers[2] // 获取数组下标元素
numbers.first // 获取数组首个元素, 注意返回值为可选型, 因为空数组没有首个元素
numbers.last
numbers.max() // 数组的最大值, 返回可选型
numbers.min() // 数组的最小值
numbers.contains(3) // 是否包含某元素
numbers.firstIndex(of: 4) // 某个元素第一次出现的下标, 返回可选型

let arraySlice = numbers[1...4] // 截取数组的某一段, 不过是 ArraySlice 类型, 猜测和 SubString 类型很像

//: - Note:
//: 需要注意的是，ArraySlice 类型是和 Array 共享内存的，如果数组不发生改变，则这个 ArraySlice 类型的变量也不会发生复制，也就是说它就是 Array 的一部分；另外 ArraySlice 的下标可能不是从 0 开始的，而是从它从数组中截取的位置开始的

// arraySlice[0]// 数组越界崩溃
arraySlice[1] // 3


let subArray = Array(arraySlice) // 如果需要使用数组可以将其转换成一个新的数组

// 遍历数组
for number in numbers {
    number
}

// 反向遍历复杂度不变，不会影响性能
for number in numbers.reversed() {
    number
}

// 甚至可以同时拿到下标
for (n, vower) in vowels.enumerated() {
    n
    vower
}

//: ## 数组的增删改查

var names = ["Jack", "Rose", "Jim"]

// 增加
names.append("Tom")
names += ["Lily"] // 这种运算需要加的仍是一个数组
names.insert("Lucy", at: 4) // 插入元素

// 删除
//names.removeFirst()
//names.removeLast()
//names.remove(at: 3) // 删除特定位置的元素

//names.removeAll() // 删除所有元素

// 修改
names[1] = "Lucy" // 修改
names[1...3] = ["Xiaoming"] // 将特定范围替换一下

//: ## 如果数组中需要放不同类型
let anyArray: [Any] = [2, "dd"]

//: [Previous](@previous) | [Next](@next)
