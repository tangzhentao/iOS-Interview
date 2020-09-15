//
//  Person.m
//  Autorelease
//
//  Created by itang on 2020/9/14.
//  Copyright © 2020 learn. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (instancetype)personWithName:(NSString *)name {
    Person *p = Person.new;
    p.name = name;
    return p;
}

- (void)dealloc {
    NSLog(@"[%@ %@]: %@", [self class], NSStringFromSelector(_cmd), _name);
}

@end
