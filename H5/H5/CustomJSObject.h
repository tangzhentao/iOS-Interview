//
//  CustomJSObject.h
//  H5
//
//  Created by itang on 2020/9/2.
//  Copyright © 2020 learn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN


@protocol CustomJSProtocol <JSExport>

// h5调用OC的方法
- (void)helloWQL;
- (void)sendValueFromHtmlToOCWithValue:(NSString *)value;
- (void)sendValueFromH5ToOC:(NSString *)value;

//从html传两个值给OC
- (void)sendValueFromHtmlToOCWithValue:(NSString*)value WithValueTwo:(NSString*)valueTwo;

// OC给H5传值
- (void)sendValueToHtml;

@end

@interface CustomJSObject : NSObject<CustomJSProtocol>

@property (strong, nonatomic) JSContext *context;

@end

NS_ASSUME_NONNULL_END
