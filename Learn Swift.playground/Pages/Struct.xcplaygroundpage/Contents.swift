import Foundation

//: # 结构体

//: ## 结构体基本

// 声明一个基本的结构体
struct Location1 {
    
    let latitude: Double
    let longitude: Double
}

var appleLocation = Location1(latitude: 37.32, longitude: -122.03)

appleLocation.latitude
appleLocation.longitude

// 结构体中的变量/常量也可以是结构体

struct Place {
    
    let location: Location1
    var name: String
}

var googlePlace = Place(location: Location1(latitude: 37.44, longitude: -122.33), name: "Google")

//: ## 结构体的构造函数
//: > 上面的结构体没有设置构造函数, 但是创建结构体变量的时候, 系统默认提供了一个构造函数, 这个构造函数会把除了已经赋值的常量之外的常量/变量都作为参数
struct Location2 {
    let latitude: Double = 0
    let longitude: Double
    var test: Int = 0
}

//Location2() // 结构体构造函数必须保证将结构体中所有变量/常量初始化, 因此这个构造函数在这里是不可以的

Location2(longitude: 2.11, test: 1) // 已经赋值的常量就不会再出现在默认的构造函数中了, 已经赋值的变量仍然会出现, 当然, 已经赋值的常量出现在结构体中的意义并不大

//: > 通常情况下,我们赋默认值的结构体通常都是变量
struct Location3 {
    var latitude: Double = 0
    var longitude: Double = 0
}

Location3() // 此时可以直接使用这个没有任何参数的构造函数了
//Location3(latitude: 11.111) // 注意这样是不可以的, 要么就全参

//: > 我们还可以自定义构造函数, 但是只要自定义构造函数, 系统提供的默认的构造函数就会失效

struct Location4 {
    
    let latitude: Double
    let longitude: Double
    
    // 传入一个经纬度的字符串, 中间用逗号隔开
    init(coordinateString: String) {
        let commaIndex = coordinateString.firstIndex(of: ",")
        let firstElement = coordinateString.prefix(upTo: commaIndex!)
        let secondElement = coordinateString.suffix(from: coordinateString.index(after: commaIndex!))
        
        latitude = Double(firstElement)!
        longitude = Double(secondElement)!
    }
}
//Location4(latitude: 37.32, longitude: -122.03) // 不能再使用系统默认提供的构造函数
Location4(coordinateString: "333.563,222.345")

//: > 因此, 如果还需要默认的全参数的构造函数的话, 最好再额外写一个全参的构造函数

struct Location5 {
    
    let latitude: Double
    let longitude: Double
    
    // 传入一个经纬度的字符串, 中间用逗号隔开
    init(coordinateString: String) {
        let commaIndex = coordinateString.firstIndex(of: ",")
        let firstElement = coordinateString.prefix(upTo: commaIndex!)
        let secondElement = coordinateString.suffix(from: coordinateString.index(after: commaIndex!))
        
        latitude = Double(firstElement)!
        longitude = Double(secondElement)!
    }
    
    // 可以自己再写一个全参数的构造函数
    init(latitude: Double, longitude: Double) {
        // 这里由于这个函数内部参数名和外面的变量名重名了, 直接用名称会就近认为是参数而不是外部的变量, 为了避免冲突, 外部的变量就需要加上 self
        self.latitude = latitude
        self.longitude = longitude
    }
}

//: > 需要注意的是, Swift 中, 所有变量常量在初始化之前都是未被初始化状态, 不会有默认的初始值, 只能人工初始化, 只有可选型是例外, 可选型默认的初始值就是 nil, 因此结构体中的可选型变量可以不初始化

//: ## 可失败的构造函数 Failable Initializer

//: > 上面的自定义构造函数, 如果传入的字符串不符合要求就会在运行时崩溃, 其实可以创建一个可失败的构造函数, 可失败的构造函数有可能返回 nil
struct Location6 {
    
    let latitude: Double
    let longitude: Double
    
    // 可失败的构造函数使用 init?
    init?(coordinateString: String) {
        
        guard let commaIndex = coordinateString.firstIndex(of: ",") else { return nil }
        
        let firstElement = coordinateString.prefix(upTo: commaIndex)
        let secondElement = coordinateString.suffix(from: coordinateString.index(after: commaIndex))
        
        guard let latitude = Double(firstElement), let longitude = Double(secondElement) else { return nil }
        
        self.latitude = latitude
        self.longitude = longitude
    }
}

Location6(coordinateString: "332.43,32,2.2")

//: ## 在结构体和枚举中定义方法

//: > 在面向对象的语言中, 结构或者类里面的函数我们称为方法

struct Location7 {
    
    let latitude: Double
    let longitude: Double
    
    func printLocation() {
        print("\(latitude) and \(longitude)")
    }
    
    func isNorth() -> Bool {
        return latitude > 0
    }
    
    // 方法中可以调用其他方法
    func isSouth() -> Bool {
        return !isNorth()
    }
    
    // 方法中可以传参
    func distanceTo(location: Location7) -> Double {
        return sqrt(pow(latitude - location.latitude, 2) + pow(longitude - location.longitude, 2))
    }
}

//: > Swift 中, 枚举也可以有方法
enum Shape {
    case Square(side: Double)
    case Rectangle(width: Double, height: Double)
    case Circle(centerx: Double, centery: Double, radius: Double)
    case Point
    
    // 括号中不用再传参数了, 因为就在枚举变量里
    func area() -> Double {
        
        switch self {
        case let .Square(side):
            return side * side
        case let .Rectangle(width, height):
            return width * height
        case let .Circle(_, _, radius):
            return .pi * radius * radius
        case .Point:
            return 0
        }
    }
}

//: ## 结构体和枚举都是值类型
//: > 结构体和枚举都是值类型, 包括枚举的 Raw Value 和关联值也都是值类型

//: ## Swift 中结构占据了非常重要的地位, Int, Double, String, Array, Dictionary, Set 等等都是结构
var aInt: Int = 3
aInt.distance(to: 10) // 结构体可以定义方法, 这就是 Int 类型的方法, 距离 10 有多远

//: [Previous](@previous) | [Next](@next)
