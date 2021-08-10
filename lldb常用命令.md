###常用lldb命令
1.读寄存器的值

```
register read
register read x0
po 0x0000000102615468
```
寄存器x0-x7存储程序参数

2.对象打印

```
x obj //以16进制打印对象的内存 iOS小端模式 
memory read obj //作用同x

(lldb) x obj
0x100629400: a5 83 00 00 01 80 1d 01 18 40 00 00 01 00 00 00  .........@......
0x100629410: 38 40 00 00 01 00 00 00 00 00 00 00 00 80 66 40  8@............f@
(lldb) po 0x100629400
<LGTeacher: 0x100629400>

x/6gx //输出8个16进制的地址空间

(lldb) x/6gx obj
0x100627d30: 0x011d8001000083ad 0x0000000100004020
0x100627d40: 0x0000000100004040 0x00000000000000b4
0x100627d50: 0x0000000000000012 0x0000000000000000

Debug -> Debug Workflow -> View Memory //查看所有内存
```

3.类所占的空间大小

```
sizeof(NSInteger)
sizeof(p)
```

4.p/po  
p打印对象的全部信息，po调用对象的description方法，description方法可以通过重写定制输出格式

```
(lldb) po t
<LGTeacher: 0x10140b600>

(lldb) p t
(LGTeacher *) $3 = 0x000000010140b600
```

5.clang  
clang是Apple基于LLVM的编译器前端，可以用于c/cpp/objective-c的编译  

```
clang -rewrite-objc main.m -o main.cpp //将main.m 编译成main.cpp
```
 
 6.bt 打印调用堆栈 等同断点模式下的cmd+7
