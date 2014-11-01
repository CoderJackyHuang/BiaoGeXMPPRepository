//
//  HYBHttpManager+Discover.m
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBHttpManager+Discover.h"
#import "HYBUserModel.h"

@implementation HYBHttpManager (Discover)

+ (HYBHttpRequest *)discoverWithPath:(NSString *)path
                              params:(NSDictionary *)params
                          completion:(HYBDiscoverBlock)completion
                          errorBlock:(HYBErrorBlock)errorBlock {
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
                            NSArray *pageData = dataDict[@"pageData"];
                            if ([pageData isKindOfClass:[NSArray class]]) {
                                NSMutableArray *modelsArray = [[NSMutableArray alloc] initWithCapacity:pageData.count];
                                for (NSDictionary *itemDict in pageData) {
                                    if ([itemDict isKindOfClass:[NSDictionary class]]) {
                                        HYBUserModel *userModel = [[HYBUserModel alloc] init];
                                        [userModel setValuesForKeysWithDictionary:itemDict];
                                        [modelsArray addObject:userModel];
                                    }
                                }
                                
                                isSuccess = YES;
                                dispatch_async(kMainThread, ^{
                                    completion(modelsArray);
                                });
                            }
                        }
                    }
                }
                
                if (!isSuccess) {
                    dispatch_async(kMainThread, ^{
                        completion(nil);
                    });

                }
            }
        });
    } isCache:YES isRefresh:NO];
    return request;
}

@end
