//
//  HYBMessageModel.h
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMResultSet;

typedef NS_ENUM(NSUInteger, HYBMessageType) {
    kMessageTypeText = 1,
    kMessageTypeImage = 2,
    kMessageTypeVoice = 3,
    kMessageTypeLocation = 4,
    kMessageTypeGIF = 5
};

/*!
 * @brief 消息模型
 *
 * @author huangyibiao
 */
@interface HYBMessageModel : NSObject

@property (nonatomic, strong) NSNumber *messageNo;  // 序列号，数值型
@property (nonatomic, strong) NSNumber *type;       // 消息类型
@property (nonatomic, strong) NSString *messageId;  // 消息标识号，字符串
@property (nonatomic, strong) NSString *fromUserId; // 源
@property (nonatomic, strong) NSString *toUserId;   // 目标
@property (nonatomic, strong) NSString *content;    // 内容
@property (nonatomic, strong) NSString *fileName;   // 文件名
@property (nonatomic, strong) NSNumber *fileSize;   // 文件尺寸
@property (nonatomic, strong) NSNumber *timeLen;    // 录音时长
@property (nonatomic, strong) NSNumber *isSend;     // 是否已送达
@property (nonatomic, strong) NSNumber *isRead;     // 是否已读
@property (nonatomic, strong) NSNumber *location_x; // 位置经度
@property (nonatomic, strong) NSNumber *location_y; // 位置纬度
@property (nonatomic, strong) NSDate   *timeSend;   // 发送的时间
@property (nonatomic, strong) NSDate   *timeReceive;// 收到的时间
@property (nonatomic, strong) NSData   *fileData;   // 文件内容
@property (nonatomic, assign) BOOL     isGroup;     // 是否群聊
@property (nonatomic, assign) float               progress;
@property (nonatomic, assign) int                 index;

/*!
 * @brief get the user message location (latitude and longtitude)
 */
- (CGPoint)location;

/*!
 * @brief convert the model object to a dictionary and return the dictionary
 * @return the dictionary converted by current model object
 */
- (NSDictionary *)toDictionary;

/*!
 * @brief get the last send or receive message content type, values is only being [图片],[语音],[表情], content plain text
 * @return one of [图片],[语音],[表情],content plain text
 */
- (NSString *)lastContentType;

@end
