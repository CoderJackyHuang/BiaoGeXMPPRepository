//
//  HYBMessageModel.m
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBMessageModel.h"
#import "FMDatabase.h"
#import "HYBXMPPManager.h"
#import "NSData+XMPP.h"
#import "HYBUserModel.h"

#define kMessageTypeField @"type"
#define kMessageFromUserIdField @"fromUserId"
#define kMessageToUserIdField @"toUserId"
#define kMessageContentField @"content"
#define kMessageIdField @"messageId"
#define kMessageNoField @"messageNo"
#define kMessageTimeSendField @"timeSend"
#define kMessageTimeReceiveField @"timeReceive"
#define kMessageFileDataField @"fileData"
#define kMessageFileNameField @"fileName"
#define kMessageLocation_xField @"location_x"
#define kMessageLocation_yField @"location_y"
#define kMessageTimeLenField @"timeLen"
#define kMessageIsSendField @"isSend"
#define kMessageIsReadField @"isRead"
#define kMessageFileSizeField @"fileSize"


@implementation HYBMessageModel

/*!
 * @brief get the user message location (latitude and longtitude)
 */
- (CGPoint)location {
    return CGPointMake(_location_x.floatValue, _location_y.floatValue);
}

/*!
 * @brief convert the model object to a dictionary and return the dictionary
 * @return the dictionary converted by current model object
 */
- (NSDictionary *)toDictionary {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:_fromUserId forKey:kMessageFromUserIdField];
    [dict setObject:_toUserId forKey:kMessageToUserIdField];
    [dict setObject:_content forKey:kMessageContentField];
    [dict setObject:[formatter stringFromDate:_timeSend] forKey:kMessageTimeSendField];
    [dict setObject:[formatter stringFromDate:_timeReceive] forKey:kMessageTimeReceiveField];
    [dict setObject:_type forKey:kMessageTypeField];
    [dict setObject:_fileData forKey:kMessageFileDataField];
    [dict setObject:_fileName forKey:kMessageFileNameField];
    [dict setObject:_fileSize forKey:kMessageFileSizeField];
    [dict setObject:_isSend forKey:kMessageIsSendField];
    [dict setObject:_isRead forKey:kMessageIsReadField];
    [dict setObject:_timeLen forKey:kMessageTimeLenField];
    [dict setObject:_location_x forKey:kMessageLocation_xField];
    [dict setObject:_location_y forKey:kMessageLocation_yField];
    return dict;
}

/*!
 * @brief convert the dictionary values to the model object properties
 */
- (void)fromDictionary:(NSDictionary *)dict {
    if (dict == nil) {
        dict = [self toDictionary];
    }
    
    self.fromUserId = dict[kMessageFromUserIdField];
    self.toUserId = dict[kMessageToUserIdField];
    self.content = dict[kMessageContentField];
    self.timeSend = dict[kMessageTimeSendField];
    self.timeReceive = dict[kMessageTimeReceiveField];
    self.type = dict[kMessageTypeField];
    self.fileData = dict[kMessageFileDataField];
    self.fileName = dict[kMessageFileNameField];
    self.fileSize = dict[kMessageFileSizeField];
    self.isSend = dict[kMessageIsSendField];
    self.isRead = dict[kMessageIsReadField];
    self.timeLen = dict[kMessageTimeLenField];
    self.location_x = dict[kMessageLocation_xField];
    self.location_y = dict[kMessageLocation_yField];
    return;
}

/*!
 * @brief get the last send or receive message content type, values is only being [图片],[语音],[表情], content plain text
 * @return one of [图片],[语音],[表情],content plain text
 */
- (NSString *)lastContentType {
    NSString *contentType = @"";
    switch (self.type.integerValue) {
        case kMessageTypeImage:
            contentType = @"[图片]";
            break;
            case kMessageTypeGIF:
            contentType = @"[表情]";
            break;
            case kMessageTypeVoice:
            contentType = @"[语音]";
            break;
        default:
            contentType = self.content;
            break;
    }
    
    return contentType;
}

/*!
 * @brief save the current model object to the database
 * @return NO is saving fail and YES is saving success.
 */
- (BOOL)saveToDatabase {
    NSString *myUserId = [kUserDefaults objectForKey:kUserIdKey];
    
    NSString *toUserId = self.fromUserId;
    if (![self.toUserId isEqualToString:myUserId]) {
        toUserId = self.toUserId;
    }
    
    return [self saveMessageFromUserId:myUserId toTable:toUserId];
}

/*!
 * @brief save the message to the table
 * @param fromUserId the userId of the message sent from
 * @param tableName saving the message to the table
 */
- (BOOL)saveMessageFromUserId:(NSString *)fromUserId toTable:(NSString *)tableName {
    if (kIsEmptyString(tableName)) {
        return NO;
    }
    
    // toDatabaseName is userID
    FMDatabase *db = [[HYBXMPPManager shared] databaseWithUserId:tableName];
    
    NSString *sql = [NSString stringWithFormat:@"CREATE  TABLE IF NOT EXISTS 'msg_%@' ('messageNo' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL  UNIQUE , 'fromUserId' VARCHAR, 'toUserId' VARCHAR, 'content' VARCHAR, 'timeSend' DATETIME,'timeReceive' DATETIME,'type' INTEGER, 'messageId' VARCHAR, 'fileData' VARCHAR, 'fileName' VARCHAR,'fileSize' INTEGER,'location_x' INTEGER,'location_y' INTEGER,'timeLen' INTEGER,'isRead' INTEGER,'isSend' INTEGER )", tableName];
    
    BOOL worked = [db executeUpdate:sql];
    if (!worked) {
        return NO;
    }

    if (kIsEmptyString(self.messageId)) {
        self.messageId = [NSString UUID];
    }
    
    sql = [NSString stringWithFormat:@"INSERT INTO msg_%@ (fromUserId,toUserId,content,type,messageId,timeSend,timeReceive,fileData,fileName,fileSize,location_x,location_y,timeLen,isRead,isSend) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", tableName];
    
    worked = [db executeUpdate:sql,
              self.fromUserId,
              self.toUserId,
              self.content,
              self.type,
              self.messageId,
              self.timeSend,
              self.timeReceive,
              [self.fileData xmpp_base64Encoded],
              self.fileName,
              self.fileSize,
              self.location_x,
              self.location_y,
              self.timeLen,
              self.isRead,
              self.isSend];
    worked = [db executeUpdate:[NSString stringWithFormat:@"update friend set content=?,type=?,timeSend=?,newMsgs=newMsgs+1 where userId=?"],
              [self lastContentType],
              self.type,
              self.timeSend,
              tableName];
    // 发送全局通知
    NSDictionary *userInfo = @{@"newMsg" : self};
    kPostNotificationWithName(kXMPPNewMsgNotifiction, userInfo);
    
    [db close];
    db = nil;
    
    return worked;
}

/*!
 * @brief fetch recent chat records from the database, seperated by page index
 * @param pageIndex the index of page
 * @return the list of the chat records of the user
 */
+ (NSMutableArray *)fetchRecentChatWithPageIndex:(NSUInteger)pageIndex {
    NSString *userId = [kUserDefaults objectForKey:kUserIdKey];
    FMDatabase *db = [[HYBXMPPManager shared] databaseWithUserId:userId];
    
    NSMutableArray *messageList = [[NSMutableArray alloc] init];
    
    NSString *sql = [NSString stringWithFormat:@"select * from friend where length(content)>0 order by timeSend desc limit ?*20,20"];
    FMResultSet *rs = [db executeQuery:sql, @(pageIndex)];
    
    while ([rs next]) {
        HYBMessageModel *messageModel = [[HYBMessageModel alloc] init];
        messageModel.content = [rs stringForColumn:kMessageContentField];
        messageModel.type = [rs objectForColumnName:kMessageTypeField];
        messageModel.timeSend = [rs dateForColumn:kMessageTimeSendField];
        messageModel.fromUserId = [rs stringForColumn:kUserIdKey];
        messageModel.toUserId = userId;
//        
//        HYBUserModel *userModel = [[HYBUserModel alloc] init];
//        [userModel setUserId:[rs stringForColumn:kUserIdKey]];
//        [userModel setUserNickname:[rs stringForColumn:kUserNicknameKey]];
//        [userModel setUserHead:[rs stringForColumn:kUserHeadImageKey]];
//        [userModel setUserDescription:[rs stringForColumn:kUserDescriptionKey]];
//        [userModel setRoomFlag:[rs objectForColumnName:kUserRoomFlagKey]];
//        
//        JXMsgAndUserObject *unionObject=[JXMsgAndUserObject unionWithMessage:p andUser:user ];
//        [messageList addObject:unionObject];
    }
 
    }
}

@end
