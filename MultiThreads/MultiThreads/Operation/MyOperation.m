//
//  MyOperation.m
//  MultiThreads
//
//  Created by itang on 2020/9/5.
//  Copyright © 2020 learn. All rights reserved.
//

#import "MyOperation.h"

@implementation MyOperation

- (void)main {
    NSLog(@"MyOperation main -- 开始");
    
    NSLog(@"MyOperation main：%@", self.text);
    
    [NSThread sleepForTimeInterval:1];
    
    NSLog(@"MyOperation main -- 结束");
}

@end
