//
//  NSString+Common.h
//  CloudShopping
//
//  Created by sixiaobo on 14-7-9.
//  Copyright (c) 2014年 com.Uni2uni. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @brief NSString 的通用扩展
 * @author huangyibiao
 */
@interface NSString (Common)

/*!
 * @brief 获取Documents路径
 */
+ (NSString *)documentPath;

/*!
 * @brief 获取沙盒下tmp路径
 */
+ (NSString *)tmpPath;

/*!
 * @brief 获取用户登录的信息存储的缓存路径
 */
+ (NSString *)userAccountInfoPath;

/*!
 * @brief 获取首页存储路径
 */
+ (NSString *)homeAppListPath;

/*!
 * @brief 获取其它的缓存路径
 */
+ (NSString *)cachePath;

/*!
 * @brief 资源下载存储的路径
 */
+ (NSString *)downloadPath;

/*!
 * @brief 获取图片缓存路径
 */
+ (NSString *)imageCachePath;

/*!
 * @brief 获取文本的高度、宽度
 * @author huangyibiao
 */
+ (float)heightForString:(NSString *)value fontSize:(float)fontSize width:(float)width;
+ (float)heightForString:(NSString *)value font:(UIFont *)font width:(float)width;
+ (CGFloat)widthWithFontSize:(CGFloat)fontSize text:(NSString *)text;

/*!
 * @brief  根据文件名返回文件的路径
 * @param  fileName 文件名，最好带上后缀名，如@“myName.png”
 * @return 如果文件路径存在，则返回该文件路径，否则返回nil
 */
+ (NSString *)pathWithFileName:(NSString *)fileName;

/*!
 * @brief  根据文件名返回文件的路径
 * @param  fileName 文件名，不能带上后缀名
 * @param  type     文件后缀名
 * @return 如果文件路径存在，则返回该文件路径，否则返回nil
 */
+ (NSString *)pathWithFileName:(NSString *)fileName ofType:(NSString *)type;

/*!
 * @brief  根据时间秒数，返回格式化的日期，如"2014-09-03"
 * @param  seconds 秒数，如果sections值为0，则返回当前日期
 * @return 如果seconds不为0，则返回转换后的日期，否则返回当前日期
 */
+ (NSString *)dateWithSeconds:(NSUInteger)seconds;

/*!
 * @brief  验证是否是合法邮箱
 * @return YES表示是合法的邮箱格式，返回NO表示邮箱格式不正确
 */
- (BOOL)isValidEmail;

/*!
 * @brief  验证是否是正确的手机号码格式
 * @return YES表示是正确的手机号码格式，返回NO表示手机号码格式不正确
 */
- (BOOL)isValidPhoneNumber;

/*!
 * @brief  验证是否是正确的18位身份证号码格式
 * @return YES表示是正确的身份证号码格式，返回NO表示身份证号码格式不正确
 */
- (BOOL)isValidPersonID;

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
- (BOOL)areaCode:(NSString *)code;

/**
 * 功能: 获取本地应用版本号
 */
+ (NSString *)appLocalVersion;

/*!
 * @brief 去掉空格符号操作，分别是去掉左边的空格、去掉右边的空格、去掉两边的空格、去掉所有空格
 * @date 2014-08-21
 */
- (NSString *)trimLeft;
// 去掉右边的空格
- (NSString *)trimRight;
// 去掉两边的空格
- (NSString *)trim;
// 去掉所有空格
- (NSString *)trimAll;
// 去掉所有的字母
- (NSString *)trimLetters;

/*
 * @brief 去掉字符中中所有的指定的字符
 */
- (NSString *)trimCharacter:(unichar)character;

// @brief 判断是否只包含字母、数字、字母和数字
// @date 2014-08-21
//
// 只包含字母
- (BOOL)isOnlyLetters;
// 只包含数字
- (BOOL)isOnlyNumbers;
// 只包含字母和数字
- (BOOL)isOnlyAlphaNumeric;

/*!
 * @brief 把字符串转换成data数据
 */
- (NSData *)toData;

/*!
 * @brief NSData数据转换成NSString数据
 */
+ (NSString *)toString:(NSData *)data;

/*!
 * @brief 过滤掉HTML标签
 * @param html HTML内容
 * @param 返回喜欢去掉所有HTML标签后的字符串
 */
+ (NSString *)filterHTML:(NSString *)html;

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/*!
 * @brief 判断是否是空串
 * @return YES表示是空串，NO表示非空
 */
- (BOOL)isEmpty;

/*!
 * @brief 判断去掉两边的空格后是否是空串
 * @return YES表示是空串，NO表示非空
 */
- (BOOL)isTrimEmpty;
@end
