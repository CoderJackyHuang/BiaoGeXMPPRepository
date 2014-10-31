//
//  NSObject+Extension.m
//  CloudShopping
//
//  Created by sixiaobo on 14-7-8.
//  Copyright (c) 2014年 com.Uni2uni. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

#pragma mark - 获取JSON数据
/*
 * @brief 把对象转换成JSON格式数据
 * @param object OC类型对象
 * @return 如果转换失败，返回nil，否则返回JSON格式数据
 */
+ (NSMutableData *)JSONDataWithObject:(id)object {
    NSMutableData *postBodyData = nil;
    if ([NSJSONSerialization isValidJSONObject:object]) {
        NSError *error = nil;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:object
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        if (error) {
            NSLog(@"error: %@", error.description);
        } else {
            postBodyData = [[NSMutableData alloc] initWithData:postData];
        }
    }
    return postBodyData;
}

/*
 * @brief 判断本机是否安装了某个应用，该应用是自己公司的产品
 * @param urlSchemes 要判断的应用的URLSchemes，该参数值是由要判断的应用工程上配置的URLSchemes参数
 * @return 返回YES表示本机已经安装了该应用，返回NO表示该应用未被安装
 */
+ (BOOL)hadInstallApp:(NSString *)urlSchemes {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlSchemes]]) {
        return YES;
    }
    return NO;
}

/*
 * @brief 判断能否打开指定的Itunes应用的链接
 * @param itunesUrlString 要打开在Itunes上的应用的链接
 * @return 返回YES表示可以打开该链接，返回NO表示无法打开该链接
 */
+ (BOOL)canOpenApp:(NSString *)itunesUrlString {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:itunesUrlString]]) {
        return YES;
    }
    return NO;
}

/*
 * @brief 在本机调起指定的应用
 * @param urlSchemes 要判断的应用的URLSchemes，该参数值是由要调起的应用工程上配置的URLSchemes参数
 */
+ (void)openApp:(NSString *)urlSchemes {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlSchemes]];
    return;
}

#pragma mark - 进入AppStore应用
/*
 * @brief 进入APP Store
 * @param itunesUrlString 要打开在Itunes上的应用的链接
 */
+ (void)goToAppStoreWithURLString:(NSString *)itunesUrlString {
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"虚拟机不支持APP Store.打开iTunes不会有效果。");
#else
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesUrlString]];
#endif
    return;
}

@end
