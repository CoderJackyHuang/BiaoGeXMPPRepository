//
//  Common.h
//  CloudShopping
//
//  Created by sixiaobo on 14-7-8.
//  Copyright (c) 2014年 com.Uni2uni. All rights reserved.
//

#ifndef CloudShopping_Common_h
#define CloudShopping_Common_h

/*!
 * @brief 全局通用宏
 *
 * @author huangyibiao
 */

// 全局通用的Block，所有错误Block都使用此Block
typedef void (^HYBErrorBlock)(NSError *error);

// 在使用block的地方，不能使用强引用
#define kWeakObject(object) __weak typeof(object) weakObject = object;

// 获取主线程
#define kMainThread (dispatch_get_main_queue())
// 全局线程
#define kGlobalThread dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

// @{
// @name 适配相关

// 判断是否是ios7及其以上版本
#define kIsIOS7OrLater ([UIDevice currentDevice].systemVersion.integerValue >= 7 ? YES : NO)
// 获取屏幕的高度
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
// 获取屏幕的宽
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
// 导航的高度
#define kNavigationBarHeight 44.0
// 标签栏的高度
#define kTabBarHeight 49.0
// @} end

// @{
// @name 颜色相关宏

///< 参数格式为：0xFFFFFF
#define kColorWith16RGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
                green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
                 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
///< 参数格式：22,22,22
#define kColorWithRGB(r, g, b) ([UIColor colorWithRed:(r) / 255.0  \
                                                green:(g) / 255.0  \
                                                 blue:(b) / 255.0  \
                                                alpha:1])
///< 参数格式：22,22,22,0.5
#define kColorWithRGBA(r, g, b, a) ([UIColor colorWithRed:(r) / 255.0  \
                                                    green:(g) / 255.0  \
                                                     blue:(b) / 255.0  \
                                                    alpha:(a)])

// @} end

// @{
// @name 字体相关宏
#define kFontWithSize(Size) [UIFont systemFontOfSize:Size]
#define kBoldFontWithSize(Size) [UIFont boldSystemFontOfSize:Size]
// 使用自定义字体才调用此
#define kFontWithNameAndSize(Name, Size) [UIFont fontWithName:Name size:Size]
// @} end

// @{
// @name 生成图片相关
#define kImageWithName(Name) ([UIImage imageNamed:Name])
#define kBigImageWithName(Name) ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:Name ofType:nil]])
// @} end


// @{
// @name 相关单例简化宏、通知

#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kNotificationCenter  [NSNotificationCenter defaultCenter]
#define kPostNotificationWithName(notificationName) \
[kNotificationCenter postNotificationName:notificationName object:nil userInfo:nil];
// @} end

// @{
// @name 全局使用的变量
// 获取appDelegate
#define kAppDelegate (HYBAppDelegate *)([UIApplication sharedApplication].delegate)
// @} end

// 判断空串
#define kIsEmptyString(str) (!(str && ![str isKindOfClass:[NSNull class]] && str.length))
// 判断是否是NSNull对象
#define kIsNull(obj) ([obj isKindOfClass:[NSNull class]])

// 打印JSON串，参数是OC对象
#define kLogJSONObject(JSONObject) \
NSLog(@"%@", [[NSString alloc] initWithData:[NSObject JSONDataWithObject:JSONObject] encoding:NSUTF8StringEncoding])
// 打印JSON串，参数是OC对象
#define kLogMsgJSONObject(Msg, JSONObject) \
NSLog(@"%@\n%@", Msg, [[NSString alloc] initWithData:[NSObject JSONDataWithObject:JSONObject] encoding:NSUTF8StringEncoding])
// 打印JOSN串，参数是二进制数据
#define kLogJSONData(JSONData) \
NSLog(@"%@", [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding])
// 打印JOSN串，参数是二进制数据
#define kLogMsgJSONData(Msg, JSONData) \
NSLog(@"%@\n%@", Msg, [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding])

#endif
