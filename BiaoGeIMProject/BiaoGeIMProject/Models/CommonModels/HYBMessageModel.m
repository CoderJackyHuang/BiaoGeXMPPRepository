//
//  HYBMessageModel.m
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBMessageModel.h"

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

@end
