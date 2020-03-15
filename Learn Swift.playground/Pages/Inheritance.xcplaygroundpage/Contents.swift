import Foundation

// # 继承

//: ## 继承

class Avatar {
    
    var name: String
    var life = 100
    var isAlive = true
    
    init(name: String) {
        self.name = name
    }
    
    func  beAttacked(attack: Int) {
        life -= attack
        
        if life <= 0 {
            isAlive = false
        }
    }
}

class User: Avatar {
    var score = 0
}

let player0 = User(name: "Roger")
player0.name
player0.score
player0.beAttacked(attack: 20)

final class Magician: User {
    var magic = 100
}

let magician = Magician(name: "Harry")

//: ## 多态

final class Warrior: User {
    var weapin: String?
    
}

class Monster: Avatar {
    
    func attack(user: User, amount: Int) {
        user.beAttacked(attack: amount)
    }
}

final class Zombie: Monster {
    var type = "Default"
}

let player1 = Magician(name: "Harry Potter")
let player2 = Warrior(name: "Roger Federer")

let zombie = Zombie(name: "default zombie")
let monster = Monster(name: "monster")

func printBasicInfo(avatar: Avatar) {
    print("The name is \(avatar.name)")
    print("The life is \(avatar.life)")
}

// 多态性的展现, 父类指针可以指向子类对象, 能传入父类的地方就能传入子类
printBasicInfo(avatar: player1)
printBasicInfo(avatar: zombie)
printBasicInfo(avatar: monster)

// 通过多态, 可以将不同对象放入一个数组
let avatarArr: [Avatar] = [player1, player2, zombie, monster]

//: ## 重载
// 只解释一点, final 关键字代表不能被重载, 可不是代表不能被继承, 如果不希望被继承, 直接 private

//: [Previous](@previous) | [Next](@next)
