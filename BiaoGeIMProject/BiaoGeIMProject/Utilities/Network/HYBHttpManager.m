//
//  HYBHttpManager.m
//  PersonalShoppingMall
//
//  Created by ljy-335 on 14-8-20.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

#import "HYBHttpManager.h"

@implementation HYBHttpManager

/*!
 * @brief 把网络请求回来的二进制数据
 * @param downloadData 网络请求回来的数据
 * @return 返回解析出来的格式化数据，如果解析失败，返回的是nil
 */
+ (id)parseDownloadData:(NSData *)downloadData {
    // 如果没有数据，则无需解析，也作为解析失败处理
    if (downloadData.length == 0) {
        return nil;
    }
    // 解析数据
    NSError *error = nil;
    id resultData = [NSJSONSerialization JSONObjectWithData:downloadData
                                                    options:NSJSONReadingMutableContainers
                                                      error:&error];
    // 解析失败，则返回nil
    if (error) {
        return nil;
    }
    
    return resultData;
}

+ (NSError*)errorWithMessage:(NSString *)errorMessage {
    NSError *error = [[NSError alloc] initWithDomain:errorMessage code:-1 userInfo:nil];
    return error;
}

+ (HYBHttpRequest *)loginWithPath:(NSString *)path params:(NSDictionary *)params completion:(HYBLoginBlock)completion error:(HYBErrorBlock)errorBlock {
    path = [NSString stringWithFormat:@"%@%@", kBaseURL, path];
    kRequest params:params completion:^(NSData *downloadData, NSError *error) {
        if (error) {
            errorBlock(error);
            return;
        }
        
        dispatch_async(kGlobalThread, ^{
            id data = [self parseDownloadData:downloadData];
            if (data == nil) {
                kBackToMainThreadError
            } else {
                BOOL isSuccess = NO;
                if ([data isKindOfClass:[NSDictionary class]]) {
                     NSDictionary *dataDict = [(NSDictionary *)data objectForKey:@"data"];
                    
                    NSString *resultCode = [NSString stringWithFormat:@"%@", data[@"resultCode"]];
                    if (resultCode.integerValue == 1) {// success
                        if ([dataDict isKindOfClass:[NSDictionary class]]) {
                            [kUserDefaults setObject:params[@"userName"] forKey:kUserLoginNameKey];
                            [kUserDefaults setObject:params[@"userPassword"] forKey:kUserPasswordKey];
                            [kUserDefaults setObject:dataDict[@"userId"] forKey:kUserIdKey];
                            [kUserDefaults setObject:dataDict[@"userNickname"] forKey:kUserNicknameKey];
                            [kUserDefaults setObject:dataDict[@"userHead"] forKey:kUserHeadImageKey];
                            [kUserDefaults synchronize];
                            isSuccess = YES;
                        }
                    }
                }
                dispatch_async(kMainThread, ^{
                    completion(isSuccess);
                });
            }
        });
    } isCache:NO isRefresh:YES];
    return request;
}

+  (HYBHttpRequest *)registerWithPath:(NSString *)path
                               params:(NSDictionary *)params
                           completion:(HYBRegisterBlock)completion
                                error:(HYBErrorBlock)errorBlock {
    path = [NSString stringWithFormat:@"%@%@", kBaseURL, path];
    kRequest params:params completion:^(NSData *downloadData, NSError *error) {
        if (error) {
            errorBlock(error);
            return;
        }
        
        dispatch_async(kGlobalThread, ^{
            id data = [self parseDownloadData:downloadData];
            if (data == nil) {
                kBackToMainThreadError
            } else {
                BOOL isSuccess = NO;
                NSString *errorMsg = nil;
                if ([data isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dataDict = (NSDictionary *)data;
                    
                    NSString *resultCode = [NSString stringWithFormat:@"%@", data[@"resultCode"]];
                    if (resultCode.integerValue == 1) {// success
                        if ([dataDict isKindOfClass:[NSDictionary class]]) {
                            [kUserDefaults setObject:params[@"userName"] forKey:kUserLoginNameKey];
                            [kUserDefaults setObject:params[@"userPassword"] forKey:kUserPasswordKey];
                            [kUserDefaults setObject:dataDict[@"gid"] forKey:kUserIdKey];
                        [kUserDefaults synchronize];
                            isSuccess = YES;
                        }
                    }
                    errorMsg = dataDict[@"resultMsg"];
                }
                dispatch_async(kMainThread, ^{
                    completion(isSuccess, errorMsg);
                });
            }
        });
    } isCache:NO isRefresh:YES];
    return request;
}

@end
