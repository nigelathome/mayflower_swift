import UIKit

//var str = "Hello, playground"
//print(str)

var str : String
var a : Int
//str = a //编译间报错

//常量用let声明
let π = 3.14
let key : String = "key"

//变量用var声明
var x = 0.0, y = 1.0, z = 2.0
var name : String
name = "nigelli 2021"


var num1 : UInt = 7
var num2 : Int = -3
var num3 : Double = -17.0
var num4 : Float = -13.0
var isEmpty : Bool = true

typealias SampleRate = UInt8
let rate : SampleRate = 20

//常量tuple
let compInfo = (url: "www.compass.real.estate.com", location:"NY, US", emp_num: 2000)
print(compInfo.url, compInfo.location, compInfo.emp_num)

//变量tuple
var error = (errorCode: 1, errorMsg: "网络错误")
print(error.errorCode)
print(error.errorMsg)
error.errorCode = 2
print(error.errorCode)

//Any表示任意类型
var callBackTuple : (Any, String) = (1, "没有权限")
print(callBackTuple)
print(callBackTuple.0, callBackTuple.1)

//_表示不需要的显示的参数的占位
var returnValueTuple : (UInt, UInt) = (7, 13)
var (_, returnValueKey) = returnValueTuple
print(returnValueKey)

//tuple做函数返回值
func seekAtInfo(pos: UInt) -> (key: String, value: String) {
    return ("key", "value")
}

var seekInfo = seekAtInfo(pos: 30)
print(seekInfo.key, seekInfo.value)

//optional
var str1: String? = "abc"
if str1 != nil {
    let count = str1!.count
    print(String(format: "count=%d", count))
}

var str2: String? = "abc"
if str2 != nil {
    let count = str2.unsafelyUnwrapped.count
    print(String(format: "count=%d", count))
}

//String初始化
var emptyString1 = ""
var emptyString2: String = String()

//判断是否是空串
if emptyString1.isEmpty {
    print(String(format: "emptyString1 is empty"))
}
if emptyString2.isEmpty {
    print(String(format: "emptyString2 is empty"))
}

//多行字面量 使用""" XXX """
let aboutSwift = """
Swift is a powerful and intuitive programming language for iOS, iPadOS, macOS, tvOS, and watchOS. \
Writing Swift code is interactive and fun, the syntax is concise yet expressive, and Swift includes modern features developers love. \
Swift code is safe by design, yet also produces software that runs lightning-fast.
"""
print(aboutSwift)

//可变字符串
var varString: String = "Horse"
varString += " and carriage"

//不可变字符串
let constString: String = "Highlander"

//String是值类型 不同于Objective-C的引用类型
var strA: String = "0710"
var strB: String = strA
print(strA == strB)
strB += "0908"
print(strA)
print(strB)
print(strA == strB)

//for-in 遍历String中的每个字符
for char in "Highlander" {
    print(char)
}

//通过[Character]构造字符串
let charArray: [Character] = ["H", "i", "g", "h", "l", "a", "n", "d", "e", "r"]
let charString: String = String(charArray)
print(charString)

//+和append()拼接字符串
print(charString + "and another highlander")
print(charString.appending("and another highlander"))

//\(A) 输出a的值 实现stringWithFormat用法
let multiplier = 3
let msg = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5) "

//String索引
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
greeting[greeting.index(before: greeting.endIndex)]
greeting[greeting.index(after: greeting.startIndex)]
let index = greeting.index(greeting.startIndex, offsetBy: 7)
print(greeting[index])

//insert()字符串插入
var tips = "hold on"
tips.insert("!", at: tips.endIndex)
tips.insert(contentsOf: "pls ", at: tips.startIndex)

//move:at()字符串移除
tips.remove(at: tips.index(before: tips.endIndex))
print(tips)

//range获取子串 removeSubrange()删除
let range = tips.index(tips.endIndex, offsetBy: -7)..<tips.endIndex
tips.removeSubrange(range)
print(tips)

//Substring
let greetingWords = "Hello, world!"
let idx = greetingWords.firstIndex(of: ",") ?? greetingWords.endIndex
let subString: Substring = greetingWords[..<idx]
let newString = Substring(subString)
print(newString)

//字符串比较
print(greetingWords == newString)
print(subString != newString)
print(greetingWords.hasPrefix("Hello"))
print(greetingWords.hasSuffix("!"))


//合并空值运算符

