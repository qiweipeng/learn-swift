import Foundation

//: # 错误处理

//: ## 中断程序的函数

//:  - Note:
//:assert 函数, 返回值如果为假就会崩溃

assert(1 > 0)
//assert(1<0, "Error") // 崩溃的时候可以显示错误信息

//: > assertionFailure 函数是只要执行到它程序就直接中断了
//assertionFailure()
//assertionFailure("Error") // 附加错误信息

//: - Note:
//: 上面的叫断言，只会在 debug 环境生效；
//: 而下面的叫先决条件，是在生产环境也会生效的

precondition(1 > 0)
//precondition(1 < 0, "Error")

//fatalError()
//fatalError("Error")

//: ## 错误处理

// 可选型其实就比较像一种错误处理机制, 它会返回 nil 来告知问题, 但是也可能 nil 代表没有而不是出错了

//: > 下面举例说明, 我们设置一个自动贩卖机的类
class VendingMachine {
    
    // 这个结构代表贩卖机卖的商品
    struct Item {
        
        // 商品的类别
        enum `Type`: String {
            case Water
            case Cola
            case Juice
        }
        
        // 该商品的类型
        let type: Type
        // 该商品的价格
        let price: Int
        // 该商品的数量
        var count: Int
    }
    
    // 这里定义错误类型的枚举,需要遵守内置的 Error 协议,这样对于一些语法的关键字而言 Swift 就会自动处理
    enum ItemError: Error {
        case NoSuchItem // 没有该商品
        case NotEnoughMoney(Int) // 钱不够
        case OutOfStock // 没货了
    }
    
    // 贩卖机中商品的详情
    private var items = ["Mineral Water": Item(type: .Water, price: 2, count: 10), "Coca Cola": Item(type: .Cola, price: 3, count: 5), "Orange Juice": Item(type: .Juice, price: 5, count: 3)]
    
    // 贩卖,返回值是找零
    //: > 这个方法演示了错误抛出异常的写法,函数中 -> 前面需要加上 throws 关键字; 方法内部需要抛出异常的位置就使用 throw 关键字抛出一个遵守 Error 协议的枚举变量
    func vend(itemName: String, money: Int) throws -> Int? {
        
        // 对于 defer 语句,不管是正常退出函数函数异常退出都会在最后执行
        defer {
            print("Have a nice day!")
        }
        
        guard let item = items[itemName] else {
            // 使用 throw 就不用在 return 了
            throw VendingMachine.ItemError.NoSuchItem
        }
        guard money >= item.price else {
            // 在内部,可以省略 VendingMachine
            throw ItemError.NotEnoughMoney(item.price)
        }
        guard item.count > 0 else {
            throw VendingMachine.ItemError.OutOfStock
        }
        
        // 一个方法中可以使用多个 defer ,这个放在后面,也就是说,只有正常购买的情况才会允许它了,但是它也是在函数退出作用域的时候才会执行,并且说优先于前一个 defer 执行的,也就是说, defer 是倒叙执行的
        defer {
            print("Thank you")
        }
        
        dispenseItem(itemName)
        
        return money - item.price
    }
    
    // 分发商品
    private func dispenseItem(_ itemName: String) {
        items[itemName]!.count -= 1
        print("Enjoy your", itemName)
    }
    
    func display() {
        print("Want something to drink?")
        
        for itemName in items.keys {
            print("*", itemName)
        }
        print("====================")
    }
}

let machine = VendingMachine()
machine.display()
//: > 对于可以抛出异常的函数,不能直接调用,必须考虑处理异常

//: > 1. 使用 try! 强制处理,类似可选型的强制解包,程序员必须保证函数调用是不会产生异常的才能使用 try!,不然会崩溃
//try! machine.vend(itemName: "Coca", money: 10)

//: > 2. 使用 try? 如果发生异常,就会返回 nil

try? machine.vend(itemName: "Coca Cola", money: 10)

//: > 3. 最常用的,我们希望根据不同的异常去做处理

do { // do 模块中可以执行任意行代码,不管哪行捕获到了异常都会跳到 catch 模块当中
    try machine.vend(itemName: "Coca", money: 5)
} catch {
    print("Error occured during vending.")
}

//: > 下面这样是苹果推荐的错误处理的方式,通过不同的 catch 捕获不同的错误类型然后分别处理,最后再补上一个通用的捕获剩下的其他错误
do { // do 模块中可以执行任意行代码,不管哪行捕获到了异常都会跳到 catch 模块当中
    try machine.vend(itemName: "Coca Cola", money: 2)
} catch VendingMachine.ItemError.NoSuchItem { // catch 模块后面可以跟希望捕获的异常的类型, 其他异常就不会被捕获
    print("没有这个东西呀")
} catch VendingMachine.ItemError.NotEnoughMoney(let price) {
    print("钱不够呀,这款商品卖 \(price)")
} catch VendingMachine.ItemError.OutOfStock {
    print("数量不够")
} catch {
    print("建议最后再跟一个通用的,如果发生的异常在指定的异常之外,就走这里")
}

//: > 我们还可以使用一种更方便的方式,将上面的那个枚举改成
//enum ItemError: Error, CustomStringConvertible {
//    case NoSuchItem // 没有该商品
//    case NotEnoughMoney(Int) // 钱不够
//    case OutOfStock // 没货了
//
//    var description: String {
//        switch self {
//        case .NoSuchItem:
//            return "商品不存在"
//        case .NotEnoughMoney(let price):
//            return "钱不够,商品价格为 \(price)"
//        case .OutOfStock:
//            return "数量不够"
//    }
//}

//: > 此时就可以使用下面的方式了,这种方式在 iOS 中也非常多,比如网络异常,错误种类非常多,我们很难把所有错误全部一一枚举出来,我们就可以先接收这个错误变量,然后再去处理

//do {
//    try machine.vend(itemName: "Coco", money: 3)
//} catch let error as VendingMachine.ItemError { // 这里就可以接收所有类型是 VendingMachine.ItemError 的错误了
//    print(error)
//} catch { // 这种情况也最好最后加一个兜底的情况负责捕获其他的错误
//    print("Error occured during vending")
//}

//: ## defer

//: > 不管程序有没有产生异常,都要有一些后续处理必须需要做,比如操作文件产生了异常,但是函数后面后续关闭文件的操作必须要进行

//: > Swift 中,可以在所有可能退出函数的语句之前加上 defer {}, defer 中的代码会推迟到当前作用域退出到时候才会执行,不管是正常退出还是异常退出;一个方法中可以有多个 defer, 他们是倒序执行的

//: > defer 的使用要把握度,因为它也是控制转移关键字,和 break,continue等等一样,不建议多用

//: [Previous](@previous) | [Next](@next)
