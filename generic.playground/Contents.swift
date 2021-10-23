//泛型模板
/*
 T 代表类型
 func swapTwoNum(_ a: inout T, _b: inout T) { ... }
 }
 */

struct Stack<T> {
    var items = [T]()
    mutating func push(_ item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}

var nameStack = Stack<String>()
nameStack.push("Bastein")
nameStack.push("Julia")
nameStack.push("Eugene")
nameStack.push("William")
