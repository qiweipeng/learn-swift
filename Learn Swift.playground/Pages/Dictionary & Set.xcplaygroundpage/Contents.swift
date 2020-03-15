import Foundation

//: # 字典

// 初始化
var dict = ["swift": "燕子", "python": "蟒蛇", "java": "爪洼岛"]

// 空字典
var emptyDict1: [String: Int] = [:]
var emptyDict2: Dictionary<String, Int> = [:]
var emptyDict3 = [String: Int]()
var emptyDict4 = Dictionary<String, Int>()
var emptyDict5: [String: String] = Dictionary()
var emptyDict6: Dictionary<String, String> = Dictionary()

dict.count // 字典元素数量
dict.isEmpty // 字典是否为空
dict["swift"] = "雨燕" // 增、改 返回新值
dict.updateValue("大蟒", forKey: "python") // 改 返回旧值
dict["swift"] // 查 返回的是可选型
//dict.removeValue(forKey: "java") //删
//dict["java"] = nil // 删

Array(dict.keys) // 将字典所有键放进一个数组中
Array(dict.values) // 将字典的所有值放进一个数组

// 遍历字典的键值对
for (k, v) in dict {
    k
    v
}

//: # 集合

/*:
 > 集合无序, 但效率比数组高
 > 集合中数据有唯一性
 > 集合可以进行交、并等集合操作
 */

// 集合必须显式声明类型, 并且没有快速创建的方法
var skillsOfA: Set<String> = ["Objective-C", "Swift"]
var skillsOfB: Set<String> = ["Javascript", "CSS", "HTML"]
var skillsOfC: Set<String> = []

// 声明空集合
var emptySet1: Set<Int> = []
var emptySet2 = Set<Double>()
var emptySet3: Set<Int> = Set()

// 将数组转成集合
var vowels = Set(["A", "E", "E", "I"])

vowels.first // 集合中随意一个元素

// 集合的添加
skillsOfC.insert("Swift")
skillsOfC.insert("HTML")
skillsOfC.insert("CSS")
skillsOfC.insert("CSS") // 重复添加是没效果的
// 删除
skillsOfC.remove("CSS")
//skillsOfC.removeAll() // 删除所有

// 集合的交并等运算, 事实上数组也能用这些方法
skillsOfA.union(skillsOfB) // 交, 但 skillsOfA 本身没有发生改变
//skillsOfA.formUnion(skillsOfB) // 交 skillsOfA 改变
skillsOfA.intersection(skillsOfB) // 并, 本身不改变
//skillsOfA.formIntersection(skillsOfB) // 并, 本身改变
skillsOfA.subtracting(skillsOfC) // A 有C 没有, 本身不改变
//skillsOfA.subtract(skillsOfC) // A 有 C 没有, 本身改变
skillsOfA.symmetricDifference(skillsOfC) // 亦或, 即 A 和 C 中除去共有剩下的部分, 本身不改变
skillsOfA.formSymmetricDifference(skillsOfC) // 亦或, 本身改变
skillsOfC.isSubset(of: skillsOfA) // 判断子集
skillsOfC.isStrictSubset(of: skillsOfA) // 判断真子集
skillsOfA.isSuperset(of: skillsOfC) // 判断超集
skillsOfA.isStrictSuperset(of: skillsOfC) // 判断真超集
skillsOfA.isDisjoint(with: skillsOfC) // 判断相离, 就是看是否有共同元素

//: [Previous](@previous) | [Next](@next)
