import UIKit

/*
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


// a??b 等价于三元远算 (a != nil ? a!: b)
func addTwoNum(num1: Int?, num2: Int?) -> Int {
    return (num1 ?? 0) + (num2 ?? 0)
}

let sum: Int = addTwoNum(num1: 3, num2: 2)

//a...b 等价于[a, b]
for idx in 1...5 {
    print("\(idx) * 5 = \(Int(idx * 5))")
}

//a..<b 等价于[a, b)
let namesArray = ["zhangsan", "lisi", "wangwu", "zhaoliu"]
let cnt = namesArray.count
for i in 0..<cnt {
    print(namesArray[i])
}

//单侧区间
for name in namesArray[2...] {
    print(name)
}

for name in namesArray[...2] {
    print(name)
}

let rangeInt = ...5
rangeInt.contains(7)
rangeInt.contains(4)
rangeInt.contains(-1)

//数组
for name in namesArray {
    print(name)
}

//字典
let dict = ["spider": 8, "ant": 6, "cat": 4]
for (k, v) in dict {
    print("key = \(k), value = \(v)")
    print(String(format: "key = %@, value = %d", k, v))
}

//_忽略临时变量名
let base = 3, power = 5
var answer = 1
for _ in 1...power {
    answer *= base
}
print(answer)

//分段区间
//stride(from:to:by:) 开区间
let minInterval = 5
for mark in stride(from: 0, to: 50, by: minInterval) {
    print(mark)
}
//stride(from:through:by:) 闭区间
for mark in stride(from: 0, through: 50, by: minInterval) {
    print(mark)
}

//repeat-while等价于do-while
var count = 0
repeat {
    print(count)
    count += 1
} while count < 5

//switch-case 不隐式贯穿
let anotherChar: Character = "a"
switch anotherChar {
case "a", "A":
    print("the letter A.")
default:
    print("not the letter A.")
}

//guard-else等价if-else
func isUpperCase(name: String?) {
    guard let tmp = name, tmp.count > 0 else {
        print("name is nil or empty string")
        return
    }
    print("Uppercased:\(tmp.uppercased())")
}

isUpperCase(name: "")
isUpperCase(name: "nigelli")
isUpperCase(name: nil)

//初始化
var arrayInt: [Int] = []
var arrayStr: [String] = []
var myArray = [String]()
var myArray2 = Array<String>()

let tenZero = Array(repeating: "0", count: 10)
print(tenZero)

let numbersArray = [Int](0...7)
print(numbersArray)

let personInfo = ["zhangsan": 27, "lisi": 28, "wangwu": 29]
let namesInfo = [String](personInfo.keys)
print(namesInfo)


//数组遍历
//forEach()
numbersArray.forEach { (num) in
    if num == 3 {
        print(num * 10)
    }
}

//Iterator
var numIterator = numbersArray.makeIterator()
while let num = numIterator.next() {
    print(num * 10)
}

//indices
for i in numbersArray.indices {
    print(numbersArray[i])
}

//数组查找
var arr2 = [10, 20, 45, 30, 98, 100, 30, 4]
print(arr2.first!)
print(arr2.last!)
print(arr2.first(where: {$0 > 25})!)
print(arr2.last(where: {$0 > 25})!)
print(arr2.firstIndex(of: 30)!)
print(arr2.lastIndex(of: 20)!)

let maxY: Int? = arr2.max()
print(maxY ?? 0)

let minY: Int? = arr2.min()
print(minY ?? 0)

*/
var arr = [10, 20, 45, 30, 98, 101, 30, 4]
print(arr.allSatisfy({$0 > 10}))
print(arr.allSatisfy({$0 >= 4}))

arr.append(100)
print(arr)

var num = [Int](2...7)
num.append(contentsOf: 100...105)
print(num)

num.insert(5, at: 3)
num.insert(contentsOf: 10...16, at: 3)
print(num)

var chars: [Character] = ["a", "b", "c"]
chars.insert(contentsOf: "123", at: 0)

let removeChar = chars.remove(at: 1)
print(chars)
let firstChar = chars.removeFirst()
print(chars)

struct Item {
    var price: Int
    var count: Int
}

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 10, count: 7),
        "Chips": Item(price: 12, count: 4),
        "Cigarette": Item(price: 27, count: 0),
    ]
    var coinsDeposited = 0
    
    func vend(name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("dispensing \(name), coinsDeposited \(coinsDeposited)")
    }
}

let preferSnacksDict = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Cigarette",
    "Nigel": "Candy Bar"
]

func buySnacks(person: String, vendingMachine: VendingMachine) throws {
    let snackName = preferSnacksDict[person] ?? "Candy Bar"
    try vendingMachine.vend(name: snackName)
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 10
do {
    try buySnacks(person: "Nigel", vendingMachine: vendingMachine)
//    try buySnacks(person: "Eve", vendingMachine: vendingMachine)
//    try buySnacks(person: "Alice", vendingMachine: vendingMachine)
//    try buySnacks(person: "Bob", vendingMachine: vendingMachine)
} catch VendingMachineError.invalidSelection {
    print("invalidSelection")
} catch VendingMachineError.outOfStock {
    print("outOfStock")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("insufficientFunds extraNeeded = \(coinsNeeded)")
} catch {
    print("unexpected error: \(error).")
}

