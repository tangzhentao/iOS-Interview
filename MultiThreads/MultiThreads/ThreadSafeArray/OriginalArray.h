//
//  OriginalArray.h
//  MultiThreads
//
//  Created by itang on 2020/9/6.
//  Copyright © 2020 learn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OriginalArray : NSObject

- (void)addItem:(id)item;

- (void)removeItem:(id)item;

- (id)getLastItem;

- (void)print;

@end

NS_ASSUME_NONNULL_END
