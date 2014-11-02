//
//  HYBXMPPManager.m
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBXMPPManager.h"
#import "FMDatabase.h"

@implementation HYBXMPPManager

/*!
 * @brief singleton method for creating the HYBXMPPManager object only once
 */
+ (HYBXMPPManager *)shared {
    static dispatch_once_t onceToken = 0;
    static HYBXMPPManager *sharedManger = nil;
    
    dispatch_once(&onceToken, ^{
        if (!sharedManger) {
            sharedManger = [[self alloc] init];
        }
    });
    
    return sharedManger;
}

/*!
 * @brief open the database accounding to the user id
 * @param userId the unique identifier of the database name
 * @return the opened database object
 */
- (FMDatabase *)databaseWithUserId:(NSString *)userId {
    userId = [userId uppercaseString];
    
    // if using the same database which is open,
    // then return the current _db object
    if ([_oldUserId isEqualToString:userId]) {
        if (_db && [_db goodConnection]) {
            return _db;
        }
    }
    
    // named the database's name with the userId which is unique.
    _oldUserId = [userId copy];
    NSString *path = [[NSString documentPath] stringByAppendingFormat:@"/%@.db", userId];
    
    // close the current database which will be not used currently
    [_db close];
    
    _db = [[FMDatabase alloc] initWithPath:path];
    
    if (![_db open]) {
        NSLog(@"open database error!");
        return nil;
    }
    
    return _db;
}

@end
