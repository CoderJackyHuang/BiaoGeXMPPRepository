//
//  NSObject+Extension.h
//  CloudShopping
//
//  Created by sixiaobo on 14-7-8.
//  Copyright (c) 2014年 com.Uni2uni. All rights reserved.
//

#import <Foundation/Foundation.h>

// 应用在app store上的ID
#define kAppIDInAppStore    @"" // 发布以后才有APP ID
#define kAppStoreVersionKey @"AppStoreVersionKey"

/*!
 * @brief 通用辅助扩展类
 * @author huangyibiao
 */
@interface NSObject (Extension)

/*
 * @brief 把对象转换成JSON格式数据
 * @param object OC类型对象
 * @return 如果转换失败，返回nil，否则返回JSON格式数据
 */
+ (NSMutableData *)JSONDataWithObject:(id)object;

/*
 * @brief 判断本机是否安装了某个应用，该应用是自己公司的产品
 * @param urlSchemes 要判断的应用的URLSchemes，该参数值是由要判断的应用工程上配置的URLSchemes参数
 * @return 返回YES表示本机已经安装了该应用，返回NO表示该应用未被安装
 */
+ (BOOL)hadInstallApp:(NSString *)urlSchemes;

/*
 * @brief 判断能否打开指定的Itunes应用的链接
 * @param itunesUrlString 要打开在Itunes上的应用的链接
 * @return 返回YES表示可以打开该链接，返回NO表示无法打开该链接
 */
+ (BOOL)canOpenApp:(NSString *)itunesUrlString;

/*
 * @brief 在本机调起指定的应用
 * @param urlSchemes 要判断的应用的URLSchemes，该参数值是由要调起的应用工程上配置的URLSchemes参数
 */
+ (void)openApp:(NSString *)urlSchemes;

/*
 * @brief 进入APP Store
 * @param itunesUrlString 要打开在Itunes上的应用的链接
 */
+ (void)goToAppStoreWithURLString:(NSString *)itunesUrlString;

@end
