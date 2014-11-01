//
//  HYBLoadImageView.h
//  CloudShopping
//
//  Created by ljy-335 on 14-8-1.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 * @brief 加载图片时，给图片加上转圈圈的状态，让用户知道图片未出现是因为网络不给力而造成的而不是没有图片
 * @author huangyibiao
 */
@interface HYBLoadImageView : UIImageView

@property (nonatomic, assign) BOOL isCircle;

/*!
 * @brief 根据图片网址来请求图片
 * @param urlString 图片网址
 * @pramr placeholder 占位图片路径
 */
- (void)setImageWithURLString:(NSString *)urlString placeholder:(NSString *)placeholder;

@end
