import Foundation

// # 构造器

//: ## 两段式构造

class Avatar {
    
    var name: String
    var life = 100
    var isAlive = true
    
    init(name: String) {
        self.name = name
    }
}

class User1: Avatar {
    var group: String
    
    // 这里需要先把子类的属性初始化, 然后父类属性的初始化必须通过调用父类构造函数来完成
    init(name: String, group: String) {
        
        // 1. 构造初值
        self.group = group
        super.init(name: name)
        
        // 2. 进一步完善,书写逻辑,在这里才能使用 self
    }
}

//: ## 便利构造函数和指定构造函数

//: > 首先说两点 1. 构造函数是可以有默认参数的 2. 构造函数是可以被重载的

class User2: Avatar {
    var group: String
    
    // 这里需要先把子类的属性初始化, 然后父类属性的初始化必须通过调用父类构造函数来完成
    init(name: String, group: String) {
        
        // 1. 构造初值
        self.group = group
        super.init(name: name)
        
        // 2. 进一步完善, 书写逻辑, 在这里才能使用 self
    }
    
    // 便利构造函数是基于自身的指定构造函数完成, 其内部会调用 self. 指定构造函数, 最终的构造过程还是在指定构造函数中完成的
    convenience init(group: String) {
        self.init(name: "Guest", group: group)
    }
}

//: ## 构造函数的继承

/*:
 几个原则:
 1. 只要父类创建了自己的指定构造函数, 父类指定构造函数就不再被继承, 同时其便利构造函数也不再被继承
 2. 如果子类重写了所有的父类指定构造函数, 则父类的便利构造函数重新被继承
 3. 便利构造函数依托于指定构造函数, 有可能被继承, 但无法被重写
 */

class Person {
    let name: String
    
    // 父类指定构造函数
    init(name: String) {
        self.name = name
    }
    
    // 父类便利构造函数
    convenience init(firstName: String, lastName: String) {
        self.init(name: firstName + " " + lastName)
    }
}

class Student: Person {
    
    var studentNumber: Int
    
    /*:
     > 1. 一旦子类实现了自己的指定构造函数, 那么父类的指定构造函数将不再提供; 这是有原因的, 因为如果还提供父类的指定构造函数, 那么 studentNumber 这个属性在父类的构造函数中是没有被初始化的, 那个构造函数显然就不能有;
     2. 父类的指定构造函数消失, 附带的父类的便利构造函数就也不会被继承;
     3. 如果字类重写了所有的父类的指定构造函数, 父类的便利构造函数就会重新被继承
     */
    init(name: String, studentNumber: Int) {
        self.studentNumber = studentNumber
        super.init(name: name)
    }
    
    //: > 原本子类只有一个构造函数, 一旦重写了这个父类的指定构造函数, 子类将一下子有了三个构造函数
    //    override init(name: String) {
    //        self.studentNumber = 000
    //        super.init(name: name)
    //    }
    
    //: >当然重写的构造函数也可以是便利构造函数
    override convenience init(name: String) {
        self.init(name: name, studentNumber: 000)
    }
    
    //: > 便利构造函数只可能被继承, 无法被重写, 它被继承的条件就是, 子类已经继承了所有父类的指定构造函数
}

let roger = Student(name: "Roger")

//: ## required 构造函数

//: > 构造函数加上 required 关键字代表子类必须实现

class Person1 {
    let name: String
    
    // 父类指定构造函数
    required init(name: String) {
        self.name = name
    }
    
    // 父类便利构造函数
    convenience init(firstName: String, lastName: String) {
        self.init(name: firstName + " " + lastName)
    }
}

class Student1: Person1 {
    
    var studentNumber: Int
    
    // 对于 required 的构造函数, 子类重写不需要再写 override, 而是还写 required
    required init(name: String) {
        studentNumber = 000
        super.init(name: name)
    }
}

//: [Previous](@previous) | [Next](@next)
