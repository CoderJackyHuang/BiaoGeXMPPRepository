//
//  HYBBaseUserModel.m
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/5.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBBaseUserModel.h"
#import "FMDatabase.h"
#import "HYBXMPPManager.h"

@implementation HYBBaseUserModel

///
/// 数据库增删改查
///

+ (BOOL)saveUser:(HYBBaseUserModel *)user {
    NSString *myUserId = [kUserDefaults objectForKey:kUserIdKey];
    FMDatabase *db = [[HYBXMPPManager shared] databaseWithUserId:myUserId];
    [self isTableExistInDatabase:db userId:myUserId];
    
    user.roomFlag = [NSNumber numberWithInt:0];
    user.timeCreate = [NSDate date];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO 'friend' ('userId','userNickname','userDescription','userHead','roomFlag','timeCreate','messages') VALUES (?,?,?,?,?,?,0)"];
    BOOL worked = [db executeUpdate:sql,
                   user.userId,
                   user.userNickname,
                   user.userDescription,
                   [self headImageWithUserId:user.userId],
                   user.roomFlag,
                   user.timeCreate];
    return worked;

}

+ (BOOL)saveRoom:(HYBBaseUserModel *)user {
    NSString *myUserId = [kUserDefaults objectForKey:kUserIdKey];
    FMDatabase *db = [[HYBXMPPManager shared] databaseWithUserId:myUserId];
    [self isTableExistInDatabase:db userId:myUserId];
    
    user.roomFlag = [NSNumber numberWithInt:1];
    user.timeCreate = [NSDate date];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO 'friend' ('userId','userNickname','userDescription','userHead','roomFlag','timeCreate','messages') VALUES (?,?,?,?,?,?,0)"];
    BOOL worked = [db executeUpdate:sql,
                   user.userId,
                   user.userNickname,
                   user.userDescription,
                   [self headImageWithUserId:user.userId],
                   user.roomFlag,
                   user.timeCreate];
    return worked;
}

+ (BOOL)deleteUserWithUserId:(NSString *)userId {
    return NO;
}

+ (BOOL)updateUser:(HYBBaseUserModel *)user {
    return NO;
}

+ (BOOL)isUserExists:(NSString *)userId {
    NSString *myUserId = [kUserDefaults objectForKey:kUserIdKey];
    FMDatabase* db = [[HYBXMPPManager shared] databaseWithUserId:myUserId];
    [self isTableExistInDatabase:db userId:myUserId];
    
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select count(*) from friend where userId=?"],userId];
    while ([rs next]) {
        int count= [rs intForColumnIndex:0];
        
        if (count != 0) {
            [rs close];
            return YES;
        } else {
            [rs close];
            return NO;
        }
    };
    
    [rs close];
    return YES;

}

+ (HYBBaseUserModel *)userWithUserId:(NSString *)userId {
    NSString *myUserId = [kUserDefaults objectForKey:kUserIdKey];
    FMDatabase *db = [[HYBXMPPManager shared] databaseWithUserId:myUserId];
    [self isTableExistInDatabase:db userId:myUserId];
    
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from friend where userId = ?"], userId];
    while ([rs next]) {
        HYBBaseUserModel *model = [[HYBBaseUserModel alloc] init];
        model.userId = [rs stringForColumn:kUserIdKey];
        model.userHead = [rs stringForColumn:kUserHeadKey];
        model.userDescription = [rs stringForColumn:kUserDescriptionKey];
        model.userNickname = [rs stringForColumn:kUserNicknameKey];
        model.roomFlag = [rs objectForColumnName:kUserRoomFlagKey];
        model.messages = [rs objectForColumnName:kUserMessagesKey];
        model.timeCreate = [rs dateForColumn:kUserTimeCreateKey];
        
        [rs close];
        return model;
    }
    
    [rs close];
    return nil;
}

+ (NSMutableArray *)fetchAllFriends {
    NSMutableArray *friendsArray = [[NSMutableArray alloc] init];
    NSString *userId = [kUserDefaults objectForKey:kUserIdKey];
    FMDatabase *db = [[HYBXMPPManager shared] databaseWithUserId:userId];
    [self isTableExistInDatabase:db userId:userId];
    
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from friend order by timeCreate desc"]];
    while ([rs next]) {
        HYBBaseUserModel *model = [[HYBBaseUserModel alloc] init];
        model.userId = [rs stringForColumn:kUserIdKey];
        model.userHead = [rs stringForColumn:kUserHeadKey];
        model.userDescription = [rs stringForColumn:kUserDescriptionKey];
        model.userNickname = [rs stringForColumn:kUserNicknameKey];
        model.roomFlag = [rs objectForColumnName:kUserRoomFlagKey];
        model.messages = [rs objectForColumnName:kUserMessagesKey];
        model.timeCreate = [rs dateForColumn:kUserTimeCreateKey];
        
        [friendsArray addObject:model];
    }
    
    [rs close];
    return friendsArray;

}

+ (NSMutableArray *)fetchAllRooms {
    NSMutableArray *roomsArray = [[NSMutableArray alloc] init];
    NSString *userId = [kUserDefaults objectForKey:kUserIdKey];
    FMDatabase *db = [[HYBXMPPManager shared] databaseWithUserId:userId];
    [self isTableExistInDatabase:db userId:userId];
    
    FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"select * from friend where roomFlag=1 order by timeCreate desc"]];
    while ([rs next]) {
        HYBBaseUserModel *model = [[HYBBaseUserModel alloc] init];
        model.userId = [rs stringForColumn:kUserIdKey];
        model.userHead = [rs stringForColumn:kUserHeadKey];
        model.userDescription = [rs stringForColumn:kUserDescriptionKey];
        model.userNickname = [rs stringForColumn:kUserNicknameKey];
        model.roomFlag = [rs objectForColumnName:kUserRoomFlagKey];
        model.messages = [rs objectForColumnName:kUserMessagesKey];
        model.timeCreate = [rs dateForColumn:kUserTimeCreateKey];
    
        [roomsArray addObject:model];
    }
    
    [rs close];
    return roomsArray;
}

// 对象转换为字典
- (NSDictionary *)toDictionary {
    return  @{kUserIdKey          : self.userId,
              kUserNicknameKey    : self.userNickname,
              kUserDescriptionKey : self.userDescription,
              kUserHeadKey        : self.userHead,
              kUserMessagesKey    : self.messages,
              kUserRoomFlagKey    : self.roomFlag};
}

+ (HYBBaseUserModel *)userFromDictionary:(NSDictionary *)userDict {
    HYBBaseUserModel *model = [[HYBBaseUserModel alloc] init];
    model.userId = userDict[kUserIdKey];
    model.userHead = userDict[kUserHeadKey];
    model.userDescription = userDict[kUserMessagesKey];
    model.userNickname = userDict[kUserNicknameKey];
    model.messages = userDict[kUserMessagesKey];
    model.timeCreate = userDict[kUserTimeCreateKey];
    model.roomFlag = userDict[kUserRoomFlagKey];
    
    return model;
}


+ (NSString *)headImageWithUserId:(NSString *)userId {
    NSUInteger len = [userId length];
    
    if (len > 0) {
        for (NSUInteger i = 0; i < userId.length; i++) {
            unichar ch = [userId characterAtIndex:i];
            len += ch;
        }
        
        len = fmod(len, 18);
    }
    
    return [NSString stringWithFormat:@"head_temp%d.jpg", (int)len];
}

///
/// private
///
+ (BOOL)isTableExistInDatabase:(FMDatabase *)db userId:(NSString *)userId {
    NSString *sql = [NSString stringWithFormat:@"CREATE  TABLE  IF NOT EXISTS 'friend' ('userId' VARCHAR PRIMARY KEY  NOT NULL  UNIQUE , 'userNickname' VARCHAR, 'userDescription' VARCHAR, 'userHead' VARCHAR,'roomFlag' INT, 'content' VARCHAR,'type' INTEGER,'timeSend' DATETIME,'timeCreate' DATETIME,'messages' INTEGER)"];
    
    BOOL worked = [db executeUpdate:sql];
    return worked;
}


@end
