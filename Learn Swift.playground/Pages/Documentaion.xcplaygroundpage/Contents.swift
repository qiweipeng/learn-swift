import Foundation

//: # 文档注释

/**
 多行文档注释
 */

/// 单行文档注释

/**
 正常文字
 
 *斜体*
 **粗体**
 
 [超链接Google](https://www.google.com)
 
 # 标题
 ## 标题2
 
 - 无序列表
 - 无序列表
 
 1. 有序
 2. 有序
 
 插入代码
 ```
 let a: Int = 1
 ```
 */
func test() {
    
}

/// <#Description#>
///
/// - Parameter param: <#param description#>
/// - Returns: <#return value description#>
/// - Throws: <#throws value description#>
func showMultilineComments(param: Int) throws -> String {
    return "Hello"
}

//: [Previous](@previous) | [Next](@next)
