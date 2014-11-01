//
//  HYBUIMaker.m
//  CloudShopping
//
//  Created by sixiaobo on 14-7-8.
//  Copyright (c) 2014年 com.Uni2uni. All rights reserved.
//

#import "HYBUIMaker.h"

@implementation HYBUIMaker

+ (UIButton *)buttonWithFrame:(CGRect)frame image:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selImage forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


#pragma mark - UITextField
+ (UITextField *)textFieldWithFrame:(CGRect)frame
                        placeholder:(NSString *)placeholder
                           security:(BOOL)security {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.secureTextEntry = security;
    textField.placeholder = placeholder;
    textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.borderStyle = UITextBorderStyleNone;
    textField.backgroundColor = [UIColor whiteColor];
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, frame.size.height)];
    textField.leftView.backgroundColor = [UIColor whiteColor];
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

+ (UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder {
    return [self textFieldWithFrame:frame placeholder:placeholder security:NO];
}

#pragma mark - UIImageView
+ (UIImageView *)imageViewWithFrame:(CGRect)frame {
    return [self imageViewWithFrame:frame imageName:nil];
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                          imageName:(NSString *)imageName
                             target:(id)target
                             action:(SEL)action {
    UIImageView *imgView = [self imageViewWithFrame:frame imageName:imageName];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:tap];
    
    return imgView;
}

// 生成圆形图片视图
+ (HYBLoadImageView *)circleImageViewWithFrame:(CGRect)frame showInView:(UIView *)inView target:(id)target action:(SEL)action {
    // displaying the image in a circle by using a shape layer
    // layer fill color controls the masking
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
    CGRect fm = CGRectMake(1, 1, frame.size.width - 2, frame.size.height - 2);
    UIBezierPath *layerPath = [UIBezierPath bezierPathWithOvalInRect:fm];
    maskLayer.path = layerPath.CGPath;
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    
    // use another view for clipping so that when the image size changes, the masking layer does not need to be repositioned
    UIView *clippingViewForLayerMask = [[UIView alloc] initWithFrame:frame];
    clippingViewForLayerMask.layer.mask = maskLayer;
    clippingViewForLayerMask.clipsToBounds = YES;
    clippingViewForLayerMask.backgroundColor = [UIColor clearColor];
    [inView addSubview:clippingViewForLayerMask];
    
    HYBLoadImageView *imgView = [[HYBLoadImageView alloc] initWithFrame:clippingViewForLayerMask.bounds];
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [imgView addGestureRecognizer:tap];
    imgView.backgroundColor = [UIColor clearColor];
    [clippingViewForLayerMask addSubview:imgView];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.autoresizesSubviews = YES;
    imgView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    return imgView;
}

#pragma mark - UIButton
+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                       target:(id)target
                       action:(SEL)action
                       inView:(UIView *)inView {
    UIButton *button = [[self class] primaryButtonWithFrame:frame target:target action:action];
    [button setTitle:title forState:UIControlStateNormal];
    [inView addSubview:button];
    
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                       target:(id)target
                       action:(SEL)action
                    textColor:(UIColor *)textColor
                      bgColor:(UIColor *)bgColor
                  borderColor:(UIColor *)color {
    UIButton *button = [self buttonWithFrame:frame title:title target:target action:action];
    button.layer.cornerRadius = 4;
    button.layer.borderWidth = 1;
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.borderColor = color.CGColor;
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font = kBoldFontWithSize(15);
    button.backgroundColor = bgColor;
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                       target:(id)target
                       action:(SEL)action
                      bgColor:(UIColor *)bgColor {
    return [self buttonWithFrame:frame
                           title:title
                          target:target
                          action:action
                       textColor:[UIColor whiteColor]
                         bgColor:bgColor
                     borderColor:[UIColor whiteColor]];
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                    imageName:(NSString *)imageName
                       target:(id)target
                       action:(SEL)action {
    UIButton *button = [[self class] primaryButtonWithFrame:frame target:target action:action];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                       target:(id)target
                       action:(SEL)action {
    UIButton *button = [[self class] primaryButtonWithFrame:frame target:target action:action];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                    imageName:(NSString *)imageName
            selectedImageName:(NSString *)selectedImageName
                       target:(id)target
                       action:(SEL)action {
    UIButton *button = [[self class] buttonWithFrame:frame
                                           imageName:imageName target:target action:action];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                    imageName:(NSString *)imageName
         highlightedImageName:(NSString *)highlightedImageName
                       target:(id)target
                       action:(SEL)action {
    UIButton *button = [[self class] buttonWithFrame:frame
                                           imageName:imageName target:target action:action];
    [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    
    return button;
    
}

+ (UIButton *)primaryButtonWithFrame:(CGRect)frame target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - UILabel
+ (UILabel *)labelWithFrame:(CGRect)frame {
    return [self labelWithFrame:frame text:@""];
}

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    
    return label;
}

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)color {
    UILabel *label = [[self class] labelWithFrame:frame text:text];
    label.textColor = color;
    
    return label;
}

+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text
                  textColor:(UIColor *)color font:(UIFont *)font {
    UILabel *label = [[self class] labelWithFrame:frame text:text textColor:color];
    label.font = font;
    
    return label;
}

#pragma mark - UISCrollView
+ (UIScrollView *)scrollViewWithFrame:(CGRect)frame contentSize:(CGSize)contentSize {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.bouncesZoom = YES;
    scrollView.bounces = YES;
    scrollView.contentSize = contentSize;
    
    return scrollView;
}

@end
