//
//  MyOperation.h
//  MultiThreads
//
//  Created by itang on 2020/9/5.
//  Copyright © 2020 learn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyOperation : NSOperation

@property (strong, nonatomic) NSString *text;

@end

NS_ASSUME_NONNULL_END
