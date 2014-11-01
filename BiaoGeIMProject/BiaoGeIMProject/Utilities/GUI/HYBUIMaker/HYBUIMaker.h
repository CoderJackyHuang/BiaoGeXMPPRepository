//
//  HYBUIMaker.h
//  CloudShopping
//
//  Created by sixiaobo on 14-7-8.
//  Copyright (c) 2014年 com.Uni2uni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYBLoadImageView.h"

/*!
 * @brief 控件生成器类
 *
 * @author huangyibiao
 */
@interface HYBUIMaker : NSObject

#pragma mark - UITextField
////////////////////////////////////////////////////////////////////////////////////////////
+ (UITextField *)textFieldWithFrame:(CGRect)frame
                        placeholder:(NSString *)placeholder
                           security:(BOOL)security;
+ (UITextField *)textFieldWithFrame:(CGRect)frame
                        placeholder:(NSString *)placeholder;

#pragma mark - UIImageView
+ (UIImageView *)imageViewWithFrame:(CGRect)frame;
+ (UIImageView *)imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName;
+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                          imageName:(NSString *)imageName
                             target:(id)target
                             action:(SEL)action;
// 生成圆形图片视图
+ (HYBLoadImageView *)circleImageViewWithFrame:(CGRect)frame showInView:(UIView *)inView target:(id)target action:(SEL)action;

#pragma mark - UIButton
////////////////////////////////////////////////////////////////////////////////////////////
+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                       target:(id)target
                       action:(SEL)action;
+ (UIButton *)buttonWithFrame:(CGRect)frame
                        image:(UIImage *)image
                     selImage:(UIImage *)selImage
                       target:(id)target
                       action:(SEL)action;
+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                       target:(id)target
                       action:(SEL)action
                       inView:(UIView *)inView;
+ (UIButton *)buttonWithFrame:(CGRect)frame
                    imageName:(NSString *)imageName
                       target:(id)target
                       action:(SEL)action;
+ (UIButton *)buttonWithFrame:(CGRect)frame
                    imageName:(NSString *)imageName
            selectedImageName:(NSString *)selectedImageName
                       target:(id)target
                       action:(SEL)action;
+ (UIButton *)buttonWithFrame:(CGRect)frame
                    imageName:(NSString *)imageName
         highlightedImageName:(NSString *)highlightedImageName
                       target:(id)target
                       action:(SEL)action;
/*!
 * @brief 用于生成指定颜色边框和指定背景颜色和标题的按钮，borderWidth = 1,fontSize=15
 * @author huangyibiao
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                       target:(id)target
                       action:(SEL)action
                    textColor:(UIColor *)textColor
                      bgColor:(UIColor *)bgColor
                  borderColor:(UIColor *)color;
// 白色字体、白色边框作为默认值
+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                       target:(id)target
                       action:(SEL)action
                      bgColor:(UIColor *)bgColor;
#pragma mark - UILabel
////////////////////////////////////////////////////////////////////////////////////////////
// 默认都是居中对齐、透明背景色、白色字体、15号字体
+ (UILabel *)labelWithFrame:(CGRect)frame;
+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text;
+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color;
+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font;
#pragma mark - UIScrollView
+ (UIScrollView *)scrollViewWithFrame:(CGRect)frame contentSize:(CGSize)contentSize;

@end
