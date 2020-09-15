//
//  Person.m
//  KVO
//
//  Created by itang on 2020/9/10.
//  Copyright © 2020 learn. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)addres {
    return @"1";
}

- (void)setAddres:(NSString *)addres {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end
