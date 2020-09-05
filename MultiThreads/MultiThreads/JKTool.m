//
//  JKTool.m
//  MultiThreads
//
//  Created by itang on 2020/9/5.
//  Copyright © 2020 learn. All rights reserved.
//

#import "JKTool.h"

uint32_t jk_randomTo(uint32_t max) {
    return jk_random(0, max);
}

uint32_t jk_1randomTo(uint32_t max) {
    return jk_random(1, max);
}

uint32_t jk_random(uint32_t from, uint32_t to) {
    uint32_t r = arc4random();
    uint32_t random = from + r % (to - from);
    
    return random;
}

@implementation JKTool

+ (NSUInteger)randomTo:(NSUInteger)maxNum {
//    srandom(time(0));
//    NSUInteger i = random() % 5;
    
    NSUInteger random = arc4random() % maxNum;
    return random;
}

@end
