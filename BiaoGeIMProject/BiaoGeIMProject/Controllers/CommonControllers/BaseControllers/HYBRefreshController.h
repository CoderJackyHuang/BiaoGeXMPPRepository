//
//  HYBRefreshController.h
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBParentTableController.h"

/*!
 * @brief Inherit from HYBParentTableController, and append table view refresh and load more functions.
 *
 * @author huangyibiao
 */
@interface HYBRefreshController : HYBParentTableController {
    @protected
    NSUInteger _currentPageIndex;
    
    // default is NO
    BOOL       _isLoadingMore;
    // default is YES
    BOOL       _isRefreshing;
}

/*!
 * add refresh view in header view
 * add load more view in footer view
 */
- (void)addHeaderRefreshView;
- (void)addFooterLoadMoreView;

- (void)beginRefreshHeaderView;
- (void)beginFooterLoadMore;

- (void)endRefreshOrLoadSuccess;
- (void)endRefreshOrLoadFail;
@end
