import UIKit

//: # 类型

//: ## 类型检查

class MediaItem {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    
    var genre: String
    
    init(name: String, genre: String) {
        self.genre = genre
        super.init(name: name)
    }
}

class Music: MediaItem {
    
    var artist: String
    
    init(name: String, astistName: String) {
        self.artist = astistName
        super.init(name: name)
    }
}

class Game: MediaItem {
    
    var developer: String
    
    init(name: String, developer: String) {
        self.developer = developer
        super.init(name: name)
    }
}

// 定义一个数组
let library: [MediaItem] = [
    Movie(name: "Zootopia", genre: "Animation"),
    Music(name: "Hello", astistName: "Adele"),
    Game(name: "LIMBO", developer: "Playdead"),
    Music(name: "See you again", astistName: "Wiz Khalifa"),
    Game(name: "The Bridge", developer: "The Quantum")
]

var musicCount = 0
var movieCount = 0
var gameCount = 0

//: > 重点关键字 is 可以用来判断一个变量是否是某个类型或者某个类型的子类
for mediaItem in library {
    
    if mediaItem is Game {
        movieCount += 1
    } else if mediaItem is Music {
        musicCount += 1
    } else if mediaItem is Game {
        gameCount += 1
    }
}

//: ## 类型转换

//: > 第二个重点关键字 as 可以用作父类向子类的转换,如果它是一个父类指针指向的子类对象,即名义上是父类类型,实质上是子类类型,可以使用 as 进行转换
// 强制转换,如果失败就崩溃
library[0] as! Movie
// 返回值是一个可选型,如果失败返回 nil
library[0] as? Movie

for mediaItem in library {
    
    if let movie = mediaItem as? Movie {
        print("Movie:", movie.name, "Genre:", movie.genre)
    } else if let music  = mediaItem as? Music {
        print("Music:", music.name, "Artist:", music.artist)
    } else if let game = mediaItem as? Game {
        print("Game:", game.name, "Developer:", game.developer)
    }
}

//: ## 检查协议的遵守
//: > is 和 as 关键字不仅可以用于判断父类子类的类型关系,可以判断对协议的遵守情况
protocol Shape {
    var name: String { get }
}

protocol HasArea {
    func area() -> Double
}

struct Point: Shape {
    let name: String = "point"
    var x: Double
    var y: Double
}

struct Rectangle: Shape, HasArea {
    
    let name: String = "rectangle"
    var origin: Point
    var width: Double
    var height: Double
    
    func area() -> Double {
        return width * height
    }
}

struct Circle: Shape, HasArea {
    
    let name: String = "circle"
    var center: Point
    var radius: Double
    
    func area() -> Double {
        return .pi * radius * radius
    }
}

struct Line: Shape {
    
    let name = "line"
    var a: Point
    var b: Point
}

let shapes: [Shape] = [
    Rectangle(origin: Point(x: 0, y: 0), width: 3, height: 4),
    Point(x: 0, y: 0),
    Circle(center: Point(x: 0, y: 0), radius: 1),
    Line(a: Point(x: 1, y: 1), b: Point(x: 5, y: 5))
]

for shape in shapes {
    if shape is HasArea {
        print("This shape has area")
    }
}

for shape in shapes {
    if let areaShape = shape as? HasArea {
        print("The area of \(shape.name) is \(areaShape.area())")
    } else {
        print("This shape has no area")
    }
}

//: > NSObject, AnyObject, Any

//: > NSObject 是 OC 中的所有类的父类, 而 AnyObject 相当于层级更高, 有点像 id 类型, 它脱离了继承树, 任何一个对象, 包括结构, 即使没有继承任何父类, 也是一个 AnyObject; Any 就更高了, 甚至是函数都属于 Any

class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

func test() {
}

var aFunc = test

var objects: [NSObject] = [
    //    CGFloat(3.14159),
    //    "Hello",
    UIColor.blue,
    NSDate(),
    //    Int(32),
    //    Array<Int>([1, 2, 3]),
    //    Person(name: "Jack"),
    //    aFunc
]

var objects2: [AnyObject] = [
    //    CGFloat(3.14159),
    //    "Hello",
    UIColor.blue,
    NSDate(),
    //    Int(32),
    //    Array<Int>([1, 2, 3]),
    Person(name: "Jack"),
    //    aFunc
]

var objects3: [Any] = [
    CGFloat(3.14159),
    "Hello",
    UIColor.blue,
    NSDate(),
    Int(32),
    Array<Int>([1, 2, 3]),
    Person(name: "Jack"),
    aFunc
]

//: [Previous](@previous) | [Next](@next)
