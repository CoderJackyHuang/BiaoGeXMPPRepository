//
//  UIAlertView+Extentsion.m
//  CloudShopping
//
//  Created by sixiaobo on 14-7-8.
//  Copyright (c) 2014年 com.Uni2uni. All rights reserved.
//

#import "UIAlertView+Extentsion.h"

#define kOkButtonDefaultTitle     @"确定"
#define kCancelButtonDefaultTitle @"取消"

@implementation UIAlertView (Extentsion)

+ (UIAlertView *)showWithMessage:(NSString *)message {
    return [self showWithTitle:nil message:message];
}

+ (UIAlertView *)showWithTitle:(NSString *)title message:(NSString *)message {
    return [self showWithTitle:title message:message delegate:nil];
}

+ (UIAlertView *)showWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate {
    return [self showWithTitle:title
                       message:message
                      okButton:kOkButtonDefaultTitle
                  cancelButton:kCancelButtonDefaultTitle];
}

+ (UIAlertView *)showWithTitle:(NSString *)title
                       message:(NSString *)message
                      okButton:(NSString *)okButtonTitle
                  cancelButton:(NSString *)cancelButtonTitle {
    return [self showWithTitle:title
                       message:message
                      delegate:nil
                      okButton:okButtonTitle
                  cancelButton:cancelButtonTitle];
}

+ (UIAlertView *)showWithTitle:(NSString *)title
                       message:(NSString *)message
                      delegate:(id)delegate
                      okButton:(NSString *)okButtonTitle
                  cancelButton:(NSString *)cancelButtonTitle {
    UIAlertView *alertView = nil;
    
    alertView =  [[UIAlertView alloc] initWithTitle:title
                                            message:message
                                           delegate:delegate
                                  cancelButtonTitle:cancelButtonTitle
                                  otherButtonTitles:okButtonTitle, nil];
    [alertView show];
    return alertView;
}



@end
