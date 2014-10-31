//
//  ViewController.m
//  BiaoGeIMProject
//
//  Created by ljy-335 on 14-10-31.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBRootController.h"

#import "HYBMessageController.h"
#import "HYBFriendController.h"
#import "HYBDiscoverController.h"
#import "HYBGroupChatController.h"
#import "HYBLoginController.h"

@interface HYBRootController ()

@end


@implementation HYBRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HYBMessageController *msgController = [[HYBMessageController alloc] init];
    UINavigationController *msgNav = [[UINavigationController alloc] initWithRootViewController:msgController];
    msgNav.tabBarItem.title = @"消息";
    msgNav.tabBarItem.image = [UIImage imageNamed:@"tabbar_contacts"];
    msgNav.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    HYBFriendController *friendController = [[HYBFriendController alloc] init];
    UINavigationController *friendNav = [[UINavigationController alloc] initWithRootViewController:friendController];
    friendNav.tabBarItem.title = @"朋友";
    friendNav.tabBarItem.image = [UIImage imageNamed:@"tabbar_me"];
    friendNav.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    HYBDiscoverController *discoverController = [[HYBDiscoverController alloc] init];
    UINavigationController *discoverNav = [[UINavigationController alloc] initWithRootViewController:discoverController];
    discoverNav.tabBarItem.title = @"发现";
    discoverNav.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    discoverNav.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    HYBGroupChatController *groupChatController = [[HYBGroupChatController alloc] init];
    UINavigationController *groupChatNav = [[UINavigationController alloc] initWithRootViewController:groupChatController];
    groupChatNav.tabBarItem.title = @"群聊";
    groupChatNav.tabBarItem.image = [UIImage imageNamed:@"tabbar_mainframe"];
    groupChatNav.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    self.viewControllers = @[msgNav, friendNav, discoverNav, groupChatNav];
    
    return;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    return;
}

@end
