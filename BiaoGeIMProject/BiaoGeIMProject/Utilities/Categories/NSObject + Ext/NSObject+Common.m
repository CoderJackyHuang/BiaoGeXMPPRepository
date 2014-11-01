//
//  NSObject+Common.m
//  PersonalShoppingMall
//
//  Created by ljy-335 on 14-8-21.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

#import "NSObject+Common.h"

@implementation NSObject (Common)

/*!
 * @brief 把角度转换成弧度值
 * @param degree 角度
 * @return 返回对应的弧度值
 */
+ (CGFloat)degreesToRadian:(CGFloat)degree {
    return (M_PI * degree) / 180.0;
}

/*!
 * @brief 把弧度转换成角度值
 * @param radian 弧度
 * @return 返回对应的角度值
 */
+ (CGFloat)randianToDegrees:(CGFloat)radian {
    return (radian * 180.0) / M_PI;
}

@end
