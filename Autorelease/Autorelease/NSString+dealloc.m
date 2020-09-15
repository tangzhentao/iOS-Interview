//
//  NSString+dealloc.m
//  Autorelease
//
//  Created by itang on 2020/9/14.
//  Copyright © 2020 learn. All rights reserved.
//

#import "NSString+dealloc.h"
#import <objc/runtime.h>

@implementation NSString (dealloc)

- (NSNumber *)on {
    id on = objc_getAssociatedObject(self, "on");
    return (NSNumber *)on;
}

- (void)setOn:(NSNumber *)on {
    objc_setAssociatedObject(self, "on", on, OBJC_ASSOCIATION_RETAIN);
}

- (void)dealloc {
    NSLog(@"%p: %@", self, self.on);
}

@end
