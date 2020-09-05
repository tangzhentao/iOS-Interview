//
//  CustomJSObject.m
//  H5
//
//  Created by itang on 2020/9/2.
//  Copyright © 2020 learn. All rights reserved.
//

#import "CustomJSObject.h"

@implementation CustomJSObject

#pragma mark - h5 协议方法
- (void)helloWQL {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

- (void)sendValueFromHtmlToOCWithValue:(NSString *)value {
    NSLog(@"[%@ %@]: %@", [self class], NSStringFromSelector(_cmd), value);
}

- (void)sendValueFromH5ToOC:(NSString *)value;
{
    NSLog(@"[%@ %@]: %@", [self class], NSStringFromSelector(_cmd), value);
}

- (void)sendValueFromHtmlToOCWithValue:(NSString*)value WithValueTwo:(NSString*)valueTwo {
    NSLog(@"[%@ %@]: %@, %@", [self class], NSStringFromSelector(_cmd), value, valueTwo);
}

- (void)sendValueToHtml {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    NSString *name = @"jobs";
    NSString *age = @"18";
    
    // 参数一定要加单引号，否则调用不成功
    NSString *jsCode = [NSString stringWithFormat:@"getUserNameAndAge('%@','%@')", name, age];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.context evaluateScript:jsCode];
    });
}


@end
