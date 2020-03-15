import Foundation

// # 协议

//: # 协议基础

//: > 协议就是定义一组规范, 再由具体的类型去遵守, 在 Swift 中, 结构、类、枚举都是可以遵守协议的
//: > 同样可以为协议添加属性和方法, 但是不同的是, 它都是声明, 却没有实现
protocol Pet {
    
    // 协议中,属性除了声明之外, 还需要指定这个属性是只读的还是读写的, { get } 或者 { get set }
    // 同样, 属性不可以有默认值
    // 协议中, 只有 var 没有 let
    var name: String { get set }
    
    //: > 这里的理解: 这里协议指定的是 get 即只读属性, 但是其实遵守的时候设置成读写的是完全没有问题的, 也就是说, 协议规定的必须要遵守, 协议没规定的多实现点儿也完全合法
    var birthPlace: String { get }
    
    // 协议中, 方法是不能有具体实现的, 也就是没有大括号
    func playWith()
    
    // 协议中方法可以有参数和返回值, 但是同样, 不能有实现; 并且协议中的参数是不能设置默认值的 (这其实也是一种实现)
    func fed(food: String)
    
    // 如果可能会改变自身, 可以在协议方法中加入 mutating, 如果是结构来遵守协议的话, 该方法就会增加 mutating
    mutating func changeName(newName: String)
}

struct Dog: Pet {
    
    // 遵守协议后, 协议只希望它是可读可写的, 具体是存储型属性还是计算型属性是没关系的
    var name: String = "Puppy"
    
    // 这里可以使用 let 来表示此属性只读, 当然写成 var 也是完全没有关系的
    //    let birthPlace: String = "Beijing"
    var birthPlace: String = "Beijing"
    
    func playWith() {
        print("Wong!")
    }
    
    // 协议无法规定默认参数, 参数实现的时候是可以添加的
    func fed(food: String = "Bone"){
        print("Eat!")
    }
    
    // 如果是类, mutating 就多余了
    mutating func changeName(newName: String) {
        name = newName
    }
}

var wangcai = Dog()
var aPet: Pet = wangcai // 协议有点像标签的感觉, 代表了一个遵守了 Pet 协议的变量

wangcai.birthPlace = "Shanghai"
//aPet.birthPlace = "Shanghai" // 这里是无法设置的, 因为 aPet 不是一个 Dog 类型,它只是遵守了 Pet 协议,有点父类指针指向子类对象的感觉

//: > 如果协议希望只被类遵守,不让其他类型遵守,可以
protocol Fly: class {
    
}

//: ## 协议和构造函数

protocol Pet2 {
    var name: String { get set }
    
    // 协议也可以规定构造函数
    init(name: String)
    
    func playWith()
    func fed()
}

class Animal {
    var type: String = "mammal"
}

//: > 当一个类同时需要继承和遵守协议的时候,继承的类需要写在第一个位置
class Dog2: Animal, Pet2 {
    
    var name: String = "Puppy"
    
    //: > 遵守协议的构造函数一定是 required 构造函数 (除非这个类前面加有 final 关键字), 原因是其子类一定也遵守了协议, 所以也一定需要实现这个构造函数
    required init(name: String) {
        self.name = name
    }
    
    func playWith() {
        print("Wong!")
    }
    
    func fed() {
        print("I love bones.")
    }
}

//: 情况1

class Bird1: Animal {
    
    var name: String = "Little Little Bird"
    
    required init(name: String) {
        self.name = name
    }
}

class Parrot1: Bird1, Pet2 {
    
    //: 这个类的父类和遵守的协议同时拥有一个一样的构造函数, 并且都是 required 的, 因此此时这个类的构造函数也应该是 required 的没有问题
    required init(name: String) {
        super.init(name: name + " " + name)
    }
    
    func playWith() {
    }
    
    func fed() {
    }
}

//: 情况2

class Bird2: Animal {
    
    var name: String = "Little Little Bird"
    
    init(name: String) {
        self.name = name
    }
}

class Parrot2: Bird2, Pet2 {
    
    //: 这种情况写 父类的构造函数不是 required 的, 协议的肯定是 required 的, 此时不能省略 override
    required override init(name: String) {
        super.init(name: name + " " + name)
    }
    
    func playWith() {
    }
    
    func fed() {
    }
}

//: ## 为什么需要协议?

//: > 一句话总结,面向对象就是用文件夹整理, 而面向协议就是用标签来描述; 为什么 masOS 中有标签? 更确切的, 为什么印象笔记中有标签并且还可以设置子标签?

//: ## typealias

// 给一个类型设置别名
typealias Length = Double

extension Double {
    var km: Length { return self * 1000.0 }
    var m: Length { return self }
    var cm: Length { return self / 100 }
    var ft: Length { return self / 3.28084 }
}

let runningDistance = 3.54.km
runningDistance

//: 下面介绍协议与 typealias 的关系

protocol WeightCalculable1 {
    
    // 这个属性的类型我们有时用 Int 合适, 有时可能用 Double 合适, 难道因此写两个协议?
    var weight: Int { get }
}

//: > 我们可以在协议里使用 associatedtype (作用和 typealias 是一样的, 只是用在协议中) 定义一个类型, 但是这个类型是什么是有遵守协议的一方决定的
protocol WeightCalculable {
    
    associatedtype WeightType
    var weight: WeightType { get }
}

class iPhone7: WeightCalculable {
    
    typealias WeightType = Double
    
    var weight: Double {
        return 0.114
    }
}

class ship: WeightCalculable {
    
    typealias WeightType = Int
    
    var weight: Int
    
    init(weight: Int) {
        self.weight = weight
    }
}

//: ## Swift 标准库中的常用协议
struct Record: Equatable, Comparable, CustomStringConvertible {
    
    var wins: Int
    var losses: Int
    
    // Equatable 需要重载 ==, 之后可以使用 == 和 !=
    static func ==(lhs: Record, rhs: Record) -> Bool {
        return lhs.wins == rhs.wins && lhs.losses == rhs.losses
    }
    // Comparable 需要重载 <, 之后可以使用 < 和 >
    static func <(lhs: Record, rhs: Record) -> Bool {
        if lhs.wins != rhs.wins {
            return lhs.wins < rhs.wins
        }
        return lhs.losses > rhs.losses
    }
    // CustomStringConvertible 协议需要实现这个只读属性, 返回值就是这个类型被打印的时候的输出
    var description: String {
        return "WINS: \(wins), LOSSES: \(losses)"
    }
}

let re1 = Record(wins: 2, losses: 3)
let re2 = Record(wins: 2, losses: 4)

re1 == re2
// Equatable 协议让我重载 == 运算符, 实现之后把 != 也帮我们实现了
re1 != re2
re1 < re2
re1 > re2

//: 如果同时遵守了 Equatable, Comparable, 那么也能使用 <= 和 >=
re1 <= re2
re1 >= re2

var records = [re1, re2]

records.sorted() // sorted 函数可以被使用的前提是数组的元素是遵守 Comparable 协议的

print(re1)

//: [Previous](@previous) | [Next](@next)
