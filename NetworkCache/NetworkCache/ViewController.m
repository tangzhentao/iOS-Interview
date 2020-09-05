//
//  ViewController.m
//  NetworkCache
//
//  Created by itang on 2020/8/22.
//  Copyright © 2020 learn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.btn addTarget:self action:@selector(btnTapped) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self printDefaultCache];
}

- (void)btnTapped {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
}

/*
 https://upload-images.jianshu.io/upload_images/15401334-ac0bb054bdd01cd2.png?imageMogr2/auto-orient/strip|imageView2/2/w/1158/format/webp
 */

/* 打印默认的缓存的情况 */
- (void)printDefaultCache {
    NSLog(@"磁盘缓存容量%lu字节", NSURLCache.sharedURLCache.diskCapacity);
    NSLog(@"已使用磁盘缓存%lu字节", NSURLCache.sharedURLCache.currentDiskUsage);
    NSLog(@"内存缓存容量%lu字节", NSURLCache.sharedURLCache.memoryCapacity);
    NSLog(@"已使用内存缓存%lu字节", NSURLCache.sharedURLCache.currentMemoryUsage);
}

- (void)loadImage {
    NSString *address = @"http://img15.3lian.com/2015/f2/50/d/71.jpg";
    NSURL *url = [NSURL URLWithString:address];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:10];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    
    [task resume];
}

@end
