//
//  UIColor+ColorExtension.m
//  HomeLinkProject
//
//  Created by huangyibiao on 14-6-1.
//  Copyright (c) 2014年 huangyibiao. All rights reserved.
//

#import "UIColor+ColorExtension.h"

#define kImageWidth  1
#define kImageHeight 1

@implementation UIColor (ColorExtension)

/*!
 * @brief 根据颜色生成图片，生成的图片默认是1*1的
 * @param color 颜色对象
 * @return 返回生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color {
    return [[self class] imageWithColor:color size:CGSizeMake(kImageWidth, kImageHeight)];
}

/*!
 * @brief 根据颜色、图片大小来生成图片
 * @param color 颜色对象
 * @return 返回生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    // 画图开始
    UIGraphicsBeginImageContext(size);
    // 获取图形设备上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置填充颜色
    CGContextSetFillColorWithColor(context, color.CGColor);
    // 用所设置的填充颜色填充
    CGContextFillRect(context, rect);
    // 得到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 画图结束，解释资源
    UIGraphicsEndImageContext();
    
    return image;
}

@end
