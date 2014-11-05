//
//  HYBBaseUserModel.h
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/5.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBBaseModel.h"

#define kUserIdKey          @"userId"
#define kUserNicknameKey    @"userNickname"
#define kUserDescriptionKey @"userDescription"
#define kUserHeadKey        @"userHead"
#define kUserRoomFlagKey    @"roomFlag"
#define kUserMessagesKey    @"messages"
#define kUserTimeCreateKey  @"timeCreate"


/*!
 * @brief the base model of the user information
 * @author huangyibiao
 */
@interface HYBBaseUserModel : HYBBaseModel

@property (nonatomic, copy)   NSString *userHead;
@property (nonatomic, copy)   NSString *userId;
@property (nonatomic, copy)   NSString *userNickname;
@property (nonatomic, copy)   NSString *userDescription;
@property (nonatomic, strong) NSDate   *timeCreate;
// 0：朋友；1:永久房间；2:临时房间
@property (nonatomic, strong) NSNumber *roomFlag;
// 0：朋友；1:永久房间；2:临时房间
@property (nonatomic, strong) NSNumber *messages;

///
/// 数据库增删改查
///

+ (BOOL)saveUser:(HYBBaseUserModel *)user;
+ (BOOL)saveRoom:(HYBBaseUserModel *)user;

+ (BOOL)deleteUserWithUserId:(NSString *)userId;
+ (BOOL)updateUser:(HYBBaseUserModel *)user;
+ (BOOL)isUserExists:(NSString *)userId;
+ (HYBBaseUserModel *)userWithUserId:(NSString *)userId;

+ (NSMutableArray *)fetchAllFriends;
+ (NSMutableArray *)fetchAllRooms;

// 对象转换为字典
- (NSDictionary *)toDictionary;
+ (HYBBaseUserModel *)userFromDictionary:(NSDictionary *)userDict;
+ (NSString *)headImageWithUserId:(NSString *)userId;

@end
