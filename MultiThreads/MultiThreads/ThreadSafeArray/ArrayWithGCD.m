//
//  ArrayWithGCD.m
//  MultiThreads
//
//  Created by itang on 2020/9/6.
//  Copyright © 2020 learn. All rights reserved.
//

#import "ArrayWithGCD.h"

@interface ArrayWithGCD ()

@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) dispatch_queue_t readWriteQueue;

@end

@implementation ArrayWithGCD

- (instancetype)init {
    self = [super init];
    if (self) {
        _array = [NSMutableArray array];
        _readWriteQueue = dispatch_queue_create("read write queue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)addItem:(id)item {
    
    dispatch_barrier_async(_readWriteQueue, ^{
        NSLog(@"addItem: %@", NSThread.currentThread);
        [self.array addObject:item];
    });
}

- (void)removeItem:(id)item {
    dispatch_barrier_async(_readWriteQueue, ^{
        NSLog(@"removeItem: %@", NSThread.currentThread);
        [self.array removeObject:item];
    });
}

- (id)getLastItem {
    
    __block id item = nil;
    dispatch_sync(_readWriteQueue, ^{
        NSLog(@"getLastItem: %@", NSThread.currentThread);
        NSUInteger count = self.array.count;
        if (count > 0) {
            [NSThread sleepForTimeInterval:0.1f];
            item = self.array[count - 1];
        }
        
    });
        
    return item;
}

- (void)print {
    
    dispatch_async(_readWriteQueue, ^{
        for (id item in self.array) {
            NSLog(@"%@", item);
        }
    });
    
}

- (void)dealloc {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end
