//
//  HYBHttpManager.h
//  PersonalShoppingMall
//
//  Created by ljy-335 on 14-8-20.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYBHttpRequest.h"

// 此宏定义只是为了简化操作
#define kRequest HYBHttpRequest *request = [[HYBHttpRequest alloc] initWithPath:path

#define   kBackToMainThreadError  dispatch_async(kMainThread, ^{ \
if (errorBlock) { \
    errorBlock(error); \
} \
}); \

/*!
 * @brief 网络请求接口类，此类只做一些其他扩展类公共的操作，只是为了作为功能扩展
 *        通过使用扩展类别的方式来按照模块化管理网络请求类
 * @author huangyibiao
 */
@interface HYBHttpManager : NSObject

/*!
 * @brief 把网络请求回来的二进制数据
 * @param downloadData 网络请求回来的数据
 * @return 返回解析出来的格式化数据，如果解析失败，返回的是nil
 */
+ (id)parseDownloadData:(NSData *)downloadData;

/*!
 * @brief 根据错误信息，生成NSError对象
 * @param errorMessage 错误信息
 * @return 返回NSError对象
 */
+ (NSError*)errorWithMessage:(NSString *)errorMessage;

/*!
 * @brief login request
 * @method POST
 */
typedef void (^HYBLoginBlock)(BOOL isSuccess);
+ (HYBHttpRequest *)loginWithPath:(NSString *)path
                           params:(NSDictionary *)params
                       completion:(HYBLoginBlock)completion
                            error:(HYBErrorBlock)errorBlock;

/*!
 * @brief register request
 * @method POST
 */
typedef void (^HYBRegisterBlock)(BOOL isSuccess, NSString *errorMsg);
+ (HYBHttpRequest *)registerWithPath:(NSString *)path
                           params:(NSDictionary *)params
                       completion:(HYBRegisterBlock)completion
                            error:(HYBErrorBlock)errorBlock;


@end
