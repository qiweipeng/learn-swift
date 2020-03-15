import UIKit

//: # 属性和方法

//: ## 计算型属性

//: > 计算型属性是不需要初始化的, 因为它的值是根据存储型属性的值计算得到的; 计算型属性必须声明成 var; 计算型属性必须显式声明其类型
//:
//: > 计算型属性完全可以使用方法代替, 实际开发中根据情况选择就好了, 比如下面的中心点, 面积等, 又比如颜色, 设置为属性会比设置成方法更符合逻辑

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
    // 这个 center 属性是根据前两个存储型属性计算得到的, 目前这个计算型属性是只读属性, 因此省略了 get, 如果希望是读写的, 就分别把 set get 加入
    //    var center: Point {
    //        let centerX = origin.x + size.width / 2
    //        let centerY = origin.y + size.height / 2
    //        return Point(x: centerX, y: centerY)
    //    }
    
    // 下面这样就是读写的
    var center: Point {
        
        get {
            let centerX = origin.x + size.width / 2
            let centerY = origin.y + size.height / 2
            return Point(x: centerX, y: centerY)
        }
        // 需要注意的是, center 是一个计算型属性, 没有存储功能, 因此它的setter 方法也应该是通过逻辑把值赋到其他存储型属性上才对
        //        set(newCenter) { // set 后面可以自己命名写上赋到值叫什么
        //            origin.x = newCenter.x - size.width / 2
        //            origin.y = newCenter.y - size.height / 2
        //        }
        
        // setter 方法中自己命名的 newCenter 也可以不写, 默认的叫做 newValue
        set {
            origin.x = newValue.x - size.width / 2
            origin.y = newValue.y - size.height / 2
        }
    }
    
    // 如果只写 getter 方法, 就不需要再加 get {} 了
    var area: Double {
        return size.width * size.height
    }
    
    // 类没有默认的构造函数, 需要提供构造函数
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
}

var rect = Rectangle(origin: Point(), size: Size(width: 10, height: 5))

rect.origin = Point(x: 10, y: 10)
rect.center

// 当 center 属性变成可读写之后, 就可以给它赋值了, 并且 origin 属性会跟着改变
rect.center = Point(x: 30, y: 30)
rect.origin

//: ## 类型属性 Type Properties

class Player {
    
    var name: String
    var score = 0
    // 定义最高分, 这个最高分和每个对象无关, 它存储在静态区, 存储着所有玩家的最高分
    static var highestScore = 0
    
    init(name: String) {
        self.name = name
    }
    
    func play() {
        
        let score = Int(arc4random()%100)
        print("\(name) played and got \(score) scores.")
        
        self.score += score
        print("Total score of \(name) is \(self.score)")
        
        // 注意对于静态变量是定义在类型上的, 需要用类型名调用
        if self.score > Player.highestScore {
            Player.highestScore = self.score
        }
        
        print("Highest score is \(Player.highestScore)")
    }
}

let player1 = Player(name: "Player1")
let player2 = Player(name: "Player2")

player1.play()
player1.play()
player2.play()
player2.play()

//: ## 类型方法 Type Method

//: > 需要注意的是, static 修饰的方法自带 final 关键字作用, 即无法被继承, 无法被子类重写, 而 class 关键字是可以的

// 设置一个结构,是一个矩阵
struct Matrix {
    
    var m: [[Int]]
    var row: Int
    var col: Int
    
    init?(_ arr2d: [[Int]]) {
        
        guard arr2d.count > 0 else { return nil }
        
        let row = arr2d.count
        let col = arr2d[0].count
        
        for i in 1..<row {
            if arr2d[i].count != col {
                return nil
            }
        }
        
        self.m = arr2d
        self.row = row
        self.col = col
    }
    
    func printMatrix() {
        for i in 0..<row {
            for j in 0..<col {
                print(m[i][j], terminator: "\t")
            }
            print()
        }
    }
    
    // 类型方法同样是前面加一个 static
    static func identityMatrix(n: Int) -> Matrix? {
        guard n > 0 else { return nil }
        
        var arr2d: [[Int]] = []
        for i in 0..<n {
            var row = [Int](repeating: 0, count: n)
            row[i] = 1
            arr2d.append(row)
        }
        
        return Matrix(arr2d)
    }
}

if let m = Matrix([[1, 2], [3, 4]]) {
    m.printMatrix()
}

Matrix.identityMatrix(n: 4)?.printMatrix()

//: ## 属性观察器 Property Observer

class LightBulb {
    
    // 允许的最大电流
    static let maxCurrent = 30
    
    var current = 0 {
        
        willSet { // 对于 willSet, 可以拿到 新值也就是 newValue, 当然也可以自己命名
            print("Current value changed, The change is \(abs(current - newValue))")
        }
        
        didSet {
            if current == LightBulb.maxCurrent {
                print("Pay attention, the current calue get to the maximum point.")
            } else if current > LightBulb.maxCurrent {
                print("Current too high, falling back to previous setting")
                current = oldValue // 当然也可以在 didSet 后面加小括号自己命名如 (oldCurrent)
            }
        }
    }
}

let bulb = LightBulb()

bulb.current = 20
bulb.current = 30
bulb.current = 40

// 第二个例子

//: > 这个例子说明, 属性观察器 willSet 和 didSet 不会在初始化阶段调用, 即第一次给这个属性赋值的时候, 不会走属性观察器,只有修改值的时候才会走; 也因为如此, 如果一个成员变量后面写了属性观察器, 那么它就不应该是常量, 因为常量只能被赋一次值, 属性观察器永远不会执行
enum Theme {
    case DayMode
    case NightMode
}

class UI {
    
    // 这里的字体颜色和背景颜色被设置成了隐式可选型, 原因是首先我不希望这两个颜色在使用的时候可以为nil, 但是在这个类真正被初始化之前, 我不知道 UI 是白天模式还是晚上模式, 因此暂时只能是 nil
    var fontColor: UIColor!
    var backgroundColor: UIColor!
    var themeMode: Theme = .DayMode {
        didSet {
            switch themeMode {
            case .DayMode:
                fontColor = UIColor.black
                backgroundColor = UIColor.white
            case .NightMode:
                fontColor = UIColor.white
                backgroundColor = UIColor.black
            }
        }
    }
    
    init(themeMode: Theme) {
        self.themeMode = themeMode
    }
}

let ui = UI(themeMode: .NightMode)
// 可以看到, 属性观察器没有执行, 颜色依然为 nil
ui.fontColor
ui.backgroundColor

//: > 上面这个例子, 如果修改, 应该在初始化阶段, 给两个颜色变量初始化一下
//init(themeMode: Theme) {
//    self.themeMode = themeMode
//
//    switch themeMode {
//    case .DayMode:
//        fontColor = UIColor.black
//        backgroundColor = UIColor.white
//    case .NightMode:
//        fontColor = UIColor.white
//        backgroundColor = UIColor.black
//}

//: ## Lazy Property 延迟属性

//: > 这个类中我们希望设置一个 sum 属性计算从头到尾的数字和, 我们不希望每次创建一个对象的时候都要附带创建一个这样的变量, 因为不是每次都会用, 换句话说这个属性有时需要有时又不需要; 首先考虑计算型属性, 但是计算型属性不适合计算量大的情况, 如果计算量很大, 我们又可能多次使用这个属性的时候, 每次都要计算一次很消耗性能; 还有中选择就是延迟属性, 延迟属性只会在第一次使用它的时候才会创建, 可以在构造函数之后初始化
class ClosedRange {
    
    let start: Int
    let end: Int
    
    var width: Int {
        return end - start + 1
    }
    
    // 一种方式是将其设置为计算型属性, 但是问题是, 计算型属性没有存储功能, 每次使用都会重新计算一次
    //    var sum: Int {
    //        var res = 0
    //        for i in start...end {
    //            res += i
    //        }
    //        return res
    //    }
    
    // 延迟属性只是在属性前加 lazy 关键字, 后面相当于是一个闭包的调用, 利用闭包的返回值赋给这个变量
    lazy var sum: Int = { // 延迟属性的类型必须显式声明
        
        print("这句只会走一次哦")
        var res = 0
        
        // 由于这里面的变量是捕获的
        for i in start...end { // 这里应该使用 self.start 吗
            res += i
        }
        return res
    }() // 加上 () 说明是闭包的调用, 如果没有它那 sum 就是一个函数名了呀, 当然也不符合语法
    
    init?(start: Int, end: Int) {
        guard start < end else { return nil }
        
        self.start = start
        self.end = end
    }
}

if let range = ClosedRange(start: 0, end: 10000) {
    range.width
    range.sum
    range.sum
}

//: > 下面再举一些适合做延迟属性的例子

class Book {
    let name: String
    lazy var content: String? = {
        // 从本地读取书的内容
        return nil
    }()
    
    init(name: String) {
        self.name = name
    }
}

class Web {
    let url: String
    lazy var html: String? = {
        // 从网络读取 url 对应的 html
        return nil
    }()
    
    init(url: String) {
        self.url = url
    }
}

//: ## 访问控制
// 这部分已经总结过

//: ## 单例

// 给 class 前加个 final 保证这个单例类不能被继承也是挺好的
final class GameManager {
    
    var score = 0
    
    // 使用 static可以使用类名调用, 并且连继承都不可以; 使用 let 保证创建后就无法被改变
    static let `default` = GameManager() // 如果变量名被关键字占用了,可以加上``
    // 将构造函数加上 private 关键字, 保证外部无法重新初始化
    private init() {
        print("单例初始化")
    }
    
    func addScore() {
        score += 10
    }
}

//GameManager() // 直接实例化将无法实现
// 两次其实是在使用同一个对象
let gm1 = GameManager.default // 使用单例
gm1.addScore()
gm1.score
let gm2 = GameManager.default
gm2.addScore()
gm2.score

//: [Previous](@previous) | [Next](@next)
