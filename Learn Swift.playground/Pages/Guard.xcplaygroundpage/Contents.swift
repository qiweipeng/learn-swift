import Foundation

//: # Guard

// 没有使用 guard
func buy(money: Int, price: Int, capacity: Int, volume: Int) {
    
    if money >= price {
        if capacity >= volume {
            print("可以买!")
        } else {
            print("空间不足")
        }
    } else {
        print("钱不够")
    }
}

// 使用 guard, 避免了层层深入,把核心逻辑放在最后,可读性强
func buy2(money: Int, price: Int, capacity: Int, volume: Int) {
    
    guard money >= price else {
        print("钱不够")
        return
    }
    guard capacity >= volume else {
        print("空间不足")
        return
    }
    print("可以买!!")
}

//: [Previous](@previous) | [Next](@next)
