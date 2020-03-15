import Foundation

//: # 下标

//: ## 下标基础

var arr = [0, 1, 2, 3]
var dict = ["北京": "Beijing", "纽约": "New York", "巴黎": "Paris"]

// 数组和字典中, []传入参数, 这就是下标
arr[0]
dict["北京"]

//: > Swift 中, 我们可以为自己所创建的任何类型(枚举、结构体、类)来定义下标的意义

// 定义一个三维向量的结构体
struct Vector1 {
    
    var x = 0.0
    var y = 0.0
    var z = 0.0
}

let v1 = Vector1(x: 1.0, y: 2.0, z: 3.0)
// 默认都是通过点语法访问成员变量
v1.x

//: > 默认情况下, 这个结构体是没有下标这个成员函数的
//v[0] // 这样是会报错的 Type 'Vector3' has no subscript members

//: > 如果我们定义下标函数, 那么这个结构体就可以使用下标访问成员变量了

struct Vector2 {
    
    var x = 0.0
    var y = 0.0
    var z = 0.0
    
    subscript(index: Int) -> Double? { // 参数就是下标索引, 因此是 Int 类型, 返回值就是成员变量, 因此就是 Double, 又因为可能返回 nil, 因此是 Double?
        
        switch index {
        case 0: return x
        case 1: return y
        case 2: return z
        default: return nil // 对于 switch 语句, 必须穷举
        }
    }
}

var v2 = Vector2(x: 1.0, y: 2.0, z: 3.0)
// 此时就可以使用下标进行访问了
v2[0]
//v2[1] = 3 // 但是由于下标函数是只读的, 这里不能进行赋值

//: > 如果希望下标函数是可读写的, 就把 set 和 get 都写上
struct Vector3 {
    
    var x = 0.0
    var y = 0.0
    var z = 0.0
    
    subscript(index: Int) -> Double? {
        
        get {
            switch index {
            case 0: return x
            case 1: return y
            case 2: return z
            default: return nil
            }
        }
        
        set {
            guard let newValue = newValue else { return }
            switch index {
            case 0, 1, 2: x = newValue
            default: return
            }
        }
    }
}

var v3 = Vector3(x: 1.0, y: 2.0, z: 3.0)
v3[0]
v3[1] = 4.0
v3[9] = 4.0

//: > 我们甚至可以为一个类型同时定义多个下标, 比如这个结构体我们还可以定义一个字符串下标
struct Vector4 {
    
    var x = 0.0
    var y = 0.0
    var z = 0.0
    
    subscript(index: Int) -> Double? {
        
        get {
            switch index {
            case 0: return x
            case 1: return y
            case 2: return z
            default: return nil
            }
        }
        
        set {
            // newValue 是 Double? 类型, 下标函数的返回值是 Double? 说明允许返回 nil, 那么也就允许设置 nil
            guard let newValue = newValue else { return}
            switch index {
            case 0: x = newValue
            case 1: y = newValue
            case 2: z = newValue
            default: return
            }
        }
    }
    
    subscript(axis: String) -> Double? {
        
        get {
            switch axis {
            case "x", "X": return x
            case "y", "Y": return y
            case "z", "Z": return z
            default: return nil
            }
        }
        
        set {
            guard let newValue = newValue else { return }
            switch axis {
            case "x", "X": x = newValue
            case "y", "Y": y = newValue
            case "z", "Z": z = newValue
            default: return
            }
        }
    }
}

var v4 = Vector4(x: 1.0, y: 2.0, z: 3.0)
v4[1]
v4["x"]
v4["Y"] = 4.0

//: ## 多维下标

struct Matrix {
    
    var data: [[Double]]
    let r: Int
    let c: Int
    
    init(row: Int, col: Int) {
        self.r = row
        self.c = col
        data = [[Double]]()
        
        for _ in 0..<r {
            let aRow = Array(repeating: 0.0, count: col)
            data.append(aRow)
        }
    }
    
    subscript(x: Int, y: Int) -> Double {
        
        get {
            // 对于数组来将, 不能因为越界就返回 nil, 而应该程序崩溃, 这里就应该使用断言来保证数组的不越界
            assert(x >= 0 && x < r && y >= 0 && y < c, "Index Out of Range")
            
            return data[x][y]
        }
        
        set {
            assert(x >= 0 && x < r && y >= 0 && y < c, "Index Out of Range")
            data[x][y] = newValue
        }
    }
    
    subscript(row: Int) -> [Double] {
        
        get {
            assert(row >= 0 && row < r, "Index Out of Range")
            return data[row]
        }
        
        set(vector) {
            assert(vector.count == c, "Column Number dose NOT match")
        }
    }
}

var m = Matrix(row: 2, col: 2)
// 此时就可以使用多维下标了
m[1,1]
m[1,1] = 100.0
//m[2,2]
m[1][1]

m[0] = [1.5, 4.5]
m[0][1]
m[0,0]

//: [Previous](@previous) | [Next](@next)
