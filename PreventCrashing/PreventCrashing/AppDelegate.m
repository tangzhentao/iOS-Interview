//
//  AppDelegate.m
//  PreventCrashing
//
//  Created by itang on 2020/8/25.
//  Copyright © 2020 learn. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSInvocation;
    
    [self.window addObserver:self forKeyPath:@"frame" options:(NSKeyValueObservingOptionNew) context:nil];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(setStackSize:) name:@"sss" object:nil];
    NSPointerArray
    return YES;
}

@end
