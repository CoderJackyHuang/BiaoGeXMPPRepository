//
//  HYBUserModel.h
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYBBaseModel.h"

/*!
 * @brief The model of user information
 *
 * @author huangyibiao
 */
@interface HYBUserModel : HYBBaseModel

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *userHead;
@property (nonatomic, copy) NSString *registerDate;
@property (nonatomic, copy) NSString *userAge;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *userQq;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *userSex;
@property (nonatomic, copy) NSString *userState;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userNickname;
@property (nonatomic, copy) NSString *userDescription;
@property (nonatomic, copy) NSString *userPassword;
@property (nonatomic, copy) NSString *userPhone;
@property (nonatomic, copy) NSString *apiKey;
@property (nonatomic, copy) NSString *userBirthday;

@end
