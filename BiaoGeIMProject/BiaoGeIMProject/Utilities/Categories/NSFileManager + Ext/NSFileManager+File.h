//
//  NSFileManager+File.h
//  CloudShopping
//
//  Created by ljy-335 on 14-8-4.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @brief NSFileManager关于文件操作的扩展
 * @author huangyibiao
 */
@interface NSFileManager (File)

/*!
 * @brief 判断文件是否存在于沙盒中
 * @param filePath 文件路径名
 * @return 返回YES表示存在，返回NO表示不存在
 */
- (BOOL)isFileExists:(NSString *)filePath;

/*!
 * @brief 判断文件是否超时
 * @param filePath 文件路径名
 * @param timeout 限制的超时时间，单位为秒
 * @return 返回YES表示超时，返回NO表示未超时
 */
- (BOOL)isFile:(NSString *)filePath timeout:(NSTimeInterval)timeout;

/*!
 * @brief 根据路径获取文件的大小
 * @param filePath 文件路径名
 * @return 文件的大小
 */
- (long)fileSizeWithPath:(NSString *)path;

@end
