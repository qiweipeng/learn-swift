import Foundation

//: # 面向协议编程

//: ## 基本

// 协议是可以继承的, 继承了该协议也就拥有了该协议的声明
protocol Record: CustomStringConvertible {
    var wins: Int { get }
    var losses: Int { get }
    
    func winningPercent() -> Double
}

// 协议的扩展可以提供协议属性/方法的默认实现, 这样, 遵守协议的类型可以不去实现这些属性/方法而使用默认的实现
extension Record {
    
    // 协议的扩展甚至可以给协议添加一个新的/属性方法, 并且实现它
    var gamePlayed: Int {
        return wins + losses
    }
    
    // 已经声明的协议方法的默认实现
    func winningPercent() -> Double {
        return Double(wins) / Double(gamePlayed)
    }
    
    // 继承的协议的默认实现
    var description: String {
        return String(format: "WINS: %d, LOSSES: %d", arguments: [wins, losses])
    }
    
    // 新的协议方法并提供默认实现
    func shoutWins() {
        print("WE WIN", wins, "TIMES!!!")
    }
}

// 另一个协议,表示可平局
protocol Tieable {
    var ties: Int { get set }
}

// 这个 Roecord 的扩展的意思是, 遵守了Record 中又遵守了 Tieable 协议的
extension Record where Self: Tieable {
    
    // 等于是同时贴了 Record 和 Tieable 标签的类/结构 在 Record 协议的 gamePlayed 属性的默认实现
    var gamePlayed: Int {
        return wins + losses + ties
    }
    
    // 这个方法中用到了协议的另一个属性即 gamePlayed, 如果这里不实现这个方法(虽然和前面 Record 扩展中一模一样), 对于 footballRecord 来说,  它就会去默认执行 前面那个扩展里的方法, 执行的时候用到 gamePlayed 的时候, 也会按照前面协议中实现的方式去执行, 而不会按照本扩展中 gamePlayed 实现的方式去运行, 这点需要认真体会
    func winningPercent() -> Double {
        return Double(wins) / Double(gamePlayed)
    }
}

//: > 我们也可以拓展系统自带的协议
extension CustomStringConvertible {
    var descriptionWithDate: String {
        return NSDate().description + " " + description
    }
}

protocol Prizable {
    func isPrizable() -> Bool
}

// 遵守了 Record, 等于一并遵守了 CustomStringConvertible 协议
// 遵守协议就要实现协议属性/方法, 但是已经提供了默认实现的可选实现
struct BasketballReccord: Record, Prizable {
    var wins: Int
    var losses: Int
    
    func isPrizable() -> Bool {
        return wins > 2
    }
}

struct BaseRecord: Record, Prizable {
    var wins: Int
    var losses: Int
    
    // 协议的扩展已经提供默认实现的, 在类型中还是可以覆盖的
    //    var gamePlayed: Int = 162
    
    func isPrizable() -> Bool {
        return gamePlayed > 10 && winningPercent() >= 0.5
    }
}

struct FootballRecord: Record, Tieable, Prizable {
    var wins: Int
    var losses: Int
    var ties: Int
    
    func isPrizable() -> Bool {
        return wins > 1
    }
}

let basketballTeamRecord = BasketballReccord(wins: 2, losses: 10)
let baseballTeamRecord = BaseRecord(wins: 10, losses: 5)
let footballTeamRecord = FootballRecord(wins: 1, losses: 1, ties: 1)

footballTeamRecord.winningPercent() // 如果没有在 Record 的第二个扩展中实现 winningPercent 方法, 此处将会是 0.5
footballTeamRecord.descriptionWithDate

//: ## 协议聚合

// one 必须同时遵守 Prizable 和 CustomStringConvertible 协议,这叫做协议的聚合
func award(one: Prizable & CustomStringConvertible) {
    if one.isPrizable() {
        print(one)
        print("恭喜可以获奖")
    } else {
        print("抱歉不能获得奖励")
    }
}

award(one: baseballTeamRecord)

//: ## 泛型约束

struct Student: Prizable, CustomStringConvertible, Equatable, Comparable {
    var name: String
    var score: Int
    
    func isPrizable() -> Bool {
        return score >= 60
    }
    
    var description: String {
        return "Name: \(name), Score: \(score)"
    }
    
    static func ==(lhs: Student, rhs: Student) -> Bool {
        return lhs.score == rhs.score
    }
    
    static func <(lhs: Student, rhs: Student) -> Bool {
        return lhs.score < rhs.score
    }
}

let roger = Student(name: "Roger", score: 100)
award(one: roger)

let a = Student(name: "Alice", score: 80)
let b = Student(name: "Bob", score: 92)
let c = Student(name: "Karl", score: 85)

let students = [a, b, c, roger]

/*:
 > 我们现在定义一个函数, 目的是找到数组中最大的那个元素, 理所当然我们会想下面这种写法, 但是它会报错
 
 > protocol 'Comparable' can only be used as a generic constraint because it has Self or associated type requirements
 
 > 点进头文件可以看到, Comparable 定义的时候, 两个参数的类型写的是 Self, 这种情况下会有一个递归调用的问题, 这种情况下, 无法将这个协议看作是类型, 而只能看作是协议的, 用一个类型去遵守
 
 > 还有种情况是 当一个协议中定义了 associatedtype 的时候, 这个协议也不能直接看作类型
 */
//func topOne(seq: [Comparable]) -> Comparable {
//
//}

//: 正确的写法如下
// 这个函数可以将一个数组中的最大值找到, 这个数组的元素必须遵守 Comparable 协议
func topOne<T: Comparable>(seq: [T]) -> T {
    assert(seq.count > 0)
    return seq.reduce(seq[0], { (res, com) -> T in
        return max(res, com)
    })
}

topOne(seq: [2,5,1,7,9,5])
topOne(seq: ["Hello", "Sw"])
topOne(seq: students)

//: > 类似可以看到下面的例子, 当有了 associatedtype, 也是无法直接当作类型看待的

protocol Flyable {
    
    associatedtype Height
    
    var flyHeight: Height { get set }
    
    func fly()
}

protocol Runnable {
    var runSpeed: Int { get set }
    
    func run()
}

func test1(param: Runnable) {
}

//func test2(param: Flyable) {
//}
func test2<T: Flyable>(param: T) {
}

// 再继续上面的例子

//: > 这个函数着可获奖的情况下最大的那个, 就要求这个类型同时遵守两个协议
func topPrizableOne<T: Comparable & Prizable>(seq: [T]) -> T? {
    return seq.reduce(nil, { (tempTop, contender) -> T? in
        guard contender.isPrizable() else { return tempTop }
        guard let tempTop = tempTop else { return contender }
        
        return max(tempTop, contender)
    })
}

topPrizableOne(seq: students)?.name

//: [Previous](@previous) | [Next](@next)
