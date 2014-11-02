//
//  HYBXMPPManager.h
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;

@interface HYBXMPPManager : NSObject {
    @private
    FMDatabase *_db;
    NSString   *_oldUserId;
}

/*!
 * @brief singleton method for creating the HYBXMPPManager object only once
 */
+ (HYBXMPPManager *)shared;

/*!
 * @brief open the database accounding to the user id
 * @param userId the unique identifier of the database name
 * @return the opened database object
 */
- (FMDatabase *)databaseWithUserId:(NSString *)userId;

@end
