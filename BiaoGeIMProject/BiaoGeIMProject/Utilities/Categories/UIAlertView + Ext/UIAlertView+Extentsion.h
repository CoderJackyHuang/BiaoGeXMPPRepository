//
//  UIAlertView+Extentsion.h
//  CloudShopping
//
//  Created by sixiaobo on 14-7-8.
//  Copyright (c) 2014年 com.Uni2uni. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 * @brief UIAlertView扩展类，用于提供更加简化的方式来调用显示UIAlertView
 * @author huangyibiao
 */
@interface UIAlertView (Extentsion)

/*!
 * @brief 默认会带有确定和取消按钮
 * @param message 标题
 */
+ (UIAlertView *)showWithMessage:(NSString *)message;

/*!
 * @brief 默认会带有确定和取消按钮，需要标题和内容参数
 * @param title 标题
 * @param message 内容
 */
+ (UIAlertView *)showWithTitle:(NSString *)title message:(NSString *)message;

/*!
 * @brief 默认会带有确定和取消按钮，需要标题和内容参数
 * @param title 标题
 * @param message 内容
 * @param delegate 代理
 */
+ (UIAlertView *)showWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate;

/*!
 * @brief 需要标题和内容参数,确定和取消按钮标题
 * @param title 标题
 * @param message 内容
 * @param okButtonTitle 确定标题
 */
+ (UIAlertView *)showWithTitle:(NSString *)title
              message:(NSString *)message
             okButton:(NSString *)okButtonTitle
         cancelButton:(NSString *)cancelButtonTitle;

/*!
 * @brief 需要标题和内容参数，代理，确定和取消按钮标题
 * @param title 标题
 * @param message 内容
 * @param delegate 代理
 */
+ (UIAlertView *)showWithTitle:(NSString *)title
              message:(NSString *)message
             delegate:(id)delegate
             okButton:(NSString *)okButtonTitle
         cancelButton:(NSString *)cancelButtonTitle;



@end
