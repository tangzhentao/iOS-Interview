//
//  JKTool.h
//  MultiThreads
//
//  Created by itang on 2020/9/5.
//  Copyright © 2020 learn. All rights reserved.
//

#import <Foundation/Foundation.h>

// 在0和max之间随机一个数，包括0，不包括max
uint32_t jk_randomTo(uint32_t max);
// 在range内随机一个数，包括最小值，不包括最大值
uint32_t jk_random(uint32_t from, uint32_t to);
// 在1和max之间随机一个数，包括1，不包括max
uint32_t jk_1randomTo(uint32_t max);

NS_ASSUME_NONNULL_BEGIN

@interface JKTool : NSObject

// 在0和maxNum之间随机一个整数
+ (NSUInteger)randomTo:(NSUInteger)maxNum;

@end

NS_ASSUME_NONNULL_END
