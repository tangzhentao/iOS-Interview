#  Block
- 什么事block？
block是将函数及其上下文封装起来的对象；

#### block的三种类型
- 全局block: __NSGlobalBlock__
没有捕获外部变量的block是全局block
- 栈block __NSStackBlock__
捕获外部变量的block是栈block
捕获变量指的是：block内部访问了一个局部变量。
- 堆block __NSMallocBlock__
被copy的栈block是堆block；
被copy的全局block还是全局block；

##### 栈block
- 对栈block进行copy或者把栈block赋值给一个变量，都会得到一个堆block。
- 堆栈block多次copy会得到多个不同的副本，对堆block进行copy得到的还是原来的block，只是引用计数会加1；

#### 问题
###### 栈block是啥意思，是指block所占用的内存在栈上吗？可是 block本质是一个对象，对象的内存都在堆上啊。
栈block的意思就是指它存储在栈空间。block本质上确实是一个对象，但在为block分配地址的时候，系统做了
特别处理，使它存储在了栈上，当复制一个栈block时，它会被搬到堆空间。
###### block的属性修饰符是使用copy还是strong
应该使用copy。
因为虽然使用copy和strong，其实都是对block进行copy操作。但是为了让操作和声明一致，建议使用copy；

