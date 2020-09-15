//
//  ViewController.m
//  Runtime
//
//  Created by itang on 2020/9/14.
//  Copyright © 2020 learn. All rights reserved.
//

#import "ViewController.h"
#import "Person+Test.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self printAllMethods];
}

- (void)printAllMethods {
    unsigned count = 0;
    Method * list = class_copyMethodList([Person class], &count);
    for (int i = 0; i < count; i++) {
        Method method = list[i];
        SEL selector = method_getName(method);
        NSLog(@"mentod name: %@", NSStringFromSelector(selector));
    }
}


@end
