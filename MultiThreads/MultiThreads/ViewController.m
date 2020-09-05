//
//  ViewController.m
//  MultiThreads
//
//  Created by itang on 2020/8/26.
//  Copyright © 2020 learn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSOperationQueue *mainQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 主线程死锁crash
//    [self deadLock];
    
    // invocation 在主线中执行
//    [self executeInMainThread];
    // invocation 在子线程中执行
//    [self executeInNewThread];
    
//    [self addMainOperationQueue];
    
    [self addCustomeOperationQueue];
    
}

- (void)deadLock {
    
    NSLog(@"开始启动");// 1
    
    dispatch_sync(dispatch_get_main_queue(), ^{ //2
        NSLog(@"同步任务"); // 3
    });

    NSLog(@"启动结束"); //4
}

/**
 在主线程中执行
 */
- (void)executeInMainThread
{
    NSLog(@"创建操作:%@",[NSThread currentThread]);
    //1：创建操作。
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task) object:nil];
    //2：开始执行操作。
    [op start];
}

/**
 在子线程中执行
 */
- (void)executeInNewThread
{
    NSLog(@"创建操作:%@",[NSThread currentThread]);
    [NSThread detachNewThreadSelector:@selector(executeInMainThread) toTarget:self withObject:nil];
}

- (void)task
{
    NSLog(@"执行操作:%@",[NSThread currentThread]);
    for (NSInteger i = 0; i < 3; i++) {
        NSLog(@"----%@",[NSThread currentThread]);
    }
}

- (void)addMainOperationQueue
{
//获得主操作队列
   NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
   self.mainQueue = mainQueue;
   NSLog(@"创建添加任务%@",[NSThread currentThread]);
   NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"1"];
   [mainQueue addOperation:op1];
   [mainQueue cancelAllOperations];
   NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"2"];
   [mainQueue addOperation:op2];
   
   NSInvocationOperation *op3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"3"];
   [mainQueue addOperation:op3];
   
   [op3 cancel];//取消某个操作，可以直接调用操作的取消方法cancel。
   //取消整个操作队列的所有操作，这个方法好像没有效果？？？。在主队列中，没有用，如果将操作加入到自定义队列的话，在操作没有开始执行的时候，是能够取消操作的。
//    [mainQueue cancelAllOperations];
   
   NSInvocationOperation *op4 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"4"];
   [mainQueue addOperation:op4];
}
- (void)task:(NSString *)order
{
   for (NSInteger i = 0; i < 3; i++) {
       NSLog(@"任务:%@----%@",order,[NSThread currentThread]);
   }
}

- (void)addCustomeOperationQueue
{
    NSLog(@"创建添加任务%@",[NSThread currentThread]);
    NSOperationQueue *customQueue = [[NSOperationQueue alloc]init];
     customQueue.maxConcurrentOperationCount = 5;//这个属性的设置需在队列中添加任务之前。任务添加到队列后，如果该任务没有依赖关系的话，任务添加到队列后，会直接开始执行。
    //加入到自定义队列里的任务，可以通过设置操作队列的 maxConcurrentOperationCount的值来控制操作的串行执行还是并发执行。
    
    //当maxConcurrentOperationCount = 1的时候，是串行执行。 maxConcurrentOperationCount > 1的时候是并发执行，但是这个线程开启的数量最终还是由系统决定的，不是maxConcurrentOperationCount设置为多少，就开多少条线程。默认情况下，自定义队列的maxConcurrentOperationCount值为-1，表示并发执行。
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"1"];
     [customQueue addOperation:op1];
  
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"2"];

    NSInvocationOperation *op3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"3"];
    
    NSInvocationOperation *op4 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"4"];
    
    //打断点在op1加入队列前后的状态值。
    ///<NSInvocationOperation 0x608000246cf0 isFinished=NO isReady=YES isCancelled=NO isExecuting=NO>
   
    ///<NSInvocationOperation 0x608000246cf0 isFinished=NO isReady=YES isCancelled=NO isExecuting=YES>
  
    [customQueue addOperation:op2];
//    [customQueue cancelAllOperations];//这个方法只能取消还未开始执行的操作，如果操作已经开始执行，那么该方法依然取消不了。
    [customQueue addOperation:op3];
    [customQueue addOperation:op4];
}

/*
 Calls to this function always return immediately after the block has been submitted and never wait for the block to be invoked. When the barrier block reaches the front of a private concurrent queue, it is not executed immediately. Instead, the queue waits until its currently executing blocks finish executing. At that point, the barrier block executes by itself. Any blocks submitted after the barrier block are not executed until the barrier block completes.

 The queue you specify should be a concurrent queue that you create yourself using the dispatch_queue_create function. If the queue you pass to this function is a serial queue or one of the global concurrent queues, this function behaves like the dispatch_async function.
 */


@end
