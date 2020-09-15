//
//  ViewController.m
//  Autorelease
//
//  Created by itang on 2020/9/14.
//  Copyright © 2020 learn. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSString+dealloc.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    NSLog(@"[%@ %@] ---- begin", [self class], NSStringFromSelector(_cmd));

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;

//    [self testRelease2];
    NSLog(@"[%@ %@] ---- end", [self class], NSStringFromSelector(_cmd));
}

/*
 没有找到生成autorelease对象的方法，除了使用__autorelease修饰变量
 */

- (void)testRelease1 {
    NSLog(@"[%@ %@] ---- begin", [self class], NSStringFromSelector(_cmd));
    for (int i = 0; i < 10; i++) {
        NSLog(@"    for %d --- begin", i);
        Person *p = [Person new];
        p.name = @(i).stringValue;
        NSLog(@"    for %d --- end", i);
    } // p出了作用域就会释放
    NSLog(@"[%@ %@] ---- end", [self class], NSStringFromSelector(_cmd));
}

- (void)testRelease2 {
    NSLog(@"[%@ %@] ---- begin", [self class], NSStringFromSelector(_cmd));
    for (int i = 0; i < 10; i++) {
        NSLog(@"    for %d --- begin", i);

            Person *p = [Person personWithName:@(i).stringValue];
            p.name = @(i).stringValue;
        
        NSLog(@"    for %d --- end", i);
    } // p出了作用域就会释放
    NSLog(@"[%@ %@] ---- end", [self class], NSStringFromSelector(_cmd));
}
@end
