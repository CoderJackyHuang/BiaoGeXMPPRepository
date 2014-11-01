//
//  HYBFriendController.m
//  BiaoGeIMProject
//
//  Created by ljy-335 on 14-10-31.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBFriendController.h"
#import "HYBLoginController.h"

@interface HYBFriendController ()

@end

@implementation HYBFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addRightButtonWithTitle:@"login" action:@selector(onLogin)];
}

- (void)onLogin {
    HYBLoginController *login = [[HYBLoginController alloc] init];
    [login loginWithPresentController:self completion:^(BOOL isLoginSuccess) {
        if (isLoginSuccess) {
            
        }
    }];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
