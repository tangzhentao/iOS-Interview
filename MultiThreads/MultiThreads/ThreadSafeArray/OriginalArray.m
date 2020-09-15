//
//  OriginalArray.m
//  MultiThreads
//
//  Created by itang on 2020/9/6.
//  Copyright © 2020 learn. All rights reserved.
//

#import "OriginalArray.h"

@interface OriginalArray ()

@property (strong, nonatomic) NSMutableArray *array;

@end


@implementation OriginalArray

- (instancetype)init {
    self = [super init];
    if (self) {
        _array = [NSMutableArray array];
    }
    return self;
}

- (void)addItem:(id)item {
    [self.array addObject:item];
}

- (void)removeItem:(id)item {
    [self.array removeObject:item];
}

- (id)getLastItem {
    
    NSUInteger count = self.array.count;
    if (count <= 0) {
        return nil;
    }
    [NSThread sleepForTimeInterval:0.1f];
    id item = self.array[count - 1];
    
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
