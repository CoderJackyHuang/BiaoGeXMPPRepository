//
//  HYBBaseModel.m
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBBaseModel.h"

@implementation HYBBaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"undefine key: %@", key);
    return;
}

@end
