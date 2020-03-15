import Foundation

//: # 运算符重载

//: ## 系统运算符重载
struct Vector3 {
    
    var x = 0.0
    var y = 0.0
    var z = 0.0
    
    var length: Double {
        return sqrt(x * x + y * y + z * z)
    }
}

//: > 运算符的重载是在写这个类型的外面;
//: > 运算符的重载本质上就是一个函数, 只不过这个函数名字很特殊
//: > 所谓的运算符其实就是一个函数
func +(left: Vector3, right: Vector3) -> Vector3 {
    return Vector3(x: left.x + right.x, y: left.y + right.y, z: left.z + right.z)
}

func -(left: Vector3, right: Vector3) -> Vector3 {
    return Vector3(x: left.x - right.x, y: left.y - right.y, z: left.z - right.z)
}

// 运算符重载返回的不一定是原类型
func *(left: Vector3, right: Vector3) -> Double {
    return left.x * right.x + left.y * right.y + left.z * right.z
}

// 同一个运算符可以多次重载来表示不同的运算
func *(left: Vector3, a: Double) -> Vector3 {
    return Vector3(x: left.x * a, y: left.y * a, z: left.z * a)
}

// 只写上面的可以用 va * 3 但是不能使用 3 * va
func *(a: Double, right: Vector3) -> Vector3 {
    //    return Vector3(x: a * right.x, y: a * right.y, z: a * right.z)
    // 由于前面已经重载过这个运算符了这里就可以直接用
    return right * a
}

func +=(left: inout Vector3, right: Vector3) {
    //    left = Vector3(x: left.x + right.x, y: left.y + right.y, z: left.z + right.z)
    left = left + right
}

// 对于单目运算符的重载, 我们必须指名这个运算符是放在前面还是放在后面, 因此需要在函数前面加 prefix 或者 postfix
prefix func -(vector: Vector3) -> Vector3 {
    return Vector3(x: -vector.x, y: -vector.y, z: -vector.z)
}

// 对于比较运算符重载, 返回值应该是个 Bool
func ==(left: Vector3, right: Vector3) -> Bool {
    return left.x == right.x && left.y == right.y && left.z == right.z
}

func !=(left: Vector3, right: Vector3) -> Bool {
    return !(left == right)
}

func <(left: Vector3, right: Vector3) -> Bool {
    if left.x != right.x {
        return left.x < right.x
    }
    if left.y != right.y {
        return left.y < right.y
    }
    if left.z != right.z {
        return left.z < right.z
    }
    
    return false
}

func <=(left: Vector3, right: Vector3) -> Bool {
    return left < right || left == right
}

func >(left: Vector3, right: Vector3) -> Bool {
    return !(left <= right)
}

func >=(left: Vector3, right: Vector3) -> Bool {
    return !(left < right)
}

//: > 赋值符号 = 是无法被重载的, 或者我们可以不把 = 看作是运算符

var va = Vector3(x: 1.0, y: 2.0, z: 3.0)
let vb = Vector3(x: 3.0, y: 4.0, z: 5.0)
let vc = Vector3(x: 4.0, y: 6.0, z: 7.0)

va + vb // 默认情况下, 自定义结构体的这两个变量是无法进行加法操作的, 当重载运算符之后这个运算就变得合法了
vb - va
va * vb
va * 3
3 * va
//va += vb
-va
va == vb
va != vb

//: ## 自定义运算符重载

//: 自定义运算符选择符号的范围是 ASCII码中的/,=,-,+,!,*,%,<,>,&,|,^,或者 ~, 或者一个 Unicode 字符
// 这个符号定义向量各个分离都加1

//: > 对于自定义的运算符, 必须先声明一下, 定义这个运算符, 然后才能重载
postfix operator +++
postfix func +++(vector: inout Vector3) -> Vector3 {
    vector += Vector3(x: 1.0, y: 1.0, z: 1.0)
    return vector
}

va+++

// 计算两个向量的夹角

infix operator ^

func ^(left: Vector3, right: Vector3) -> Double {
    return acos((left * right) / (left.length * right.length))
}

va ^ vb

//: > 目前的运算符只能用于两个变量的计算, 因为还没有定义结合性和优先级, 这些内容等用到了再学习

//: [Previous](@previous) | [Next](@next)
