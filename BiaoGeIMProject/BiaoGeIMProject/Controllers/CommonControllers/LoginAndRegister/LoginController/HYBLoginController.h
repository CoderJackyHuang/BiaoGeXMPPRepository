//
//  HYBLoginController.h
//  BiaoGeIMProject
//
//  Created by ljy-335 on 14-10-31.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBBaseController.h"

/*!
 * @brief 登录
 *
 * @author huangyibiao
 */
@interface HYBLoginController : HYBBaseController

/*!
 * @brief 调用此方法来显示登录界面
 * @param presentController 显示登录界面的控制器类
 * @param successCompletion 登录成功后的回调block
 */
typedef void (^HYBLoginCompletion)(BOOL isLoginSuccess);
- (void)loginWithPresentController:(UIViewController *)presentController
                 completion:(HYBLoginCompletion)completion;

@end
