//
//  ViewController.m
//  Performance
//
//  Created by itang on 2020/8/21.
//  Copyright © 2020 learn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//- (IBAction)fun1:(id)sender {
//    NSURL *url = [NSURL URLWithString:@"http://localhost:8081/default.jpg"];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        UIImage *image = [[UIImage alloc] initWithData:data];
//        NSLog(@"response is %@",response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.myImage.image = image;
//        });
//    }];
//    [dataTask resume];
//}

//- (IBAction)fun2:(id)sender {
//    NSURL *url = [NSURL URLWithString:@"http://localhost:8081/default.jpg"];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
//    if (self.imgDate)
//    {
//        [request setValue:self.imgDate forHTTPHeaderField:@"If-Modified-Since"];
//    }
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
//        NSDictionary *headerDict = httpResponse.allHeaderFields;
//        if ([headerDict objectForKey:@"Last-Modified"])
//        {
//            self.imgDate = [headerDict objectForKey:@"Last-Modified"];
//        }
//        UIImage *image = [[UIImage alloc] initWithData:data];
//        NSLog(@"response is %@",response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.myImage.image = image;
//        });
//    }];
//    [dataTask resume];
//}

//- (IBAction)fun3:(id)sender {
//    NSURL *url = [NSURL URLWithString:@"http://localhost:8081/default.jpg"];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
//    if (self.eTag)
//    {
//        [request setValue:self.eTag forHTTPHeaderField:@"If-None-Match"];
//    }
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
//        NSDictionary *headerDict = httpResponse.allHeaderFields;
//        if ([headerDict objectForKey:@"Etag"])
//        {
//            self.eTag = [headerDict objectForKey:@"Etag"];
//        }
//        UIImage *image = [[UIImage alloc] initWithData:data];
//        NSLog(@"response is %@",response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.myImage.image = image;
//        });
//    }];
//    [dataTask resume];
//}

- (IBAction)fun4:(id)sender {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

/*!
@brief 如果本地缓存资源为最新，则使用使用本地缓存。如果服务器已经更新或本地无缓存则从服务器请求资源。

@details

步骤：
1. 请求是可变的，缓存策略要每次都从服务器加载
2. 每次得到响应后，需要记录住 LastModified
3. 下次发送请求的同时，将LastModified一起发送给服务器（由服务器比较内容是否发生变化）

@return 图片资源
*/
//- (void)getData:(GetDataCompletion)completion {
//   NSURL *url = [NSURL URLWithString:kLastModifiedImageURL];
//   NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15.0];
//
//   //    // 发送 etag
//   //    if (self.etag.length > 0) {
//   //        [request setValue:self.etag forHTTPHeaderField:@"If-None-Match"];
//   //    }
//   // 发送 LastModified
//   if (self.localLastModified.length > 0) {
//       [request setValue:self.localLastModified forHTTPHeaderField:@"If-Modified-Since"];
//   }
//
//   [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//
//       // NSLog(@"%@ %tu", response, data.length);
//       // 类型转换（如果将父类设置给子类，需要强制转换）
//       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//       NSLog(@"statusCode == %@", @(httpResponse.statusCode));
//       // 判断响应的状态码是否是 304 Not Modified （更多状态码含义解释： https://github.com/ChenYilong/iOSDevelopmentTips）
//       if (httpResponse.statusCode == 304) {
//           NSLog(@"加载本地缓存图片");
//           // 如果是，使用本地缓存
//           // 根据请求获取到`被缓存的响应`！
//           NSCachedURLResponse *cacheResponse =  [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
//           // 拿到缓存的数据
//           data = cacheResponse.data;
//       }
//
//       // 获取并且纪录 etag，区分大小写
//       //        self.etag = httpResponse.allHeaderFields[@"Etag"];
//       // 获取并且纪录 LastModified
//       self.localLastModified = httpResponse.allHeaderFields[@"Last-Modified"];
//       //        NSLog(@"%@", self.etag);
//       NSLog(@"%@", self.localLastModified);
//       dispatch_async(dispatch_get_main_queue(), ^{
//           !completion ?: completion(data);
//       });
//   }] resume];
//}
@end
