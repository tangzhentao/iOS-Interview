//
//  ThreadSafeArrayVC.m
//  MultiThreads
//
//  Created by itang on 2020/9/6.
//  Copyright © 2020 learn. All rights reserved.
//

#import "ThreadSafeArrayVC.h"
#import "OriginalArray.h"
#import "ArrayWithLock.h"
#import "ArrayWithGCD.h"

@implementation ThreadSafeArrayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self createUI];
}

- (void)createUI {

    [self addBtnWithTitle:@"线程不安全的数组" action:@selector(notThreadSafeArray) frame:CGRectMake(100, 200, 200, 40)];
    [self addBtnWithTitle:@"使用锁的数组" action:@selector(arrayUsingLock) frame:CGRectMake(100, 300, 200, 40)];
    [self addBtnWithTitle:@"使用GCD的数组" action:@selector(arrayUsingGCD) frame:CGRectMake(100, 400, 200, 40)];
}

- (void)addBtnWithTitle:(NSString *)title action:(SEL)action frame:(CGRect)frame {
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.frame = frame;
    btn.backgroundColor = UIColor.lightGrayColor;
    [btn addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}

- (void)notThreadSafeArray {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    OriginalArray *array = [OriginalArray new];
    for (int j = 0; j < 50; j++) {
        [array addItem:@(j)];
    }
    
    [array print];
    
    dispatch_queue_t myQeue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 50; i++) {
        dispatch_async(myQeue, ^{
            // 获取最后一个元素
            NSNumber *lastItem = [array getLastItem];
            //
            NSLog(@"第 %02d 操作, 获取最后一个元素[%@]，并删除。%@", i, lastItem, NSThread.currentThread);

            // 删除最后一个元素
            if (lastItem) {
                [array removeItem:lastItem];
            }
        });
    }
    
    
}
- (void)arrayUsingLock {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    ArrayWithLock *array = [ArrayWithLock new];
    for (int j = 0; j < 50; j++) {
        [array addItem:@(j)];
    }
    [array print];

    
    dispatch_queue_t myQeue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 50; i++) {
        dispatch_async(myQeue, ^{
            // 获取最后一个元素
            NSNumber *lastItem = [array getLastItem];
            //
            NSLog(@"第 %02d 操作, 获取最后一个元素[%@]，并删除。%@", i, lastItem, NSThread.currentThread);

            // 删除最后一个元素
            if (lastItem) {
                [array removeItem:lastItem];
            }
        });
    }
    
}
- (void)arrayUsingGCD {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    ArrayWithGCD *array = [ArrayWithGCD new];
    for (int j = 0; j < 50; j++) {
        [array addItem:@(j)];
    }
    [array print];

    
    dispatch_queue_t myQeue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 50; i++) {
        dispatch_async(myQeue, ^{
            // 获取最后一个元素
            NSNumber *lastItem = [array getLastItem];
            //
            NSLog(@"第 %02d 操作, 获取最后一个元素[%@]，并删除。%@", i, lastItem, NSThread.currentThread);

            // 删除最后一个元素
            if (lastItem) {
                [array removeItem:lastItem];
            }
        });
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
