//
//  ViewController.m
//  KVO
//
//  Created by itang on 2020/9/10.
//  Copyright © 2020 learn. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@property (strong, nonatomic) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.person = [Person new];
    self.person.name = @"jobs";
    
    [self.person addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:nil];
    [self.person addObserver:self forKeyPath:@"addres" options:(NSKeyValueObservingOptionNew) context:nil];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@: %@", keyPath, change[NSKeyValueChangeNewKey]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.person.name = @"ss";
    self.person.addres = @"bj";

}


@end
