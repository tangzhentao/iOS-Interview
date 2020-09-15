//
//  ArrayWithLock.m
//  MultiThreads
//
//  Created by itang on 2020/9/6.
//  Copyright © 2020 learn. All rights reserved.
//

#import "ArrayWithLock.h"

@interface ArrayWithLock ()

@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) NSLock *lock;

@end


@implementation ArrayWithLock

- (instancetype)init {
    self = [super init];
    if (self) {
        _array = [NSMutableArray array];
        _lock = [NSLock new];
    }
    return self;
}

- (void)addItem:(id)item {
    [_lock lock];
    [self.array addObject:item];
    [_lock unlock];

}

- (void)removeItem:(id)item {
    [_lock lock];
    [self.array removeObject:item];
    [_lock unlock];
}

- (id)getLastItem {
    
    [_lock lock];
    NSUInteger count = self.array.count;
    if (count <= 0) {
        return nil;
    }
    [NSThread sleepForTimeInterval:0.1f];
    id item = self.array[count - 1];
    [_lock unlock];
    
    return item;
}

- (void)print {
    for (id item in self.array) {
        NSLog(@"%@", item);
    }
}


- (void)dealloc {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end
