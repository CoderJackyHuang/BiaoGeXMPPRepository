//
//  HYBKeyboardScrollView.m
//  HomeLinkProject
//
//  Created by huangyibiao on 14-6-3.
//  Copyright (c) 2014年 huangyibiao. All rights reserved.
//

#import "HYBKeyboardScrollView.h"

@interface HYBKeyboardScrollView ()

// 添加、移除对键盘的监听通知
- (void)addKeyboardNotifications;
- (void)removeKeyboardNotifications;

// 键盘出现、隐藏的通知回调
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
@end

@implementation HYBKeyboardScrollView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.iskeyboardShown = NO;
        [self addKeyboardNotifications];
    }
    return self;
}

- (void)awakeFromNib {
    [self addKeyboardNotifications];
    self.contentSize = CGSizeMake(320, 700);
    return;
}

- (void)dealloc {
    [self removeKeyboardNotifications];
    return;
}

- (void)addKeyboardNotifications {
    self.iskeyboardShown = NO;
    [kNotificationCenter addObserver:self
                            selector:@selector(keyboardWillShow:)
                                name:UIKeyboardWillShowNotification
                              object:nil];
    [kNotificationCenter addObserver:self
                            selector:@selector(keyboardWillHide:)
                                name:UIKeyboardWillHideNotification
                              object:nil];
    return;
}

- (void)removeKeyboardNotifications {
    [kNotificationCenter removeObserver:self
                                name:UIKeyboardWillShowNotification
                              object:nil];
    [kNotificationCenter removeObserver:self
                                name:UIKeyboardWillHideNotification
                              object:nil];
    return;
}

// 点击滚动视图时隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
    if ([self.keyboardHideDelegate respondsToSelector:@selector(keyboardWillHide)]) {
        [self.keyboardHideDelegate keyboardWillHide];
    }
    return;
}

// scroll contentOffset when keybord will show
- (void)keyboardWillShow:(NSNotification *)notification {
    if ([self.keyboardHideDelegate respondsToSelector:@selector(keyboardWillShow)]) {
        [self.keyboardHideDelegate keyboardWillShow];
    }
        
    self.previousOffset = self.contentOffset;
    NSDictionary *userInfo = [notification userInfo];
    
    // get keyboard rect in windwo coordinate
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // convert keyboard rect from window coordinate to scroll view coordinate
    keyboardRect = [self convertRect:keyboardRect fromView:nil];
    // get keybord anmation duration
    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // get first responder textfield
    UIView *currentResponder = [self findFirstResponderBeneathView:self];
    if (currentResponder != nil) {
        // convert textfield left bottom point to scroll view coordinate
        CGPoint point = [currentResponder convertPoint:CGPointMake(0, currentResponder.frame.size.height)
                                                toView:self];
        // 计算textfield左下角和键盘上面35像素 之间是不是差值
        float scrollY = point.y - (keyboardRect.origin.y - 35);
        if (scrollY > 0) {
            [UIView animateWithDuration:animationDuration animations:^{
                //移动textfield到键盘上面20个像素
                self.contentOffset = CGPointMake(self.contentOffset.x, self.contentOffset.y + scrollY);
            }];
        }
    }
    self.scrollEnabled = NO;
    self.iskeyboardShown = YES;
    return;
}

// roll back content offset
- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.contentOffset = self.previousOffset;
    }];
    self.scrollEnabled = YES;
    if ([self.keyboardHideDelegate respondsToSelector:@selector(keyboardWillHide)]) {
        [self.keyboardHideDelegate keyboardWillHide];
    }
    self.iskeyboardShown = NO;
    return;
}

- (UIView *)findFirstResponderBeneathView:(UIView *)view {
    // 递归查找第一响应者
    for (UIView *childView in view.subviews ) {
        if ([childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] ) {
            return childView;
        }
        UIView *result = [self findFirstResponderBeneathView:childView];
        if (result) {
            return result;
        }
    }
    return nil;
}

@end
