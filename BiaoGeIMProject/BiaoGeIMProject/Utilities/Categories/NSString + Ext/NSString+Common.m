//
//  NSString+Common.m
//  CloudShopping
//
//  Created by sixiaobo on 14-7-9.
//  Copyright (c) 2014年 com.Uni2uni. All rights reserved.
//

#import "NSString+Common.h"
#import "NSFileManager+File.h"

@implementation NSString (Common)

/*!
 * @brief 获取Documents路径
 */
+ (NSString *)documentPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

/*!
 * @brief 获取沙盒下tmp路径
 */
+ (NSString *)tmpPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
}


/*!
 * @brief generate UUID
 */
+ (NSString *)UUID {
    NSString *result = nil;
    
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid) {
        result = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
    }
    
    return result;
}

#pragma mark - 获取缓存路径
/*!
 * @brief 获取其它的缓存路径
 */
+ (NSString *)cachePath {
     NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Resources"];
    if (![[NSFileManager defaultManager] isFileExists:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    return path;
}

+ (float)heightForString:(NSString *)value fontSize:(float)fontSize width:(float)width {
    NSDictionary *attribute = @{NSFontAttributeName: kFontWithSize(fontSize)};
    CGRect rect = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attribute
                                     context:nil];
    return rect.size.height;
}

+ (float)heightForString:(NSString *)value font:(UIFont *)font width:(float)width {
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect rect = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attribute
                                      context:nil];
    return rect.size.height;
}

+ (CGFloat)widthWithFontSize:(CGFloat)fontSize text:(NSString *)text {
    NSDictionary *attribute = @{NSFontAttributeName: kFontWithSize(fontSize)};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attribute
                                      context:nil];
    return rect.size.width;
}

/*!
 * @brief 资源下载存储的路径
 */
+ (NSString *)downloadPath {
    return [[self cachePath] stringByAppendingPathComponent:@"downloads"];
}

/*!
 * @brief 获取图片缓存路径
 */
+ (NSString *)imageCachePath {
    NSString *path = [[self cachePath] stringByAppendingPathComponent:@"Images"];
    BOOL isDir = NO;
    BOOL isDirExist = [[NSFileManager defaultManager] fileExistsAtPath:path
                                                           isDirectory:&isDir];
    if (!isDir && !isDirExist) {
       BOOL isSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil error:nil];
        if (isSuccess) {
            NSLog(@"success");
        }
    }
    
    return path;
}

/*!
 * @brief 获取app本地的版本号
 */
+ (NSString *)appLocalVersion {
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleVersion"];
    
    return [version stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]];
}

#pragma mark - 验证邮箱格式
/*!
 * @brief  验证是否是合法邮箱
 * @return YES表示是合法的邮箱格式，返回NO表示邮箱格式不正确
 */
- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

#pragma mark - 验证手机号码格式
/*!
 * @brief  验证是否是正确的手机号码格式
 * @return YES表示是正确的手机号码格式，返回NO表示手机号码格式不正确
 */
- (BOOL)isValidPhoneNumber {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString *mobile = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString *chinaMobile = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * chinaUnicom = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * chinaTelecom = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    NSPredicate *cmPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaMobile];
    NSPredicate *cuPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaUnicom];
    NSPredicate *ctPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaTelecom];
    if ([mobilePredicate evaluateWithObject:self]
        || [cmPredicate evaluateWithObject:self]
        || [cuPredicate evaluateWithObject:self]
        || [ctPredicate evaluateWithObject:self]) {
        return YES;
    }
    
    return NO;
}

/*!
 * @brief  验证是否是正确的18位身份证号码格式
 * @return YES表示是正确的身份证号码格式，返回NO表示身份证号码格式不正确
 */
- (BOOL)isValidPersonID {
    // 判断位数
    if (self.length != 15 && self.length != 18) {
        return NO;
    }
    NSString *carid = self;
    long lSumQT = 0;
    // 加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    // 校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};

    // 将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if (self.length == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        
        for (int i = 0; i<= 16; i++) {
            p += (pid[i] - 48) * R[i];
        }
        
        int o = p % 11;
        NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    // 判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince]) {
        return NO;
    }
    
    // 判断年月日是否有效
    // 年份
    int strYear = [[self substringWithString:carid begin:6 end:4] intValue];
    // 月份
    int strMonth = [[self substringWithString:carid begin:10 end:2] intValue];
    // 日
    int strDay = [[self substringWithString:carid begin:12 end:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",
                                                strYear, strMonth, strDay]];
    if (date == nil) {
        return NO;
    }
    
    const char *PaperId  = [carid UTF8String];
    // 检验长度
    if(18 != strlen(PaperId)) return NO;
    // 校验数字
    for (int i = 0; i < 18; i++) {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ) {
            return NO;
        }
    }
    
    // 验证最末的校验码
    for (int i=0; i<=16; i++) {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] ) {
        return NO;
    }
    return YES;
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
- (BOOL)areaCode:(NSString *)code {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

/*!
 * @brief 过滤掉HTML标签
 * @param html HTML内容
 * @param 返回喜欢去掉所有HTML标签后的字符串
 */
+ (NSString *)filterHTML:(NSString *)html {
    NSScanner *scanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([scanner isAtEnd] == NO) {
        // 找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        // 找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        // 替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text]
                                               withString:@""];
    }
    
    return html;
}

#pragma mark - 根据文件名返回路径
/*!
 * @brief  根据文件名返回文件的路径
 * @param  fileName 文件名，最好带上后缀名，如@“myName.png”
 * @return 如果文件路径存在，则返回该文件路径，否则返回nil
 */
+ (NSString *)pathWithFileName:(NSString *)fileName {
    return [self pathWithFileName:fileName ofType:nil];
}

/*!
 * @brief  根据文件名返回文件的路径
 * @param  fileName 文件名，不能带上后缀名
 * @param  type     文件后缀名
 * @return 如果文件路径存在，则返回该文件路径，否则返回nil
 */
+ (NSString *)pathWithFileName:(NSString *)fileName ofType:(NSString *)type {
    return [[NSBundle mainBundle] pathForResource:fileName ofType:type];
}

/**
 * 功能:获取指定范围的字符串
 * 参数:字符串的开始小标
 * 参数:字符串的结束下标
 */
- (NSString *)substringWithString:(NSString *)str begin:(NSInteger)begin end:(NSInteger )end {
    return [str substringWithRange:NSMakeRange(begin, end)];
}

/*!
 * @brief  根据时间秒数，返回格式化的日期，如"2014-09-03"
 * @param  seconds 秒数，如果sections值为0，则返回当前日期
 * @return 如果seconds不为0，则返回转换后的日期，否则返回当前日期
 */
+ (NSString *)dateWithSeconds:(NSUInteger)seconds {
    if (seconds == 0) {
        return [[[NSDate date] description] substringToIndex:10];
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSString *str = [NSString stringWithFormat:@"%@", date];
    NSArray *array = [str componentsSeparatedByString:@" "];
    NSString *result = [array objectAtIndex:0];
    
    if (array.count == 3) {
        result = [NSString stringWithFormat:@"%@ %@", result, [array objectAtIndex:1]];
    }
    return result;
}

#pragma mark - 去掉空格操作
/*!
 * @brief 去掉空格符号操作，分别是去掉左边的空格、去掉右边的空格、去掉两边的空格、去掉所有空格
 */
// 去掉左边的空格
- (NSString *)trimLeft {
    NSUInteger len = 0;
    NSString *resultString = @"";
    while (len < self.length) {
        if ([self characterAtIndex:len] == ' ') {
            if (len + 1 < self.length) {
                resultString = [self substringFromIndex:len + 1];
            }
        } else {
            return resultString;
        }
        len++;
    }
    return self;
}

// 去掉右边的空格
- (NSString *)trimRight {
    NSString *tempString = [self trimLeft];
    NSUInteger count = 0;
    while (count < tempString.length) {
        if ([tempString characterAtIndex:count] == ' ') {
            return [tempString substringToIndex:count];
        }
        count++;
    }
    return tempString;
}

// 去掉两边的空格
- (NSString *)trim {
   return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

// 去掉所有空格
- (NSString *)trimAll {
    // 去掉两边的空格
    NSString *tempString = self.trim;
    return [tempString stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)trimLetters {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]];
}

/*
 * @brief 去掉字符中中所有的指定的字符
 */
- (NSString *)trimCharacter:(unichar)character {
    NSString *str = [NSString stringWithFormat:@"%c", character];
    return [self stringByReplacingOccurrencesOfString:str withString:@""];
}

// @brief 判断是否只包含字母、数字、字母和数字
// @date 2014-08-21
//
// 只包含字母
- (BOOL)isOnlyLetters {
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

// 只包含数字
- (BOOL)isOnlyNumbers {
    NSCharacterSet *numSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numSet].location == NSNotFound);
}

// 只包含字母和数字
- (BOOL)isOnlyAlphaNumeric {
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

/*!
 * @brief 转换成data数据
 */
- (NSData *)toData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

/*!
 * @brief NSData数据转换成NSString数据
 */
+ (NSString *)toString:(NSData *)data {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/*!
 * @brief 判断是否是空串
 * @return YES表示是空串，NO表示非空
 */
- (BOOL)isEmpty {
    return self == nil || self.length == 0;
}

/*!
 * @brief 判断去掉两边的空格后是否是空串
 * @return YES表示是空串，NO表示非空
 */
- (BOOL)isTrimEmpty {
    return self == nil || self.trim.length == 0;
}

@end
