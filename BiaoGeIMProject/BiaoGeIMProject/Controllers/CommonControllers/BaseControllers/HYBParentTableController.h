//
//  HYBParentTableController.h
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBBaseController.h"

/*!
 * @brief Inherit from HYBBaseController, and append table view function.
 *
 * @author huangyibiao
 */
@interface HYBParentTableController : HYBBaseController <UITableViewDataSource, UITableViewDelegate> {
    @protected
    UITableView    *_tableView;
    NSMutableArray *_datasource;
}

- (instancetype)initWithStyle:(UITableViewStyle)style;
- (instancetype)initWithStyle:(UITableViewStyle)style keyboadAsBack:(BOOL)asBack;

@end
