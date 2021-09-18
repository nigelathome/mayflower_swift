//函数模板
/*
 func 函数名(参数签名1 参数1: 参数类型1, 参数签名2 参数2: 参数类型2,...) -> 返回类型 {
    语句
 }
 */

//函数类型
func addNumber(_ a: Int, _ b: Int) -> Int {
    return a + b
}

var addFunc: (Int, Int) -> Int = addNumber
let result = addFunc(3, 5)

//函数类型作形参
func printAddResult(_ addNumber: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print(addNumber(a, b))
}

printAddResult(addFunc, 2, 11)

//引用传递 使用inout
var number = 30
var anotherNumber = 0

func swapValue(_ a: inout Int, _ b: inout Int) {
    let tmp = a
    a = b
    b = tmp
}

let swapFunc: (inout Int, inout Int) -> () = swapValue
swapFunc(&number, &anotherNumber)
print(number)
print(anotherNumber)

//函数嵌套定义
func updateStepValue(backward: Bool) -> (Int) -> Int {
    func stepForward(step: Int) -> Int { return step + 1}
    func stepBackward(step: Int) -> Int { return step - 1}
    return backward ? stepBackward : stepForward
}

var curStep = -4
let stepFunc = updateStepValue(backward: curStep > 0)
while curStep != 0 {
    curStep = stepFunc(curStep)
}

//闭包模板
/*
 { (参数) -> (返回类型) in
    语句
 }
 */

//闭包sorted(by:)字符串数组逆序
//传入函数类型、定义闭包、省略闭包类型和返回值、使用形参$0/$1省略in、运算符函数>
let names = ["zhangsan", "zhaoliu", "lisi", "wangwu"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var revNames = names.sorted(by: backward)
print(revNames)

var revNames2 = names.sorted { (s1: String, s2: String) -> Bool in
    return s1 > s2
}
print(revNames2)

var revName3 = names.sorted(by: { s1, s2 in s1 > s2 } )
print(revName3)

var revName4 = names.sorted(by: { $0 > $1 } )
print(revName4)

var revName5 = names.sorted(by: >)
print(revName5)

