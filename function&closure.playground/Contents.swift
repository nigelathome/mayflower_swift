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
