import Foundation

//: # 内存管理

//: ## deinit 析构函数

class Person1 {
    
    var name: String
    
    init(name: String) {
        self.name = name
        print(name, "is coming")
    }
    
    func doSomething() {
        print(name, "is doing semething")
    }
    
    // 析构函数连 () 都不用了, 也没有任何参数
    deinit {
        print(name, "is leaving!")
    }
}

var roger: Person1? = Person1(name: "Roger Federer")
roger?.doSomething()
roger = nil

// 变量出了作用域因为弹栈就会被释放

//: ## 引用计数

// 理解,没什么可写的

//: ## 循环引用

class Person2 {
    
    var name: String
    var apartment: Apartment?
    
    init(name: String) {
        self.name = name
        print(name, "is initialized")
    }
    
    deinit {
        print("Person", name, "is being deinitialized!")
    }
}

class Apartment {
    
    let name: String
    // 使用 weak 关键字打破引用循环
    //: > weak 修饰的变量必须是可选型, 因为要保证能被设置成 nil, 相应的也就不能使用 let 只能使用 var
    //: 关于 weak 放在 Person 类中还是 Apartment 类中一般是没有关系的, 实际中我们可以看这些类的关系的主次, 我们希望是人拥有公寓呢还是公寓拥有人呢
    weak var tenant: Person2?
    
    init(name: String) {
        self.name = name
        print(name, "is initialized")
    }
    
    deinit {
        print("Apartment", name, "is being deinitialized!")
    }
}

//: ## unowned 关键字
class Person {
    
    var name: String
    var creditCard: CreditCard?
    
    init(name: String) {
        self.name = name
        print(name, "is initialized")
    }
    
    deinit {
        print("Person", name, "is being deinitialized!")
    }
}

class CreditCard {
    
    let number: String
    //: > 因为逻辑上是人拥有信用卡,因此我们希望把 weak 放在这里而不是 Person 类中; 又因为信用卡一定有一个主人并且只会拥有一个主人, 这里希望是一个非可选值的常量
    
    //: > 因此这里使用 unowned 解决, 它的作用和 weak 是基本是一样的, 也不会使引用计数加一; unowned 修饰的变量不可以是可选型, 也就是说它一定是非空的
    //: > 但是 unowned 是不安全的, 它没有把变量置为 nil 的功能了, 也就有可能存在野指针访问的问题, 如果这个变量指向的空间已经被释放了, 再通过这个变量去访问就会发生崩溃
    unowned let customer: Person
    
    init(number: String, customer: Person) {
        self.number = number
        self.customer = customer
        print("Credit Card", number, "is initialized")
    }
    
    deinit {
        print("CreditCard", number, "is being deinitialized!")
    }
}

var rafa: Person? = Person(name: "Rafa")
var goldenCard: CreditCard? = CreditCard(number: "12345", customer: rafa!)

rafa = nil
//goldenCard?.customer // 让 Person 对象被置为 nil 之后再去访问就会崩溃
goldenCard = nil

//: ## 隐式可选型的再一次举例, 没啥新内容

class Country {
    
    var name: String
    var capital: City!
    
    init(countryName: String, capitalName: String) {
        self.name = countryName
        self.capital = City(cityName: capitalName, country: self)
        print("Country", name, "is initialized")
    }
    
    deinit {
        print("Country", name, "is being deinitialized!")
    }
}

class City {
    
    let name: String
    unowned let country: Country
    
    init(cityName: String, country: Country) {
        self.name = cityName
        self.country = country
        
        print("City", name, "is initialized")
    }
    
    deinit {
        print("City", name, "is being deinitialized!")
    }
}

//: ## 闭包中的强引用循环
class SmartAirCondition {
    
    var temperature: Int = 26
    
    //: > 为了解决循环引用, 我们可能想在这个变量前加 unowned 或者 weak, 但事实上这两个关键字只能用在 class 类型上, 对于函数类型是不可以的; 因此解决循环引用只能考虑去闭包中把其对 self 的引用变成弱引用
    var temperatureChange: ((Int) -> Void)! // 这个类型是个闭包的隐式可选型
    
    init() {
        
        // 构造函数中给这个属性初始化; 如果温度和室温差别太大, 空调将不会按照设置的温度启动
        //: > Swift 声明闭包的时候可以声明一个叫做捕获列表这样一个内容, 就是说在闭包中所有进行内容捕获的东西都可以声明在这里, 如果我们要对这些内容加上一些限定的话, 就应该在捕获列表这里
        //: > 下面中括号的位置就是捕获列表, 可以在其中对被捕获的内容做限定, 这里把被捕获的 self 设置为 unowned (因为 self 不是可选型) 就可以了, 说明闭包对 self 变成了弱引用; 如果是因为引用其他的变量不是 self 导致的, 也是在这个捕获列表中将起设置为弱引用即可
        //: > 如果不使用 unowned 而使用 weak, 那么说明 self 是个可选型, 继续使用就需要解包了
        //        temperatureChange = { [weak self] newTemperature in
        //
        //            // 这里可以声明成 weakSelf 或者 `self` 都可以
        //            if let weakSelf = self {
        //                if abs(newTemperature - weakSelf.temperature) >= 10 {
        //                    print("It's not healthy to do it!")
        //                } else {
        //                    weakSelf.temperature = newTemperature
        //                    print("New temperature \(weakSelf.temperature) is set!")
        //                }
        //            }
        //
        //        }
        
        //: > 如果使用 unowned 就要程序员保证被捕获的变量不能为 nil, 否则可能发生崩溃, 也就是这个闭包执行的时候, self 不能被释放, 这个案例中不会发生这样的事情, 所以使用 unowned 和 weak 都可以
        temperatureChange = { [unowned self] newTemperature in
            
            // 闭包中的成员变量必须加上 self. 这说明了闭包在捕获值, 不加会提示 Reference to property 'temperature' in closure requires explicit 'self.' to make capture semantics explicit
            //: > 对于类中的变量的捕获, 这个闭包等于强引用了这个类对象, 同时由于这个闭包被这个类的一个属性强引用了, 最终导致了循环引用
            if abs(newTemperature - self.temperature) >= 10 {
                print("It's not healthy to do it!")
            } else {
                self.temperature = newTemperature
                print("New temperature \(self.temperature) is set!")
            }
        }
    }
    
    deinit {
        print("Smart Air-condition is being deinitialized!")
    }
}

var airCon: SmartAirCondition? = SmartAirCondition()
airCon?.temperature
airCon?.temperatureChange(100)
airCon?.temperatureChange(24)
airCon = nil

//: > 并不是所有的闭包都会导致循环引用, 只有被类给引用的闭包(比如赋值给了类的某个变量被那个变量引用了)内部同时使用类 self (也就是说闭包也引用了这个类) 才会发生循环引用

class ScoreBook {
    var scores: [Int]
    // 这个闭包没有引用这个类,不会产生循环引用
    var printTitle: () -> Void = {
        print("== Score ==")
    }
    
    // 这是个类型变量, 它引用了一个闭包, 同时闭包中引用了这个类的对象; 这并没有发生引用循环, 因为是这个类型引用了这个闭包, 同时这个闭包引用的是这个类型的一个对象; 这个类型在第一次使用的时候就会加载到内存, 它知道程序结束才会被释放呢
    static var changeScore: ((Int) -> Int)?
    
    init(scores: [Int]) {
        self.scores = scores
        print("Scorebook is initialized")
    }
    
    func printScore() {
        // 这个闭包没有被这个类引用, 不会产生循环引用
        scores.map { score in
            print("==\(score) ==")
        }
    }
    
    func changeScores() {
        if let changeScore = ScoreBook.changeScore {
            scores = scores.map(changeScore)
        }
    }
    
    deinit {
        print("Scorebook is being deinitialized!!")
    }
}

let scores: [Int] = [99, 85, 67, 13, 94]

var scoreBook: ScoreBook? = ScoreBook(scores: scores)
ScoreBook.changeScore = { score in
    return score - 2
}
scoreBook?.changeScores()
scoreBook?.printScore()
scoreBook = nil

//: [Previous](@previous) | [Next](@next)
