//
//  HYBParentTableController.m
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBParentTableController.h"

@interface HYBParentTableController () {
    UITableViewStyle  _tableViewStyle;
}

@end

@implementation HYBParentTableController

- (instancetype)init {
    return [self initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self initWithStyle:style keyboadAsBack:NO];
}

- (instancetype)initWithStyle:(UITableViewStyle)style keyboadAsBack:(BOOL)asBack {
    if (self = [super initWithKeyboardScrollViewAsBackgroundView:asBack]) {
        _tableViewStyle = style;
        
        _datasource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // as back view
    [self configureTableView];
    
    if (_keyboardScrollView != nil) {
        [_keyboardScrollView addSubview:_tableView];
    } else {
        [self.view addSubview:_tableView];
    }
    
    return;
}

- (void)configureTableView {
    CGRect frame = CGRectMake(0, _originY, kScreenWidth, kScreenHeight - kNavigationBarHeight);
    _tableView = [[UITableView alloc] initWithFrame:frame style:_tableViewStyle];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
