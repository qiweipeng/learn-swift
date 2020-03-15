import Foundation

//: # 代理

//: ## 自定义代理

// 回合制游戏
protocol TurnBaseGame {
    
    // 回合数
    var turn: Int { get set }
    // 玩
    func play()
}

protocol TurnBaseGameDelegate {
    
    func gameStart()
    func playerMove()
    func gameEnd()
    
    func gameOver() -> Bool
}

// 这个类只规定抽象的游戏规则, 不进行具体游戏内容的设置, 具体的设置交给代理去做
class SinglePlayerTurnBaseGame: TurnBaseGame {
    
    var turn: Int = 0
    // 设置代理变量
    var delegate: TurnBaseGameDelegate!
    
    func play() {
        delegate.gameStart()
        while !delegate.gameOver() {
            print("ROUND", turn, ":")
            delegate.playerMove()
            turn += 1
        }
        delegate.gameEnd()
    }
}

//: > 设计第一款游戏, 丢骰子

class RollNumberGame: SinglePlayerTurnBaseGame, TurnBaseGameDelegate {
    
    var score = 0
    
    override init() {
        super.init()
        delegate = self
    }
    
    func gameStart() {
        score = 0
        turn = 0
        print("开始游戏")
    }
    
    func playerMove() {
        let rollNumber = Int(arc4random()%6 + 1)
        score += rollNumber
        print("您本局得分为 \(rollNumber), 目前总分为 \(score)" )
    }
    
    func gameEnd() {
        print("恭喜您完成游戏")
    }
    
    func gameOver() -> Bool {
        return score >= 100
    }
}

let game = RollNumberGame()
game.play()

//: > 设计第二款游戏, 石头剪刀布

class RockPaperScissors: SinglePlayerTurnBaseGame, TurnBaseGameDelegate {
    
    enum Shape: Int {
        case Rock
        case Scissors
        case Paper
        
        func beat(shape: Shape) -> Bool {
            return (self.rawValue + 1) % 3 == shape.rawValue
        }
    }
    
    var wins = 0
    
    override init() {
        super.init()
        delegate = self
    }
    
    static func go() -> Shape {
        return Shape(rawValue: Int(arc4random()) % 3)!
    }
    
    func show(_ hand: Shape) -> String {
        switch hand {
        case .Paper:
            return "Paper"
        case .Rock:
            return "Rock"
        case .Scissors:
            return "Scissors"
        }
    }
    
    func gameStart() {
        wins = 0
        print("游戏开始")
    }
    
    func playerMove() {
        let yourShape = RockPaperScissors.go()
        let otherShape = RockPaperScissors.go()
        print("Your:", show(yourShape))
        print("Other:", show(otherShape))
        
        if yourShape.beat(shape: otherShape) {
            print("You win this round")
            wins += 1
        } else {
            print("这轮你输了")
        }
    }
    
    func gameEnd() {
        if wins > 2 {
            print("You win!")
        } else {
            print("You lose...")
        }
    }
    
    func gameOver() -> Bool {
        // 三局两胜
        return turn >= 3
    }
}

let game1 = RockPaperScissors()
game1.play()

//: ## 可选的协议方法
//: > 如果一个协议希望有可选方法, 那么这个协议前面必须增加 @objc 关键字说明这是一个 OC 的协议, 然后在可选方法前加上 @objc optional 关键字, 并且后面不能跟 { get set } 或者 { get }; 事实上, 只要这个协议是 @objc 的, 那么即使协议内部有必选协议, 也不能跟 { get set } 或者 { get }; 同时这种协议只能被 class 遵守
@objc protocol OptionalProtocol {
    @objc optional func test1()
    
    func test2()
}

class demo: OptionalProtocol {
    func test2() {
    }
}

//: [Previous](@previous) | [Next](@next)
