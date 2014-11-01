//
//  HYBUserCell.h
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "StyledTableViewCell.h"

@class HYBUserModel;

/*!
 * @brief user information cell
 * @author huangyibiao
 */
@interface HYBUserCell : StyledTableViewCell

- (void)configureCellWithModel:(HYBUserModel *)model;
- (void)updateBadgeNumber:(NSUInteger)badgeNumber;

@end
