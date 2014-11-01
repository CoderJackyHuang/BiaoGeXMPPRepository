//
//  NSString+Encrypt.m
//  CloudShopping
//
//  Created by sixiaobo on 14-7-9.
//  Copyright (c) 2014年 com.Uni2uni. All rights reserved.
//

#import "NSString+Encrypt.h"

@implementation NSString (Encrypt)

/*!
 * @brief 将字符串转换成二进制数据后，再进行base64编码
 * @return 返回base64编码后的字符串
 */
- (NSString *)base64Encoding {
    NSData *data = [self toData];
    NSString *result = nil;
    if (kIsIOS7OrLater) {
        result = [data base64EncodedStringWithOptions:0];
    } else {
        result = [data base64Encoding];
    }
    return result;
}

#pragma mark - md5加密
/*!
 * @brief 将字符串本身进行md5加密，并将加密后的字符串返回
 * @return 返回加密后的字符串
 */
- (NSString *)md5 {
    const char *cStr = [self UTF8String];
	unsigned char result[16];
	CC_MD5(cStr, strlen(cStr), result);
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]];
}

#pragma mark - sha1加密方法
/*!
 * @brief 将字符串本身进行sha1加密，并将加密后的字符串返回
 * @return 返回加密后的字符串
 */
- (NSString *)sha1 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

#pragma mark - 获取MAC地址
/*!
 * @brief 获取网卡的MAC地址
 * @return 网卡的MAC地址
 */
+ (NSString *)obtainMacAddress {
    int                    mib[6];
    size_t                 len;
    char                   *buf;
    unsigned char          *ptr;
    struct if_msghdr       *ifm;
    struct sockaddr_dl     *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) > 0) {
        free(buf);
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return [outstring uppercaseString];
}

@end
