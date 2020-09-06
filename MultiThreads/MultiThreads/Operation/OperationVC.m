//
//  OperationVC.m
//  MultiThreads
//
//  Created by itang on 2020/9/5.
//  Copyright © 2020 learn. All rights reserved.
//

#import "OperationVC.h"
#import "MyOperation.h"

@interface OperationVC ()

@end

@implementation OperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;

}

#pragma mark - 演示单独使用NSInvocationOperation
- (void)demoOperation1 {
    NSInvocationOperation *ip = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doTask1:) object:@"hello queue"];
    
    [ip start];
}

- (void)doTask1:(NSString *)text {
    NSLog(@"任务一 -- 开始: %@", NSThread.currentThread);
    NSLog(@"任务一：%@", text);
    NSLog(@"任务一 -- 结束");
}

#pragma mark - 演示单独使用NSBlockOperation
- (void)demoBlockOperation {
    
    // 该block在主线程中执行
    NSBlockOperation *bp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"主block1 -- 开始: %@", NSThread.currentThread);
        [NSThread sleepForTimeInterval:1];
        NSLog(@"主block1 -- 结束");

    }];
    
    // 该block在子线程中执行
    [bp addExecutionBlock:^{
        NSLog(@"额外的block1 -- 开始: %@", NSThread.currentThread);
        [NSThread sleepForTimeInterval:1];
        NSLog(@"额外的block1 -- 结束");
    }];
    
    [bp start];
}

#pragma mark - 演示单独使用自定义的Operation
- (void)demoMyOperation {
    MyOperation *mo = [MyOperation new];
    mo.text = @"hello myoperation";
    [mo start];
}

#pragma mark - 把操作放入队列
- (void)demoAddOperationToQueue {
    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
    
    // 最大并发数默认是 -1
    NSLog(@"自定义默认最大并发数: %ld", myQueue.maxConcurrentOperationCount); // -1 NSOperationQueueDefaultMaxConcurrentOperationCount 具体根据当前系统确定
    
    // 最大并发数设置为1后，队列就变成了串行队列，任务使用不同的线程在队列中同步顺序执行
    myQueue.maxConcurrentOperationCount = 1;
    
    // invaocation 操作
    NSInvocationOperation *io = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doTask1:) object:@"hello my queue"];
    [io cancel];
    // block操作
    NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"my queue block operation -- 开始: %@", NSThread.currentThread);
        [NSThread sleepForTimeInterval:1];
        NSLog(@"my queue block operation -- 结束");
    }];
    
    [myQueue addOperation:io];
    [myQueue addOperation:bo];
    [myQueue addOperationWithBlock:^{
        NSLog(@"直接添加到队列的block 1 -- 开始: %@", NSThread.currentThread);
        [NSThread sleepForTimeInterval:1];
        NSLog(@"直接添加到队列的block 1 -- 结束");
    }];
    [myQueue addOperationWithBlock:^{
        NSLog(@"直接添加到队列的block 2 -- 开始: %@", NSThread.currentThread);
        [NSThread sleepForTimeInterval:1];
        NSLog(@"直接添加到队列的block 2 -- 结束");
    }];
}

#pragma mark - 操作依赖
- (void)demoDependencyOperation {
    NSBlockOperation *bo1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"前提操作 -- 开始: %@", NSThread.currentThread);
        [NSThread sleepForTimeInterval:1];
        NSLog(@"前提操作 -- 结束");
    }];
    
    NSBlockOperation *bo2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"有依赖的操作 -- 开始: %@", NSThread.currentThread);
        [NSThread sleepForTimeInterval:1];
        NSLog(@"有依赖的操作 -- 结束");
    }];
    
    // 添加依赖
    [bo2 addDependency:bo1];
    
    NSOperationQueue *myQueue = [NSOperationQueue new];
//    myQueue.maxConcurrentOperationCount = 1;
    [myQueue addOperation:bo2];
    [myQueue addOperation:bo1];
}

#pragma mark - 演示取消操作

/*
 - 取消 ready状态的操作 是无效的
 - 取消 未加入队列的操作，会直接标记该操作为 完成的
 - 取消 还未ready的在队列中的操作，会把该操作从队列中国删除
 */
- (void)demoCancelOperation {
    
//    [self demoOperationNormalStatus];
    // 演示在加入队列前，取消操作
//    [self demoCancelOperationBeforeAddingQueue];
    
    [self demoCancelOperationInQueue];
}

// 演示一个操作的正常流程的各个状态
- (void)demoOperationNormalStatus {
    NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"可能会取消的操作 -- 开始");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"可能会取消的操作 -- 结束");
    }];
    
    NSLog(@"开始前的是不是ready状态: %d", bo.ready);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [bo start];
    });
    
    [NSThread sleepForTimeInterval:1];
    NSLog(@"开始后是不是ready状态: %d", bo.isExecuting);
    [NSThread sleepForTimeInterval:2];
    NSLog(@"完成后是不是isFinished状态: %d", bo.isFinished);
}

- (void)printOperationStatus:(NSOperation *)operation name:(NSString *)name {
    NSLog(@"%@ 状态：ready[%d], cancel[%d], executing[%d], finished[%d]", name, operation.isReady, operation.isCancelled, operation.isExecuting, operation.isFinished);
}

/*
 
 */
- (void)demoCancelOperationBeforeAddingQueue {
    NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"可能会取消的操作 -- 开始");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"可能会取消的操作 -- 结束");
    }];
    NSLog(@"开始前的是不是ready状态: %d", bo.ready);
    
    /*
     对完成后的操作，执行cancel操作没有副作用
     [bo start];
     NSLog(@"完成后是不是isFinished状态: %d", bo.isFinished);
     */
    
    [bo cancel];
    
    NSLog(@"取消后是不是cancelled状态: %d", bo.cancelled);
    NSLog(@"完成后是不是isFinished状态: %d", bo.isFinished);
}

/*
 - 如果没有依赖任务的话，操作创建后就处于isRead状态
 - 操作标记为finished后，从队列中删除；
 - 取消未执行的操作：标记操作为cancelled，但并不把该操作从队列中删除。轮到执行该操作时，并不执行该操作而是直接标记为finished，然后从队列中移除
 - 取消正在执行的操作：标记操作为cancelled，但并不会真的取消该操作。当操作完成后标记为finished，然后从队列中移除；
 - 取消已完成的操作：不会标记操作为cancelled
 */

- (void)demoCancelOperationInQueue {
    
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.maxConcurrentOperationCount = 1;
    
    NSBlockOperation *b1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务 1 -- 开始");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"任务 1 -- 结束");
    }];
    NSBlockOperation *b2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务 2 -- 开始");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"任务 2 -- 结束");
    }];
    NSBlockOperation *b3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务 3 -- 开始");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"任务 3 -- 结束");
    }];
    
    b1.completionBlock = ^{
        NSLog(@"任务 1 完成了, 队列中任务数: %lu", (unsigned long)queue.operationCount);
        NSLog(@"任务 1 完成后打印操作的状态");
        [self printOperationStatus:b1 name:@"b1"];
        [self printOperationStatus:b2 name:@"b2"];
        [self printOperationStatus:b3 name:@"b3"];
        NSLog(@"");
        
        [b2 cancel];
        [b3 cancel];
        NSLog(@"取消了任务 2、3 后打印操作的状态, 队列中任务数: %lu", (unsigned long)queue.operationCount);

        [self printOperationStatus:b1 name:@"b1"];
        [self printOperationStatus:b2 name:@"b2"];
        [self printOperationStatus:b3 name:@"b3"];
        NSLog(@"");
    };
    b2.completionBlock = ^{
        NSLog(@"任务 2 完成了, 队列中任务数: %lu", (unsigned long)queue.operationCount);
    };
    b3.completionBlock = ^{
        NSLog(@"任务 3 完成了, 队列中任务数: %lu", (unsigned long)queue.operationCount);
    };
    
    NSLog(@"加入队列前打印操作的状态");
    [self printOperationStatus:b1 name:@"b1"];
    [self printOperationStatus:b2 name:@"b2"];
    [self printOperationStatus:b3 name:@"b3"];
    NSLog(@"");

    
    [queue addOperation:b1];
    [queue addOperation:b2];
    [queue addOperation:b3];
    
    [queue waitUntilAllOperationsAreFinished];

    NSLog(@"队列完成所有任务后打印操作的状态");
    [self printOperationStatus:b1 name:@"b1"];
    [self printOperationStatus:b2 name:@"b2"];
    [self printOperationStatus:b3 name:@"b3"];
    NSLog(@"");
    
    NSLog(@"队列完成所有任务后再取消任务 1，然后打印操作的状态");
    [b1 cancel]; // 不会被标记为cancelled
    [self printOperationStatus:b1 name:@"b1"];
    [self printOperationStatus:b2 name:@"b2"];
    [self printOperationStatus:b3 name:@"b3"];
    NSLog(@"");

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self demoOperation1];
//    [self demoBlockOperation];
//    [self demoMyOperation];
    
//    [self demoAddOperationToQueue];
    
//    [self demoDependencyOperation];
    
    [self demoCancelOperation];
    
}


@end
