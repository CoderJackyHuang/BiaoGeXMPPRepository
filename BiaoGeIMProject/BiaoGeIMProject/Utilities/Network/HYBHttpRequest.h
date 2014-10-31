//
//  HYBHttpRequest.h
//  BiaoGeIMProject
//
//  Created by ljy-335 on 14-10-31.
//  Copyright (c) 2014年 edu. All rights reserved.
//


#import "ASIFormDataRequest.h"
#import "ASIDownloadCache.h"

// downloadData是返回的数据，如果出错，会把错误放到error中，否则error为nil，可通过error参数
// 判断是否出错
typedef void(^HYBResultBlock)(NSData *downloadData, NSError *error);

//
// HYBRequestType枚举用于指定请求类型
typedef NS_ENUM(NSUInteger, HYBRequestType) {
    kTypePost = 1 << 1,  // POST请求
    kTypeGet  = 1 << 2   // GET请求
};

// 网络请求异常枚举
typedef NS_ENUM(NSUInteger, HYBErrorType) {
    kErrorTypeNone = 1 << 2,                // 没有异常
    kErrorTypeTimeOut = 1 << 3,             // 网络请求超时
    kErrorTypeNetworkUnavialable = 1 << 4,  // 网络不可用
    kErrorTypeOther = 1 << 5                // 其它错误状态
};

/*!
 * @brief 网络请求类，继承于ASIFormDataRequest
 * @author huangyibiao
 */
@interface HYBHttpRequest : ASIFormDataRequest

// 请求回调block，成功或者失败都会回调此block，通过error参数判断是否成功
@property (nonatomic, copy)   HYBResultBlock resultBlock;
// 下载完成后的数据
@property (nonatomic, strong) NSMutableData  *downloadData;
@property (nonatomic, assign) HYBRequestType requestType;
@property (nonatomic, assign) HYBErrorType   errorType;

// 默认是12 * 60 * 60秒，也就是12小时
// 如果有需要修改，就传此参数
@property (nonatomic, assign) NSUInteger     timeout;

////////////////////////
// 异步请求方式
////////////////////////
/*!
 * @brief 默认使用POST请求方式
 * @param path 网络请求前缀参数
 * @param params 使用字典存储，会在内部拼接到请求网址中
 * @param completion 完成时的回调block
 * @return 返回HYBHttpRequest对象
 */
- (id)initWithPath:(NSString *)path
            params:(NSDictionary *)params
        completion:(HYBResultBlock)completion;
- (id)initWithPath:(NSString *)path
            params:(NSDictionary *)params
        completion:(HYBResultBlock)completion
           isCache:(BOOL)isCache   // 是否缓存，POST请求默认是NO
         isRefresh:(BOOL)isRefresh; // 是否刷新缓存

- (id)initWithPath:(NSString *)path
            params:(NSDictionary *)params
       requestType:(HYBRequestType)requestType
        completion:(HYBResultBlock)completion;
- (id)initWithPath:(NSString *)path
            params:(NSDictionary *)params
       requestType:(HYBRequestType)requestType
        completion:(HYBResultBlock)completion
           isCache:(BOOL)isCache  // 是否缓存，POST请求默认是NO;
         isRefresh:(BOOL)isRefresh; // 是否刷新缓存

- (id)initWithPath:(NSString *)path
       requestType:(HYBRequestType)requestType
        completion:(HYBResultBlock)completion;
- (id)initWithPath:(NSString *)path
       requestType:(HYBRequestType)requestType
        completion:(HYBResultBlock)completion
           isCache:(BOOL)isCache // 是否缓存，POST请求默认是NO;
         isRefresh:(BOOL)isRefresh; // 是否刷新缓存

// 只能是GET方式才能调用此方法
- (id)initWithPath:(NSString *)path
        completion:(HYBResultBlock)completion
           isCache:(BOOL)isCache // 是否缓存，POST请求默认是NO;
         isRefresh:(BOOL)isRefresh; // 是否刷新缓存

// 必须是POST请求，请求参数要转换成JSON格式数据
- (id)initWithPath:(NSString *)path
          postBody:(NSMutableData *)postBodyJSONData
        completion:(HYBResultBlock)completion;
// 必须是POST请求，请求参数要转换成JSON格式数据
- (id)initWithPath:(NSString *)path
          postBody:(NSMutableData *)postBodyJSONData
        completion:(HYBResultBlock)completion
           isCache:(BOOL)isCache // 是否缓存，POST请求默认是NO;
         isRefresh:(BOOL)isRefresh; // 是否刷新缓存

// 取消请求
- (void)cancelRequest;

@end

