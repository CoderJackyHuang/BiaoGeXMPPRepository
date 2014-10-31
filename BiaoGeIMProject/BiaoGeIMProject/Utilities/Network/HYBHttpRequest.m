//
//  HYBHttpRequest.m
//  BiaoGeIMProject
//
//  Created by ljy-335 on 14-10-31.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "NSString+Common.h"
#import "HYBHttpRequestManager.h"
#import "NSString+Encrypt.h"
#import "NSFileManager+File.h"
#import "NSString+Encrypt.h"

@interface HYBHttpRequest ()

@property (nonatomic, assign) BOOL isCache;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) BOOL isUpOrDownload;
@property (nonatomic, copy)   NSString *fileName;

@end

@implementation HYBHttpRequest

- (id)initWithPath:(NSString *)path
            params:(NSDictionary *)params
       requestType:(HYBRequestType)requestType
        completion:(HYBResultBlock)completion {
    return [self initWithPath:path
                       params:params
                  requestType:requestType
                   completion:completion
                      isCache:requestType == kTypeGet
                    isRefresh:NO];
}

// 只能是GET方式才能调用此方法
- (id)initWithPath:(NSString *)path
        completion:(HYBResultBlock)completion
           isCache:(BOOL)isCache // 是否缓存，POST请求默认是NO;
         isRefresh:(BOOL)isRefresh { // 是否刷新缓存
    return [self initWithPath:path
                       params:nil
                  requestType:kTypeGet
                   completion:completion
                      isCache:isCache
                    isRefresh:isRefresh];
}

- (id)initWithPath:(NSString *)path
            params:(NSDictionary *)params
        completion:(HYBResultBlock)completion
           isCache:(BOOL)isCache   // 是否缓存，POST请求默认是NO
         isRefresh:(BOOL)isRefresh { // 是否刷新缓存
    return [self initWithPath:path
                       params:params
                  requestType:kTypePost
                   completion:completion
                      isCache:isCache
                    isRefresh:isRefresh];
}

- (id)initWithPath:(NSString *)path
            params:(NSDictionary *)params
       requestType:(HYBRequestType)requestType
        completion:(HYBResultBlock)completion
           isCache:(BOOL)isCache
         isRefresh:(BOOL)isRefresh {
    if (self = [super initWithURL:[NSURL URLWithString:path]]) {
        self.isCache = isCache;
        self.delegate = self;
        self.resultBlock = [completion copy];
        self.downloadData = [[NSMutableData alloc] init];
        self.requestType = requestType;
        self.fileName = path;
        self.isRefresh = isRefresh;
        [self setTimeOutSeconds:60];

        if (self.requestType == kTypeGet) {
            [self setRequestMethod:@"GET"];
            // 设置永久存储在本地
        } else if (self.requestType == kTypePost) {
            [self setRequestMethod:@"POST"];
            [self addRequestHeader:@"Content-Type" value:@"application/json"];
            if (params) {
                self.fileName = [NSString stringWithFormat:@"%@?", self.fileName];
                for (NSString *key in params.allKeys) {
                    [self addPostValue:[params objectForKey:key] forKey:key];
                    self.fileName = [NSString stringWithFormat:@"%@%@=%@",
                                     self.fileName, key, [params objectForKey:key]];
                }
            }
        }
        
        // 如果是缓存
        // 且不刷新缓存
        if (self.isRefresh == NO && self.isCache && [[NSFileManager defaultManager] isFileExists:[self cachePath]]) {
            NSUInteger timeout = self.timeout != 0 ? self.timeout : 12 * 60 * 60;
            if (![[NSFileManager defaultManager] isFile:[self cachePath] timeout:timeout]) {
                NSData *data = [[NSData alloc] initWithContentsOfFile:[self cachePath]];
                self.downloadData = [data mutableCopy];
                if (data.length > 100) {
                    self.resultBlock(data, nil);
                    return self;
                }
            }
        }
        
        [[HYBHttpRequestManager sharedRequestManager] addRequest:self
                                                         withKey:self.fileName.md5];
        [self startAsynchronous];
    }
    return self;
}

- (id)initWithPath:(NSString *)path params:(NSDictionary *)params completion:(HYBResultBlock)completion {
    return [self initWithPath:path params:params requestType:kTypePost completion:completion];
}

- (id)initWithPath:(NSString *)path
        completion:(HYBResultBlock)completion {
    return [self initWithPath:path params:nil completion:completion];
}

- (id)initWithPath:(NSString *)path
       requestType:(HYBRequestType)requestType
        completion:(HYBResultBlock)completion {
    return [self initWithPath:path
                       params:nil
                  requestType:requestType
                   completion:completion
                      isCache:requestType == kTypeGet
                    isRefresh:NO];
}

- (id)initWithPath:(NSString *)path
       requestType:(HYBRequestType)requestType
        completion:(HYBResultBlock)completion
           isCache:(BOOL)isCache // 是否缓存，POST请求默认是NO;
         isRefresh:(BOOL)isRefresh { // 是否刷新缓存
    return [self initWithPath:path
                       params:nil
                  requestType:requestType
                   completion:completion
                      isCache:isCache
                    isRefresh:isRefresh];
}

// 必须是POST请求，请求参数要转换成JSON格式数据
- (id)initWithPath:(NSString *)path
          postBody:(NSMutableData *)postBodyJSONData
        completion:(HYBResultBlock)completion {
    return [self initWithPath:path
                     postBody:postBodyJSONData
                   completion:completion
                      isCache:NO
                    isRefresh:YES];
}

- (id)initWithPath:(NSString *)path
          postBody:(NSMutableData *)postBodyJSONData
        completion:(HYBResultBlock)completion
           isCache:(BOOL)isCache // 是否缓存，POST请求默认是NO;
         isRefresh:(BOOL)isRefresh { // 是否刷新缓存
    if (self = [super initWithURL:[NSURL URLWithString:path]]) {
        self.delegate = self;
        self.resultBlock = [completion copy];
        self.downloadData = [[NSMutableData alloc] init];
        self.requestType = kTypePost;
        self.isCache = isCache;
        self.isRefresh = isRefresh;
        self.fileName = path;
        [self setTimeOutSeconds:60];
        
        if (postBodyJSONData.length != 0) {
            NSString *str = [[NSString alloc] initWithData:postBodyJSONData
                                                  encoding:NSUTF8StringEncoding];
            self.fileName = [NSString stringWithFormat:@"%@%@", self.fileName, str];
        }
        if (self.requestType == kTypePost) {
            [self setRequestMethod:@"POST"];
            [self addRequestHeader:@"Content-Type" value:@"application/json"];
            [self addRequestHeader:@"Accept" value:@"application/json"];
            [self setPostBody:postBodyJSONData];
        }
        
        // 如果是缓存
        // 且不刷新缓存
        if (self.isRefresh == NO && self.isCache  && [[NSFileManager defaultManager] isFileExists:[self cachePath]]) {
            NSUInteger timeout = self.timeout != 0 ? self.timeout : 12 * 60 * 60;
            if (![[NSFileManager defaultManager] isFile:[self cachePath] timeout:timeout]) {
                NSData *data = [[NSData alloc] initWithContentsOfFile:[self cachePath]];
                self.downloadData = [data mutableCopy];
                if (data.length > 100) {
                    self.resultBlock(data, nil);
                    return self;
                }
            }
        }
        
        [[HYBHttpRequestManager sharedRequestManager] addRequest:self
                                                         withKey:self.fileName.md5];
        [self startAsynchronous];
    }
    return self;
}

- (void)cancelRequest {
    [self clearDelegatesAndCancel];
    return;
}

#pragma mark - ASIHttpRequestDelegate
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders {
    [self.downloadData setLength:0];
    return;
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    [[HYBHttpRequestManager sharedRequestManager] removeRequestWithKey:self.fileName.md5];
    if (self.resultBlock) {
        if (!self.isUpOrDownload) {
            [self.downloadData writeToFile:[self cachePath] atomically:YES];
            self.resultBlock(self.downloadData, nil);
        }
    }
    return;
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [[HYBHttpRequestManager sharedRequestManager] removeRequestWithKey:self.fileName.md5];
    if (self.resultBlock) {
        [self clearDelegatesAndCancel];
        if (!self.isUpOrDownload) {
            self.resultBlock(self.downloadData, self.error);
        }
    }
    return;
}

- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data {
    [self.downloadData appendData:data];
    return;
}

#pragma mark - 获取缓存路径
- (NSString *)cachePath {
    return [NSString stringWithFormat:@"%@/%@", [NSString cachePath], self.fileName.md5];
}

@end
