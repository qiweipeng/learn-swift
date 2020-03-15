import UIKit

//: 扩展

//: ## 扩展基础

//: > 扩展中可以放: 计算型属性、一般的方法、便利构造函数; 不能放: 存储型属性、指定构造函数
//: > 扩展中可以扩展嵌套类型

//: > 在新的文件中,或者新的程序的逻辑块中为已有的类、结构等进行扩展
struct Point {
    var x = 0.0
    var y = 0.0
}

struct Size {
    var width = 0.0
    var height = 0.0
}

class Rectangle {
    var origin = Point()
    var size = Size()
    
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
}

//: > 可以在扩展中添加函数, 对于用户来说, 可以无差别的使用
extension Rectangle {
    
    func translate(x: Double, y: Double) {
        self.origin.x += x
        self.origin.y += y
    }
}

//: > 扩展无法定义存储型属性, 计算型属性当然是可以的, 因为计算型属性和方法差不多
//: > 扩展只能定义便利构造函数, 不能定义指定构造函数

extension Rectangle {
    var center: Point {
        get {
            let centerX = origin.x + size.width / 2
            let centerY = origin.y + size.height / 2
            return Point(x: centerX, y: centerY)
        }
        
        set {
            origin.x = newValue.x - size.width / 2
            origin.y = newValue.y - size.height / 2
        }
    }
    
    convenience init(center: Point, size: Size) {
        let originX = center.x - size.width / 2
        let originY = center.y - size.height / 2
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let rect = Rectangle(origin: Point(), size: Size(width: 4, height: 3))
rect.translate(x: 10, y: 10)
rect

//: ## Nested Type 嵌套类型

class UI {
    
    //: > 之前是把这个枚举放在类的外面,但是,如果这个枚举就是依托于这个类存在的,可以把这个枚举放在类的内部
    enum Theme {
        case DayMode
        case NightMode
    }
    
    var fontColor: UIColor!
    var backgroundColor: UIColor!
    
    var themeMode: Theme = .DayMode {
        didSet {
            self.changeTheme(self.themeMode)
        }
    }
    
    init() {
        self.themeMode = .DayMode
        self.changeTheme(self.themeMode)
    }
    
    private func changeTheme(_ theme: Theme) {
        switch themeMode {
        case .DayMode:
            fontColor = UIColor.black
            backgroundColor = UIColor.white
        default:
            fontColor = UIColor.white
            backgroundColor = UIColor.black
        }
    }
}

let ui = UI()
//: 此时这个themeMode 的类型变成了 UI.Theme
ui.themeMode
ui.fontColor

ui.themeMode = .NightMode
// 也可以像下面这样完整的写, 但是 Theme.NightMode 已经不行了
ui.themeMode = UI.Theme.NightMode
ui.fontColor

//: > 扩展中可以有嵌套类型; 甚至可以扩展下标
extension Rectangle {
    
    // 矩形四个顶点
    enum Vertex: Int {
        case LeftTop
        case RightTop
        case RightBottom
        case LeftBottom
    }
    
    func point(at vertex: Vertex) -> Point {
        switch vertex {
        case .LeftTop:
            return origin
        case .RightTop:
            return Point(x: origin.x + size.width, y: origin.y)
        case .RightBottom:
            return Point(x: origin.x + size.width, y: origin.y + size.height)
        case .LeftBottom:
            return Point(x: origin.x, y: origin.y + size.height)
        }
    }
    
    subscript(index: Int) -> Point {
        assert(index >= 0 && index < 4, "Index in Rectangle Out of Range.")
        return point(at: Vertex(rawValue: index)!)
    }
}

rect.point(at: .RightBottom)
rect[2]

//: ## 扩展系统类库

extension Int {
    
    // 添加一个 平方 的计算型属性
    var square: Int {
        return self * self
    }
    
    var cube: Int {
        return self * self * self
    }
    
    // 判断整型是否在某个范围中
    func inRange(colsedLeft left: Int, openedRight right: Int) -> Bool {
        return self >= left && self < right
    }
    
    // 重复做这个整型的个数次
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

let num = 3
num.square
num.cube
num.inRange(colsedLeft: 10, openedRight: 100)
num.repetitions {
    print("Hello")
}

//: [Previous](@previous) | [Next](@next)
