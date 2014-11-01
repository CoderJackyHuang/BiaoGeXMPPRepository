//
//  HYBHttpRequestManager.m
//  CloudShopping
//
//  Created by sixiaobo on 14-7-9.
//  Copyright (c) 2014年 com.Uni2uni. All rights reserved.
//

#import "HYBHttpRequestManager.h"
#import "HYBHTTPRequest.h"

@interface HYBHttpRequestManager ()

@property (nonatomic, strong) NSMutableDictionary *requestDict;

@end

@implementation HYBHttpRequestManager

+ (HYBHttpRequestManager *)sharedRequestManager {
    static HYBHttpRequestManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (!sharedManager) {
            sharedManager = [[[self class] alloc] init];
        }
    });
    
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        self.requestDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSUInteger)requestCount {
    NSLog(@"%d", self.requestDict.count);
    return self.requestDict.count;
}

- (void)addRequest:(id)request withKey:(NSString *)urlStringKey {
    NSString *error = [NSString stringWithFormat:@"error in %s, key is nil", __FUNCTION__];
    NSAssert(urlStringKey != nil, error);
    [self.requestDict setObject:request forKey:urlStringKey];
    return;
}

- (void)removeRequestWithKey:(NSString *)urlStringKey {
    NSString *error = [NSString stringWithFormat:@"error in %s, key is nil", __FUNCTION__];
    NSAssert(urlStringKey != nil, error);
    id request = [self.requestDict objectForKey:urlStringKey];
    if ([request isKindOfClass:[ASIHTTPRequest class]]) {
        [request clearDelegatesAndCancel];
    } else {
        NSURLConnection *connection = (NSURLConnection *)request;
        [connection cancel];
    }
    [self.requestDict removeObjectForKey:urlStringKey];
    return;
}

- (void)removeAllRequest {
    [self.requestDict removeAllObjects];
    return;
}

- (void)cancelAllRequestAndRemove {
    for (ASIHTTPRequest *request in self.requestDict.allValues) {
        [request clearDelegatesAndCancel];
    }
    [self.requestDict removeAllObjects];
    return;
}

@end
