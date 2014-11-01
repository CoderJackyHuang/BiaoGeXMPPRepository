//
//  HYBBaseController.m
//  BiaoGeIMProject
//
//  Created by ljy-335 on 14-10-31.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBBaseController.h"

@interface HYBBaseController () <HYBKeyboardScrollViewDelegate> {
    BOOL _isKeyboardScrollViewAsBackgroundView;
}

@end

@implementation HYBBaseController

- (instancetype)initWithKeyboardScrollViewAsBackgroundView:(BOOL)asBackgroundView {
    if (self = [super init]) {
        _isKeyboardScrollViewAsBackgroundView = asBackgroundView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _originY = 0.0;
    
    if (_isKeyboardScrollViewAsBackgroundView) {
        CGRect frame = CGRectMake(0, _originY, kScreenWidth, kScreenHeight - kNavigationBarHeight);
        _keyboardScrollView = [[HYBKeyboardScrollView alloc] initWithFrame:frame];
        _keyboardScrollView.keyboardHideDelegate = self;
        [self.view addSubview:_keyboardScrollView];
    }
    
    self.navigationController.navigationBar.tintColor = kColorWithRGB(225, 225, 225);
    self.navigationController.navigationBar.barTintColor = kColorWithRGB(225, 225, 225);
    return;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    return;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_httpRequest cancelRequest];
    return;
}

- (void)addLeftButtonWithTitle:(NSString *)title action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:action];
    item.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = item;
    return;
}

- (void)addRightButtonWithTitle:(NSString *)title action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:action];
    item.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = item;
    return;
}

#pragma mark - HYBKeyboardScrollViewDelegate
- (void)keyboardWillHide {
    if (_keyboardScrollView.iskeyboardShown) {
        [_keyboardScrollView setContentOffset:CGPointZero animated:YES];
    }
    return;
}

@end
