//
//  HYBDiscoverController.m
//  BiaoGeIMProject
//
//  Created by ljy-335 on 14-10-31.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBDiscoverController.h"
#import "HYBHttpManager+Discover.h"
#import "HYBUserModel.h"
#import "HYBUserCell.h"

@interface HYBDiscoverController ()

@end

@implementation HYBDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发现";
    [_tableView setSeparatorColor:[UIColor colorWithWhite:0.7 alpha:1]];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [self addHeaderRefreshView];
    [self addFooterLoadMoreView];
    return;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_datasource.count == 0) {
        [self requestData];
    }
    return;
}

- (void)requestData {
    NSString *path = @"user/query";
    NSDictionary *params = @{@"pageIndex" : @(_currentPageIndex),
                             @"pageSize"  : @(10)};
    
    [ProgressHUD show:@"Loading..."];
    _httpRequest = [HYBHttpManager discoverWithPath:path params:params completion:^(NSArray *userModels) {
        if (userModels) {
            if (userModels.count != 0) {
                dispatch_async(kGlobalThread, ^{
                    if (_isRefreshing || _currentPageIndex == 1) {
                        [_datasource removeAllObjects];
                    }
                    [_datasource addObjectsFromArray:userModels];
                    
                    dispatch_async(kMainThread, ^{
                        [_tableView reloadData];
                        [self endRefreshOrLoadSuccess];
                    });
                });
            }
        } else {
            [ProgressHUD showError:@"Load error!"];
            [self endRefreshOrLoadSuccess];
        }
        [ProgressHUD dismiss];
    } errorBlock:^(NSError *error) {
        [ProgressHUD showError:kNetworkErrorMsg];
        [self endRefreshOrLoadSuccess];
    }];
    return;
}

- (void)beginRefreshHeaderView {
    [super beginRefreshHeaderView];
    
    _isRefreshing = YES;
    _isLoadingMore = NO;
    [self requestData];
    return;
}

- (void)beginFooterLoadMore {
    [super beginFooterLoadMore];
    
    _isRefreshing = NO;
    _isLoadingMore = YES;
    [self requestData];
    return;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HYBUserCellIdentifier";
    HYBUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HYBUserCell" owner:self options:nil] lastObject];
    
        UILabel *lineLabel = [HYBUIMaker labelWithFrame:CGRectMake(70, 59.5, kScreenWidth - 70, 0.5)];
        lineLabel.backgroundColor = kColorWithRGB(224, 224, 224);
        [cell.contentView addSubview:lineLabel];
    }
    
    if (indexPath.row < _datasource.count) {
        HYBUserModel *model = [_datasource objectAtIndex:indexPath.row];
        [cell configureCellWithModel:model];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end

