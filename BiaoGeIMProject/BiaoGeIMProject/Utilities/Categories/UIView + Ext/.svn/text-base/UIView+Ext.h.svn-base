//
//  UIView+Ext.h
//  HomeLinkProject
//
//  Created by huangyibiao on 14-6-1.
//  Copyright (c) 2014年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 * @brief  UIView的扩展类
 * @author huangyibiao
 */
@interface UIView (Ext)

/**
 * @brief Shortcut for frame.origin.x.
 *        Sets frame.origin.x = originX
 */
@property (nonatomic) CGFloat originX;

/**
 * @brief Shortcut for frame.origin.y
 *        Sets frame.origin.y = originY
 */
@property (nonatomic) CGFloat originY;

/**
 * @brief Shortcut for frame.origin.x + frame.size.width
 *       Sets frame.origin.x = rightX - frame.size.width
 */
@property (nonatomic) CGFloat rightX;

/**
 * @brief Shortcut for frame.origin.y + frame.size.height
 *        Sets frame.origin.y = bottomY - frame.size.height
 */
@property (nonatomic) CGFloat bottomY;

/**
 * @brief Shortcut for frame.size.width
 *        Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * @brief Shortcut for frame.size.height
 *        Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * @brief Shortcut for center.x
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * @brief Shortcut for center.y
 *        Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * @brief Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * @brief Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

/*!
 * @brief 移除此view上的所有子视图
 * @return 返回截图图片
 */
- (void)removeAllSubviews;

/*!
 * @brief 对当前view截图
 * @return 返回截图图片
 */
- (UIImage *)captureScreenshot;

// 给自己添加左右抖动的效果
- (void)addShakeAnimation;

@end
