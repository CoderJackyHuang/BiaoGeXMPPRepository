//
//  HYBBaseController.h
//  BiaoGeIMProject
//
//  Created by ljy-335 on 14-10-31.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBKeyboardScrollView.h"

/*!
 * @brief 最顶层控制器基类，所有控制器类都需要直接或间接继承于此类
 * 
 * @author huangyibiao
 */
@interface HYBBaseController : UIViewController {
    @protected
    HYBKeyboardScrollView *_keyboardScrollView;
    CGFloat               _originY;
}

- (instancetype)initWithKeyboardScrollViewAsBackgroundView:(BOOL)asBackgroundView;

- (void)addLeftButtonWithTitle:(NSString *)title action:(SEL)action;
- (void)addRightButtonWithTitle:(NSString *)title action:(SEL)action;

@end
