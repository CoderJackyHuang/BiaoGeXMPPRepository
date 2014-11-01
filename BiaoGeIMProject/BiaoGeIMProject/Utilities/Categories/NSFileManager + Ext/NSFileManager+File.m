
//  NSFileManager+File.m
//  CloudShopping
//
//  Created by ljy-335 on 14-8-4.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

#import "NSFileManager+File.h"

@implementation NSFileManager (File)

/*!
 * @brief 判断文件是否存在于沙盒中
 * @param fileName 文件路径名
 * @return 返回YES表示存在，返回NO表示不存在
 */
- (BOOL)isFileExists:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}

/*!
 * @brief 判断文件是否超时
 * @param filePath 文件路径名
 * @param timeout 限制的超时时间，单位为秒
 * @return 返回YES表示超时，返回NO表示未超时
 */
- (BOOL)isFile:(NSString *)filePath timeout:(NSTimeInterval)timeout {
    if ([[NSFileManager defaultManager] isFileExists:filePath]) {
        NSError *error = nil;
       NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath
                                                                                   error:&error];
        if (error) {
            return YES;
        }
        if ([attributes isKindOfClass:[NSDictionary class]] && attributes) {
            NSString *createDate = [attributes objectForKey:@"NSFileModificationDate"];
            createDate = [NSString stringWithFormat:@"%@", createDate];
            if (createDate.length >= 19) {
                createDate = [createDate substringToIndex:19];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";

                NSDate *sinceDate = [formatter dateFromString:createDate];
                NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:sinceDate];
                BOOL isTimeOut = (long)interval > timeout;
                return isTimeOut;
            }
        }
    }
    return YES;
}

/*!
 * @brief 根据路径获取文件的大小
 * @param filePath 文件路径名
 * @return 文件的大小
 */
- (long)fileSizeWithPath:(NSString *)path {
    NSError *error = nil;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                error:&error];
    if (error) {
        return 0;
    }
    NSString *fileSize = [NSString stringWithFormat:@"%@", [attributes objectForKey:@"NSFileSize"]];
    return fileSize.integerValue;
}

@end
