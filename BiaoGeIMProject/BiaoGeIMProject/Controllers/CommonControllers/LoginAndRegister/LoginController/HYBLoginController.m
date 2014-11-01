//
//  HYBLoginController.m
//  BiaoGeIMProject
//
//  Created by ljy-335 on 14-10-31.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBLoginController.h"
#import "NSString+Common.h"
#import "HYBRegisterController.h"
#import "UIViewController+KNSemiModal.h"

@interface HYBLoginController () {
    UITextField *_phoneTextField;
    UITextField *_passwordTextField;
    HYBLoginCompletion _loginCompletion;
    HYBRegisterController *_registerController;
}

@end

@implementation HYBLoginController

- (instancetype)init {
    if (self = [super initWithKeyboardScrollViewAsBackgroundView:YES]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用户登录";
    [self addLeftButtonWithTitle:@"返回" action:@selector(onBackButtonClicked)];
    [self addRightButtonWithTitle:@"注册" action:@selector(onRegisterButtonClicked)];
    
    /// 这里不做验证处理
    UILabel *phoneLabel = [HYBUIMaker labelWithFrame:CGRectMake(20, 100, 70, 30) text:@"用户名："];
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
    
    UIButton *loginButton = [HYBUIMaker buttonWithFrame:CGRectMake(10, _passwordTextField.bottomY + 30, kScreenWidth - 20, 40)
                                                  title:@"登录"
                                                 target:self
                                                 action:@selector(onLoginButtonClicked:)
                                                 inView:_keyboardScrollView];
    loginButton.backgroundColor =  kColorWithRGB(231, 81, 82);
    loginButton.layer.cornerRadius = 4;
    self.view.backgroundColor = kColorWithRGB(250, 250, 250);
    return;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _phoneTextField.text = [kUserDefaults objectForKey:kUserLoginNameKey];
    _passwordTextField.text = [kUserDefaults objectForKey:kUserPasswordKey];
    return;
}

- (void)onLoginButtonClicked:(UIButton *)sender {
    if (kIsEmptyString(_passwordTextField.text) || kIsEmptyString(_phoneTextField.text)) {
        return;
    }
    
    NSString *path = @"user/login";
    NSDictionary *params = @{@"userName"     : _phoneTextField.text,
                             @"userPassword" : _passwordTextField.text,
                             @"versionInfo"  : [NSString appLocalVersion],
                             @"deviceInfo"   : [[[UIDevice currentDevice] systemName] stringByAppendingString:[[UIDevice currentDevice] systemVersion]]};
    
    // login request here
    [ProgressHUD show:@"Logining.."];
    [HYBHttpManager loginWithPath:path params:params completion:^(BOOL isSuccess) {
        if (isSuccess) {
            [ProgressHUD dismiss];
            if (_loginCompletion) {
                _loginCompletion(isSuccess);
            }
        } else {
            [ProgressHUD showError:kLoadDataErrorMsg];
        }
    } error:^(NSError *error) {
        [ProgressHUD showError:kNetworkErrorMsg];
    }];
    
    return;
}

- (void)onBackButtonClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
    return;
}

#pragma mark - Register
- (void)onRegisterButtonClicked {
    // must as member variable, otherwise will be release forward
    kWeakObject(self);
    __weak typeof(_passwordTextField) pwdTextField = _passwordTextField;
    __weak typeof(_phoneTextField) phoneTextField = _phoneTextField;
    _registerController = [[HYBRegisterController alloc] initWithCompletion:^{
        phoneTextField.text = [kUserDefaults objectForKey:kUserLoginNameKey];
        pwdTextField.text = [kUserDefaults objectForKey:kUserPasswordKey];
        
        [weakObject dismissSemiModalView];
    }];
    _registerController.view.height = kScreenHeight - 150;
    [self presentSemiViewController:_registerController];
    return;
}

- (void)loginWithPresentController:(UIViewController *)presentController completion:(HYBLoginCompletion)completion {
    _loginCompletion = [completion copy];
    
    UINavigationController *nav = self.navigationController;
    if (nav == nil) {
        nav = [[UINavigationController alloc] initWithRootViewController:self];
    }
    [presentController presentViewController:nav animated:YES completion:^{
        [_phoneTextField becomeFirstResponder];
    }];
    return;
}

@end
