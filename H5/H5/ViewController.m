//
//  ViewController.m
//  H5
//
//  Created by itang on 2020/9/2.
//  Copyright © 2020 learn. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "CustomJSObject.h"

@interface ViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadWeb];
}

- (void)loadWeb {
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    
    NSString *basePath = NSBundle.mainBundle.bundlePath;
    NSURL *baseURL = [NSURL fileURLWithPath:basePath];
    NSString *htmlPath = [NSBundle.mainBundle pathForResource:@"File" ofType:@"html"];
    NSString *htmlContent = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlContent baseURL:baseURL];
    [self.view addSubview:self.webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
    
    // 网页加载完成后，注入object
    [self addCustomeObject];
}

- (void)addCustomeObject {
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    CustomJSObject *object = [CustomJSObject new];
    object.context = context;
    context[@"native"] = object;
}

@end
