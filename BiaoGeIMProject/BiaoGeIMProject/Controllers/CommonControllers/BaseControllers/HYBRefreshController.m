//
//  HYBRefreshController.m
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBRefreshController.h"
#import "MJRefresh.h"

@implementation HYBRefreshController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isLoadingMore = NO;
    _isRefreshing = YES;
    _currentPageIndex = 1;
    return;
}

- (void)addHeaderRefreshView {
    [_tableView addHeaderWithTarget:self action:@selector(beginRefreshHeaderView)];
    return;
}

- (void)addFooterLoadMoreView {
    [_tableView addFooterWithTarget:self action:@selector(beginFooterLoadMore)];
    return;
}

- (void)beginRefreshHeaderView {
    _currentPageIndex = 1;
    _isRefreshing = YES;
    _isLoadingMore = NO;
    // subclass should override
    return;
}

- (void)beginFooterLoadMore {
    // subclass should override
    _isLoadingMore = YES;
    _isRefreshing = NO;
    return;
}

- (void)endRefreshHeaderViewSuccess {
    [_tableView headerEndRefreshing];
    
    _currentPageIndex = 1;
    _isRefreshing = NO;
    return;
}

- (void)endRefreshHeaderViewFail {
    [_tableView headerEndRefreshing];
    _isRefreshing = NO;
    return;
}

- (void)endFooterLoadMoreSuccess {
    [_tableView footerEndRefreshing];
    
    _currentPageIndex++;
    _isLoadingMore = NO;
    return;
}

- (void)endFooterLoadMoreFail {
    [_tableView footerEndRefreshing];
    _isLoadingMore = NO;
    return;
}

- (void)endRefreshOrLoadSuccess {
    if (_isRefreshing) {
        [self endRefreshHeaderViewSuccess];
    } else if (_isLoadingMore) {
        [self endFooterLoadMoreSuccess];
    }
    return;
}

- (void)endRefreshOrLoadFail {
    if (_isRefreshing) {
        [self endRefreshHeaderViewFail];
    } else if (_isLoadingMore) {
        [self endFooterLoadMoreFail];
    }
    return;

}

@end
