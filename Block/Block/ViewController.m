//
//  ViewController.m
//  Block
//
//  Created by itang on 2020/8/16.
//  Copyright © 2020 learn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

static int i = 10;
int j = 6;
void (^GlobalBlock)(void) = ^{
    NSLog(@"globalBlock, %i", i);
};

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 演示全局block
//    [self demoGlobalBlock];
    
    
    /*
     演示栈block
     
     因为函数的形参传值给实参时是值传递，在这里仅仅是传递指针的值，
     所有传递到函数中的block本身并没有被copy
     */
    int y = 1;
    [self demoStackBlock:^(int x) {
        NSLog(@"x + y = %d", x + y);
    }];
}

// 演示全局block: __NSGlobalBlock__
- (void)demoGlobalBlock {
    void (^hello)(void) = ^{
        NSLog(@"hello, %d", i);
    };
    
    NSLog(@"block 类型: %@", [hello class]);
    
    void (^helloCopy)(void) = [hello copy];
    NSLog(@"全局block的副本的类型: %@", [helloCopy class]);
}

// 演示栈block
/*
 1、栈block的内存位于栈空间
 */
- (void)demoStackBlock:(void(^)(int))stackBlock {
    
    /* 1. 打印block及其副本的类型 */
    NSLog(@"栈block类型: %@", [stackBlock class]);
    void (^stackBlockCopy1)(int) = stackBlock;
    NSLog(@"stackBlockCopy1类型: %@", [stackBlockCopy1 class]);

    /* 2. 查看stackBlock的内存地址，看它是不是真的位于栈空间 */

    // x肯定是位于栈中的，通过比较x的地址好block的地址
    // 可知block也是位于栈中
    int x = 2;
    NSLog(@"x的地址: %p", &x); // 0x7ffeec67553c
    NSLog(@"stackBlock: %p", stackBlock); // 0x7ffeec675578
    NSLog(@"stackBlockCopy1: %p", stackBlockCopy1); // 0x600002769f80

    /* 3. 看一个栈block被复制多次，得到的内存地址是否一样
        看复制堆block多次，得到的内存地址是否一样
     */
    void (^stackBlockCopy2)(int) = stackBlock;
    NSLog(@"stackBlockCopy2: %p", stackBlockCopy2); // 0x600002738f00
    
    void (^mallocBlock1)(int) = [stackBlockCopy1 copy];
    void (^mallocBlock2)(int) = [stackBlockCopy1 copy];
    NSLog(@"mallocBlock1: %p", mallocBlock1); // 0x600002769f80
    NSLog(@"mallocBlock2: %p", mallocBlock2); // 0x600002769f80

}

@end
