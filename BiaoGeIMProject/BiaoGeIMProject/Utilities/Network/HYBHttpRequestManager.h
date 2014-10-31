//
//  HYBHttpRequestManager.h
//  CloudShopping
//
//  Created by sixiaobo on 14-7-9.
//  Copyright (c) 2014年 com.Uni2uni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"

/*!
 * @brief 管理ASIHttpRequest对象的生命周期
 * @author huangyibiao
 */
@interface HYBHttpRequestManager : NSObject

@property (nonatomic, strong) ASIDownloadCache *downloadCache;

+ (HYBHttpRequestManager *)sharedRequestManager;

/*!
 * @brief 获取正在请求中的对象
 */
- (NSUInteger)requestCount;

/*!
 * @brief 添加ASIHttpRequest对象，用过管理其生命周期
 * @param request 需要交由HYBHttpRequestManager来管理的请求对象
 * @param urlStringKey 使用绝对网址作为key
 */
- (void)addRequest:(id)request withKey:(NSString *)urlStringKey;

/*!
 * @brief 根据指定的key清除请求对象的代理、取消请求并移除掉HYBHttpReuest对象
 * @param urlStringKey 绝对网址
 */
- (void)removeRequestWithKey:(NSString *)urlStringKey;

/*!
 * @brief 这里需要慎重，一旦调用，就会把所有的请求对象都移除掉
 */
- (void)removeAllRequest;

/*!
 * @brief 取消所有请求，并且移除
 */
- (void)cancelAllRequestAndRemove;

@end
