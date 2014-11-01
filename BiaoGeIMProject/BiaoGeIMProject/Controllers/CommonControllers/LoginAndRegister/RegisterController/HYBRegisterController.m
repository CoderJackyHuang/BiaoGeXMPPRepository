//
//  HYBRegisterController.m
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBRegisterController.h"
#import "UIViewController+KNSemiModal.h"

@interface HYBRegisterController () {
    UITextField *_phoneTextField;
    UITextField *_passwordTextField;
    UIButton    *_registerButton;
    
    void (^_registerCompletion)();
}

@end

@implementation HYBRegisterController

- (instancetype)initWithCompletion:(void (^)())completion {
    if (self = [super initWithKeyboardScrollViewAsBackgroundView:YES]) {
        _registerCompletion = [completion copy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 这里不做验证处理
    UILabel *phoneLabel = [HYBUIMaker labelWithFrame:CGRectMake(20, 140, 70, 30) text:@"用户名："];
    [_keyboardScrollView addSubview:phoneLabel];
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    
    _phoneTextField = [HYBUIMaker textFieldWithFrame:CGRectMake(phoneLabel.rightX,
                                                                phoneLabel.originY,
                                                                kScreenWidth - phoneLabel.rightX - 20,
                                                                phoneLabel.height)
                                         placeholder:nil];
    _phoneTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _phoneTextField.layer.cornerRadius = 10.0;
    _phoneTextField.layer.borderWidth = 0.5;
    [_keyboardScrollView addSubview:_phoneTextField];
    
    UILabel *passwordLabel = [HYBUIMaker labelWithFrame:CGRectMake(20, phoneLabel.bottomY + 20, 70, 30) text:@"密   码："];
    [_keyboardScrollView addSubview:passwordLabel];
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    
    _passwordTextField = [HYBUIMaker textFieldWithFrame:CGRectMake(passwordLabel.rightX,
                                                                   passwordLabel.originY,
                                                                   kScreenWidth - passwordLabel.rightX - 20,
                                                                   passwordLabel.height)
                                            placeholder:nil
                                               security:YES];
    [_keyboardScrollView addSubview:_passwordTextField];
    _passwordTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _passwordTextField.layer.cornerRadius = 10.0;
    _passwordTextField.layer.borderWidth = 0.5;
    
    _registerButton = [HYBUIMaker buttonWithFrame:CGRectMake(10, _passwordTextField.bottomY + 30, kScreenWidth - 20, 40)
                                                  title:@"注册"
                                                 target:self
                                                 action:@selector(onRegisterClicked:)
                                                 inView:_keyboardScrollView];
    _registerButton.backgroundColor =  kColorWithRGB(231, 81, 82);
    _registerButton.layer.cornerRadius = 4;
    self.view.backgroundColor = kColorWithRGB(250, 250, 250);
    
    UIButton *cancelButton = [HYBUIMaker buttonWithFrame:CGRectMake(kScreenWidth - 40, -1, 41, 41)
                                                     title:@""
                                                    target:self
                                                    action:@selector(onCancelClicked)
                                                    inView:_keyboardScrollView];
    [cancelButton setImage:kImageWithName(@"playback_close") forState:UIControlStateNormal];
    return;
}

- (void)onRegisterClicked:(UIButton *)sender {
    if (kIsEmptyString(_phoneTextField.text) || kIsEmptyString(_passwordTextField.text)) {
        return;
    }
    NSString *path = @"user/register";
    NSDictionary *params = @{@"userName"        : _phoneTextField.text,
                             @"userPassword"    : _passwordTextField.text,
                             @"userNickname"    : _phoneTextField.text,
                             @"userDescription" : _phoneTextField.text};
    [ProgressHUD show:@"Registering..."];
    [HYBHttpManager registerWithPath:path params:params completion:^(BOOL isSuccess, NSString *errorMsg) {
        if (isSuccess) {
            [ProgressHUD dismiss];
            _registerCompletion();
        } else {
            [ProgressHUD showError:errorMsg ? errorMsg : @"Register fail!"];
        }
    } error:^(NSError *error) {
        [ProgressHUD showError:kNetworkErrorMsg];
    }];
    
    return;
}

- (void)onCancelClicked {
    _registerCompletion();
    return;
}

@end
