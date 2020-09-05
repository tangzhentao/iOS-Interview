//
//  ViewController.m
//  Runloop
//
//  Created by itang on 2020/8/20.
//  Copyright © 2020 learn. All rights reserved.
//

#import "ViewController.h"

@interface Person : NSObject

@property (strong, nonatomic) NSString *name;

@end

@implementation Person

- (void)dealloc {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

@end

@interface ViewController ()

@property (strong, nonatomic) Person *person;

@end

@implementation ViewController

- (Person *)getPerson {
    return [[Person alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.person = [self getPerson];
    NSLog(@"-----------");
    
    
//    [self performSelector:@selector(doSome) withObject:self afterDelay:1 inModes:@[NSDefaultRunLoopMode, NSRunLoopCommonModes]];
}


@end
