//
//  ViewController.m
//  Lock
//
//  Created by itang on 2020/8/18.
//  Copyright © 2020 learn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)buttonTapped:(id)sender {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self semaphore];
}

// 使用信号量，让多个异步任务按顺序执行
- (void)semaphore {
    
    /*
     1、按顺序执行
     2、不卡主线程
     */
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 1; i  < 6; i++) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                int time = arc4random() % 5;
                NSLog(@"任务%d，耗时%ds --- 开始", i, time);
                sleep(time);
                NSLog(@"任务%d，耗时%ds --- 结束", i, time);
                dispatch_semaphore_signal(semaphore);
            });
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }
    });
    
    
}


@end
