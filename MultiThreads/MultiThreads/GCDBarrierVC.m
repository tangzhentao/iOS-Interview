//
//  GCDBarrierVC.m
//  MultiThreads
//
//  Created by itang on 2020/9/5.
//  Copyright © 2020 learn. All rights reserved.
//

#import "GCDBarrierVC.h"
#import "JKTool.h"

@interface GCDBarrierVC ()

@end

@implementation GCDBarrierVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)demo1 {
    dispatch_queue_t myQueue = dispatch_queue_create("my queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_suspend(myQueue); // 挂起队列中的任务，正在执行的任务不受影响，对之后加入的任务起作用。

    // 先往队列中添加几个任务
    NSLog(@"先往队列中添加几个任务");
    for (int i = 0; i < 4; i++) {
        dispatch_async(myQueue, ^{
            uint32_t s = jk_1randomTo(4);
            NSLog(@"任务 %d 开始, 睡%u秒", i, s);
            sleep(s);
            NSLog(@"任务 %d 结束", i);
        });
    }
    
    // 添加一个界限
    NSLog(@"添加一个界限");
    dispatch_barrier_async(myQueue, ^{
        NSLog(@"这是一个任务界线");
    });
    
    // 再往队列中添加几个任务
    NSLog(@"再往队列中添加几个任务");
    for (int i = 4; i < 7; i++) {
        dispatch_async(myQueue, ^{
            uint32_t s = jk_1randomTo(4);
            NSLog(@"任务 %d 开始, 睡%u秒", i, s);
            sleep(s);
            NSLog(@"任务 %d 结束", i);
        });
    }
    
    
    dispatch_resume(myQueue); // 恢复队列，继续执行其中的任务；
    
    /*
     dispatch_barrier_async，提交一个栅栏任务，立刻返回不阻塞当前线程
     dispatch_async 提交一个栅栏任务并等待任务完成，会阻塞当前线程
     */
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self demo1];
}

@end
