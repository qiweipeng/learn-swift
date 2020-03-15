import Foundation

//: # 类

//: ## 类的定义
class Person {
    
    var firstName: String
    var lastName: String
    
    // 类和结构体不同, 不会默认提供一个构造函数, 因此如果变量没有赋初值, 那么就会提示其没有被初始化 stored property 'firstName' without initial value prevents synthesized initializers
    
    // 需要自己创建构造函数, 系统不会提供默认的
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    // 也可以创建可失败的构造函数
    init?(fullName: String) {
        
        guard let spaceIndex = fullName.firstIndex(of: " ") else { return nil }
        
        self.firstName = String(fullName.prefix(upTo: spaceIndex))
        self.lastName = String(fullName.suffix(from: fullName.index(after: spaceIndex)))
    }
    
    // 类中的方法
    func fullName() -> String {
        return firstName + "" + lastName
    }
}

let person1 = Person(firstName: "Roger", lastName: "Federer")
let person2 = Person(fullName: "Rafal-Nadal")

person2?.fullName()

//: ## 类是引用类型

//: > 原理就不讲了已经理解, 这里重点关注一点
struct Location {
    
    var latitude: Double
    let longitude: Double
}

//: > 这里定义的是一个常量, 那么结构体不可以改变显而易见, 但是由于其是值类型, 结构体不能改变, 那么里面的内容就都不可以改变, 即使里面有变量
let appleLocation = Location(latitude: 37.32, longitude: -122.03)
//appleLocation.latitude = 333.333 // 这样是不被允许的

//: > 但是对于类来说, 类是一个引用, 指针是常量只代表指针方向不能发生改变及不能指向其他位置, 其指向的内容仍然可以改变
class Person2 {
    var firstName: String
    let lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

let steve = Person2(firstName: "Steve", lastName: "Jobs")

steve.firstName = "Steeeeve" // 在类中这是被允许的

//: > 由于不具有这样的约束,类中的方法是可以更改自己的属性的值的
class Person3 {
    let firstName: String
    let lastName: String
    var caree: String?
    
    init(firstName: String, lastName: String, caree: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.caree = caree
    }
    
    func changeCaree(newCaree: String) {
        caree = newCaree
    }
}

let xiaoming = Person3(firstName: "xiao", lastName: "ming")
xiaoming.changeCaree(newCaree: "Teacher")

//: > 但是这在结构体中是做不到的;对于类来讲,只是指针指向一片内存空间,当改变的时候,指针指向并没有变,只是操作那片内存空间;对于结构体来讲,改变其中每个变量其实都是在创建一个新的结构体变量,自己是无法改变自己的

struct Location2 {
    var x = 0
    var y = 0
    
    // 提示错误 'self' is immutable
//    func goEast() {
//        x += 1
//    }
    
    // 如果希望结构体自己修改自己, 在 Swift 中可以在方法前加 mutating 关键字
    mutating func goEast() {
        x += 1
    }
}

//: > 对于枚举型变量也是类似

enum Switch {
    case On
    case Off
    
    mutating func click() {
        switch self {
        case .On:
            self = .Off
        case .Off:
            self = .On
        }
    }
}

var button = Switch.Off
button.click()

//: ## 类的等价

//: > == 符号是不能用在对象身上的,因为 == 是值的比较,只可以对值类型进行比较; 类对象之间的比较看是否指向同一片内存,用 === 比较
let person3 = Person(firstName: "Li", lastName: "Li")
let person4 = person3

person3 === person4

let person5 = Person(firstName: "Li", lastName: "Li")

person3 === person5
person3 !== person5

//: ## 什么时候使用结构体,什么时候使用类?

/*:
 1. 把结构体看作是值, 如: 位置(经纬度), 坐标, 温度等等适合用结构体
 2. 把类看作是物体: 如: 人, 车, 动物, 商店
 3. 同时应该考虑结构体是值类型, 类是引用类型
 4. 比如坐标这种值, 我们希望是拷贝而不是在原有基础上修改, 所以结构体合适; 对于人,我们创建一个人显然不希望再复制一个同样的人给别人修改, 所以类适合
 5. 类是可以被继承的, 这也是类也结构体的不同, 不过 Swift 中通过协议也是可以解决这个问题
 6. 结构体更轻量, 因此, 即使像表达一个物体, 如果它在程序中很小, 可以考虑使用结构体;结构体的效率更高, 结构体的内存空间是开在栈中, 类的内存空间是开了堆中
 */

//: [Previous](@previous) | [Next](@next)
