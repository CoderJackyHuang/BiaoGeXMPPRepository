//
//  HYBHttpManager+Discover.h
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBHttpManager.h"

@interface HYBHttpManager (Discover)

///
/// discover request
/// Method post
typedef void (^HYBDiscoverBlock)(NSArray *userModels);
+ (HYBHttpRequest *)discoverWithPath:(NSString *)path
                              params:(NSDictionary *)params
                          completion:(HYBDiscoverBlock)completion
                          errorBlock:(HYBErrorBlock)errorBlock;

@end
