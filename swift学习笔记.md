# Swift学习笔记
[toc]
##Swift简介
###Swift发展历程
* 2010年开始，目前经历了5个版本
* OC从80年代开始目前只有2个版本
* 2015年开源
* 最新版本是2019.3 swift 5.0

###Swift和Objective-C的不同
* Swift支持面向协议编程、函数式编程、面向对象编程；Objective-C主要以面向对象编程
* Swift是类型安全；Objective-C不是

	```
	var str : String
	var a : Int
	str = a //编译间报错 Cannot assign value of type 'Int' to type 'String'
	
	NSString *str = @"";
	NSNumber *num = [NSNumber numberWithInt:7];
	str = num;//编译器仅会警告
	```

* Swift中的Int、Double、Float、String、Array、Dictionary、Set都是值类型；Objective-C中的NSNumber、NSString、NSString、NSArray、NSDictionary、NSSet都是引用类型，NSInteger、CGFloat都是值类型
* Swift枚举类型支持协议、扩展、泛型；Objective-C枚举基于c语言枚举较为简单
* Swift完全支持泛型；Objective-C泛型较为简单
* Swift协议更加丰富，支持值类型和枚举；Objective-C只针对类的协议
* Swift函数可以直接作为返回值类型；Objective-C需要使用selector或block才能实现
* Swift编译前端使用swiftc；Objective-C使用Clang

##基本数据类型
###常量和变量
```
//常量用let声明
let π = 3.14
let key : String = "key"

//变量用var声明
var x = 0.0, y = 1.0, z = 2.0
var name : String
name = "nigelli 2021"
```

###基本数据类型
```
//UInt = NSUInteger, Int = NSInteger 根据平台位数兼容
var num1 : UInt = 7
var num2 : Int = -3

//Float和Double在OC中对应CGFloat，Float 4位、Double 8位
var num3 : Double = -17.0
var num4 : Float = -13.0

var isEmpty : Bool = true

//typedef = typealias
typealias SampleRate = UInt8
let rate : SampleRate = 20
```

###tuple
```
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
```

###可选类型（Optional）
```
//可选类型的定义？
var str1: String? = "abc"
if str1 != nil {
//可选类型使用!解包后才能使用其中的值
    let count = str1!.count
    print(String(format: "count=%d", count))
}

var str2: String? = "abc"
if str2 != nil {
	//!等价于使用unsafeUnwrapped解包
    let count = str2.unsafelyUnwrapped.count
    print(String(format: "count=%d", count))
}
```

###字符串
```
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
```

##运算符
###合并空值运算符

```
//a??b 等价于三元远算 (a != nil ? a!: b)
func addTwoNum(num1: Int?, num2: Int?) -> Int {
    return (num1 ?? 0) + (num2 ?? 0)
}

let sum: Int = addTwoNum(num1: 3, num2: 2)
```

###区间运算符
```
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
```

##流程控制
###for-in
```
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
```

###repeat-while
```
//repeat-while等价于do-while
var count = 0
repeat {
    print(count)
    count += 1
} while count < 5
```

###switch-case
```
//switch-case 不隐式贯穿到下一个case
let anotherChar: Character = "a"
switch anotherChar {
case "a", "A":
    print("the letter A.")
default:
    print("not the letter A.")
}
```

###guard-else
```
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
```

##集合类
###数组
```
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

//allSatisfy(_:)数组中是否存在满足条件的元素
var arr = [10, 20, 45, 30, 98, 101, 30, 4]
print(arr.allSatisfy({$0 > 10}))
print(arr.allSatisfy({$0 >= 4}))

//数组添加和删除
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

```

###集合
```
var letters = Set<Character>()
letters.insert("N")
print(letters)

//set元素唯一
var courses: Set<String> = ["English", "Computer", "Math"]
courses.insert("Computer")
print(courses)

//顺序变量set中元素
for cs in courses {
    print(cs)
}

if !courses.isEmpty {
    print(courses.count)
}

//顺序遍历
for cs in courses.sorted() {
    print(cs)
}

//结构体/类作为set元素 需要实现hash协议
struct Man {
    var name: String
    var age: Int
}

extension Man: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(age)
    }
}

//定义集合中相等的元素
extension Man: Equatable {
    static func == (lo: Man, ro: Man) -> Bool {
        return lo.name == ro.name
    }
}

var manSet = Set<Man>()
manSet.insert(Man(name: "Frank", age: 34))

//update
manSet.update(with: Man(name: "Frank", age: 45))
manSet.update(with: Man(name: "Fisher", age: 50))
print(manSet)
print(manSet.count)

//remove
manSet.remove(Man(name: "Frank", age: 45))

//子集和超集
let ASet: Set = [1, 2, 3]
let BSet: Set = [1, 2, 3, 4, 5]
print(ASet.isSubset(of: BSet))
print(BSet.isSuperset(of: ASet))
print(ASet.isStrictSubset(of: BSet))
print(BSet.isStrictSuperset(of: ASet))

```

###字典
```
```

##错误处理
```
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
```

##函数和闭包
###函数定义

```
//不带返回值的函数
func greetToGuys(person: String) {
    print("Hello, \(person)!")
}

greetToGuys(person: "Nigelli")

//带返回值的函数
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}

func greetAgain(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

print(greet(person: "Nigel", alreadyGreeted: false))

//tuple做函数返回值
func minMax(array: [Int]) -> (min: Int, max: Int)? {
    var curMin = array[0]
    var curMax = array[0]
    for value in array[1..<array.count] {
        if value < curMin {
            curMin = value
        } else if value > curMax {
            curMax = value
        }
    }
    return (curMin, curMax)
}

if let bounds = minMax(array: [7, 10, -1, 0, 4, 6, -3, 3, 9]) {
    print("min is \(bounds.min), max is \(bounds.max)")
}

//隐式返回的函数
func sayHello(for person: String) -> String {
    "Hello, " + person + "!"
}

print(sayHello(for: "RVO"))

//定义函数的时候指定参数标签
func shortIntro(person: String, from hometown: String) -> String {
    return "This is \(person), he/she comes from \(hometown)."
}

print(shortIntro(person: "Nigel", from: "China"))

//省略参数标签符号_
func fullName(_ firstName: String, _ secondName: String) -> String {
    return "\(firstName) \(secondName)"
}

print(fullName("Nigel", "Li"))

//定义默认形参
func showNum(_ defaultParams: Int = 3) -> String {
    return "number is: \(defaultParams)"
}

print(showNum(9))
print(showNum())

//可变形参
func getMeanValue(_ numbers: Double...) -> Double {
    var total: Double = 0
    for num in numbers {
        total += num
    }
    
    return total / Double(numbers.count)
}

getMeanValue(1, 2, 4, 6, 7, 8, 3)
getMeanValue(-1, 6, 0, 2, -4, 6, 7, -8, 10, -13, -9)


//inout类型的形参用于改变形参的值 传参使用&
func swapRefs(_ a: inout Int, _ b: inout Int) {
    let tmp: Int = a
    a = b
    b = tmp
}

var firstVal = -1
var secondVal = 7
print("before swapping, firstVal = \(firstVal), secondVal = \(secondVal)")
swapRefs(&firstVal, &secondVal)
print("after swapping, firstVal = \(firstVal), secondVal = \(secondVal)")
```

###函数类型
```
//使用函数类型 = 函数指针
func addTwoNum(num1: Int, num2: Int) -> Int {
    return Int(num1 + num2)
}

var sumVar: (Int, Int) -> Int = addTwoNum
print(sumVar(1, 1))

//函数作形参
func getMathSum(sumVal: (Int, Int) -> Int, a: Int, b: Int) {
    print("result is : \(sumVal(a, b))")
}

getMathSum(sumVal: sumVar, a: 3, b: 7)

//函数作返回类型
func stepForward(_ input: Int) -> Int {
    return input + 1
}

func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func moveForward(forwards: Bool) -> (Int) -> Int {
    return forwards ? stepBackward(_:) : stepForward(_:)
}

var curVal = 3
let getNextValFunc: (Int) -> Int = moveForward(forwards: curVal > 0)//函数定义

while curVal != 0 {
    print("curVal = \(curVal)")
    curVal = getNextValFunc(curVal)
}

print("curVal = \(curVal)")
```

###闭包的使用
```
//闭包表达式
let names2 = ["zhangsan", "lisi", "wangwu", "zhaoliu"]
var reverseNames2 = names2.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
print(reverseNames2)

//从语境中推断类型 不显示声明String类型
let names3 = ["zhangsan", "lisi", "wangwu", "zhaoliu"]
var reverseNames3 = names3.sorted(by: { s1, s2 in return s1 > s2})
print(reverseNames3)

//从语境中推断类型 隐式返回
let names4 = ["zhangsan", "lisi", "wangwu", "zhaoliu"]
var reverseNames4 = names4.sorted(by: { s1, s2 in s1 > s2})
print(reverseNames4)

//从语境中推断类型 使用$0\$1\$2
let names5 = ["zhangsan", "lisi", "wangwu", "zhaoliu"]
var reverseNames5 = names5.sorted(by: { $0 > $1})
print(reverseNames5)

//闭包捕获值 ——超过变量的作用域还能读写这个变量
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var total = 0//捕获total变量
    func incrementer() -> Int {
        total += amount
        return total
    }
    
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10) //定义了一个闭包，total = 0
incrementByTen()
incrementByTen()
incrementByTen()

let incrementByNine = makeIncrementer(forIncrement: 9) //定义了新的闭包，total = 0
incrementByNine()
incrementByNine()

let incrementByTen2 = incrementByTen //闭包是引用类型，total与incrementByTen是同一份内存空间 total = 30
incrementByTen2()
```
###逃逸闭包和自动闭包
```
//逃逸闭包 ——当一个闭包作为函数参数 & 闭包要在函数执行完之后再执行 称这个闭包逃逸了
//逃逸闭包使用场景1：闭包里面的变量需要在函数外面被存储起来
//逃逸闭包使用场景2：网络请求的回调函数 需要在网络请求完成之后拿到成功或失败的返回值
var completionHandlers: [() -> Void] = []
func funcWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func funcWithNoneEscapingClosure(closure: () -> Void) {
    closure()
}

class AClass {
    var x = 10
    func doSomethind() {
        funcWithEscapingClosure { self.x = 100 } //逃逸闭包需要显式的使用self
        funcWithNoneEscapingClosure { x = 200 }
    }
}

let ins = AClass()
ins.doSomethind()
print(ins.x)

completionHandlers.first?()
print(ins.x)

//自动闭包 ——自动闭包可以将表达式转换成闭包 而不用显式写一个闭包{}
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniel"]
print(customersInLine.count)

//let customerProvider = { customersInLine.remove(at: 0) }
//print(customersInLine.count)
//
//customerProvider()
print(customersInLine.count)

func serve(customer customerProvider: () -> String) {
    customerProvider()
}

serve(customer: { customersInLine.remove(at: 0) })
print(customersInLine.count)
```

##面向对象
###枚举
```
//枚举 值类型
enum CompassPoint: CaseIterable {
    case north
    case south
    case east
    case west
}

let dirToHead = CompassPoint.south
switch dirToHead {
case .north:
    print("it's north")
case .south:
    print("it's south")
case .east:
    print("it's east")
case .west:
    print("it's west")
}

//遍历枚举的case
let numOfDir = CompassPoint.allCases.count //需要在枚举类型加入: CaseIterable表示枚举允许被遍历
print("numOfDir = \(numOfDir)")

for dir in CompassPoint.allCases {
    print(dir)
}

//枚举定义关联值
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var barCode = Barcode.upc(7, 17, 23, 31)
print(barCode)
barCode = .qrCode("YUIOPJKL")
print(barCode)

switch barCode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

//原始值
enum ASCIIChar: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carrigeReturn = "\r"
}

//预设原始值
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, staturn, uranus, neptune
}
```

###类
```
//类的初始化
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
    
}

var f = Fahrenheit()
print("the default temperature is \(f.temperature)")

class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingListItem()

//自定义初始化
struct Celsius {
    var temperature: Double
    init(fahrenheit: Double) {
        temperature = (fahrenheit - 32.0) / 1.8
    }
    
    init(kelvin: Double) {
        temperature = kelvin - 273.15
    }
}

let boilingPoint = Celsius(fahrenheit: 212.0)
let freezingPoint = Celsius(kelvin: 273.15)

//常量属性
class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

let beets = SurveyQuestion(text: "How about beets?")
beets.ask()
beets.response = "u like beets."

struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 12.0)

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

//定义基类
class Vehicle {
    var curSpeed = 0.0
    var description: String {
        return "traveling at \(curSpeed) miles per hour"
    }
    
    func makeNoise() {
        //TODO
    }
}

//子类
class Bicyle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicyle()
bicycle.hasBasket = true
bicycle.curSpeed = 15.0
print("Bicycle: \(bicycle.description)")

//重写 override
class Train: Vehicle {
    override func makeNoise() {
        print("yo 123")
    }
}

let train = Train()
train.makeNoise()

//重写 getter/setter
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + "in gear \(gear)"
    }
}

let car = Car()
car.curSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
```

###扩展
```
//扩展
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

extension Rect {
    init(center: Point, left: Point, size: Size) {
        let originX = center.x > left.x ? center.x : left.x - (size.width / 2)
        let originY = center.y > left.y ? center.y : left.y - (size.height / 2)
        self.init(origin: Point(x: originX, y:originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), left: Point(x: 0.0, y: 0.0), size: Size(width: 3.0, height: 3.0))

//添加新方法
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

7.repetitions {
    print("New func")
}

//mutating 改变实例变量本身
extension Int {
    mutating func squrare() {
        self = self * self
    }
}

var a: Int = 9
a.squrare()
print(a)
```

###协议
```
//协议定义和使用
protocol AProtocol {
    //TODO
}

protocol BProtocol {
    //TODO
}

struct AStruct: AProtocol, BProtocol {
    //TODO
}

class BClass: AClass, AProtocol, BProtocol {
    //TODO
}

//协议的实现
protocol FullNamed {
    var fullName: String { get }//只读属性
    var age: Int { get set }//读写属性
}

struct Person: FullNamed {
    var fullName: String
    var age: Int
}

var sam = Person(fullName: "Sam Smith", age: 10)
sam.fullName = "new name"
print(sam.fullName)
sam.age
sam.age = 33
print(sam.age)
```

