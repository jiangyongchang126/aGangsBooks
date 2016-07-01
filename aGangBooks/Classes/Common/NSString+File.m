//
//  NSString+file.m
//  weibo
//
//  Created by apple on 13-8-28.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NSString+File.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (File)

- (NSString *)filenameAppend:(NSString *)append
{
    // 1.获取没有拓展名的文件名
    NSString *filename = [self stringByDeletingPathExtension];
    
    // 2.拼接append
    filename = [filename stringByAppendingString:append];
    
    // 3.拼接拓展名
    NSString *extension = [self pathExtension];
    
    // 4.生成新的文件名
    return [filename stringByAppendingPathExtension:extension];
}

+ (BOOL)isCodeValid:(NSString *)code
{
    if (code.length >= 6 && code.length <=32) {
        
        return YES;
    }
    return NO;
}

//用户名验证
+ (BOOL)isUserNameValid:(NSString*)name
{
    NSString* regex = @"^[a-zA-Z0-9_@.-]{6,32}$";
    NSPredicate *regexname = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([regexname evaluateWithObject:name] == YES) {
        return YES;
    } else {
        return NO;
    }
}



//用户密码验证
+ (BOOL)isUserPasswordValid:(NSString*)password
{
    NSString* regex = @"^(?!^\\d+$)(?!^[a-zA-Z]+$)(?!^[\\W_]+$).{6,16}$";
    NSPredicate *regexpassword = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([regexpassword evaluateWithObject:password] == YES) {
        return YES;
    } else {
        return NO;
    }
}

//电子邮箱验证
+ (BOOL)isEmailValid:(NSString*)email{
//    NSString* regex = @"^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    NSString* regex = @"^[a-z0-9]*([-+.'][a-z0-9]*)*@[a-z0-9]*([-.][a-z0-9]*)*\\.[a-z0-9]*([-.][a-z0-9]*)*$";
    NSPredicate *regexemail = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([regexemail evaluateWithObject:email] == YES) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isAustraliaNumber:(NSString *)phone
{
//    NSString *mobileregex = @"^((1(3[0-9]|5[0-9]|8[0-9])|04)\\d{8})$";
    NSString *mobileregex = @"^^(((13[0-9]{1})|159|153|04)\\d{8})$";

    NSPredicate *regexmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileregex];
    
    if ([regexmobile evaluateWithObject:phone] == YES) {
        return YES;
    }else {
        return NO;
    }
}

//手机号码验证
+ (BOOL)isPhoneValid:(NSString*)phone
{
    //匹配移动手机号
    //"^1(3[4-9]|5[012789]|8[78])\d{8}$"
    NSString *mobileregex = @"^1(3[4-9]|5[012789]|8[78])\\d{8}$";
    NSPredicate *regexmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileregex];
    // 匹配电信手机号
    //"^18[09]\d{8}$"
    NSString *telecomregex = @"^18[0-9]\\d{8}$";
    NSPredicate *regextelecom = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telecomregex];
    //匹配联通手机号
    //"^1(3[0-2]|5[56]|8[56])\d{8}$"
    NSString *unicomregex = @"^1(3[0-2]|5[56]|8[56])\\d{8}$";
    NSPredicate *regexunicom = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", unicomregex];
    //匹配CDMA手机号
    //"^1[35]3\d{8}$"
    NSString *CDMAregex = @"^1[35]3\\d{8}$";
    NSPredicate *regexCDMA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CDMAregex];
    
    if ([regexmobile evaluateWithObject:phone] == YES || [regextelecom evaluateWithObject:phone] == YES ||[regexunicom evaluateWithObject:phone] == YES ||[regexCDMA evaluateWithObject:phone] == YES) {
        return YES;
    }else {
        return NO;
    }
}

// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^((1[3,5,8][0-9])|(14[5,7])|(17[0,6,7,8]))\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})(|-)\\d{7,8}|\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestphs evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//身份证号码
+(BOOL)checkIdentityCardNo:(NSString*)cardNo
{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
    
    
    //     BOOL flag;
    //     if (cardNo.length <= 0) {
    //     flag = NO;
    //     return flag;
    //     }
    //     NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    //     NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //     return [identityCardPredicate evaluateWithObject:cardNo];
}

//过滤数字
-(BOOL)isNumber
{
    NSString *match=@"(^[0-9]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

-(BOOL)isChinese
{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isEnglishNum
{
    NSString *match=@"(^[a-zA-Z0-9]*$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

//密码强度验证
+ (NSString *)checkPasswordStrength:(NSString*)password
{
    //强密码正则表达式
    NSString *strongregex = @"^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$";
    NSPredicate *regexstrong = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strongregex];
    //中密码正则表达式
    NSString *mediumregex = @"^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$";
    NSPredicate *regexmedium = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mediumregex];
    
    
    if ([regexstrong evaluateWithObject:password] == YES) {
        return @"strong";
    }else if ([regexmedium evaluateWithObject:password] == YES) {
        return @"normal";
    }else {
        return @"weak";
    }
    
    return nil;
}

//密码强度验证
+ (NSString *)checkPasswordStrength2:(NSString*)password
{
    int matchCount=0;
    BOOL hasDigit=FALSE;//是否存在数字
    BOOL hasLetter=FALSE;//是否存在小写字符
    BOOL hasBigLetter=FALSE;//是否存在大写字符
    BOOL hasSpecial=FALSE;//是否存在特殊字符
    //正则表达式（包含 数字、字母、特殊字符）
    NSString *regex = @"^[0-9a-zA-Z_]\\w{5,32}$";
    NSPredicate *regexvalid = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //只包含数字的密码验证(6-32)
    NSString *digitregex = @"\\d+";
    NSPredicate *regexdigit = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", digitregex];
    //只包含小写字母的密码验证(6-32)
    NSString *letterregex = @"[a-z]+";
    NSPredicate *regexletter = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", letterregex];
    //只包含大写字母的密码验证(6-32)
    NSString *bigletterregex = @"[A-Z]+";
    NSPredicate *regexbigletter = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", bigletterregex];
    //只包含特殊字符_的密码验证(6-32)
    NSString *specialregex = @"[_]+";
    NSPredicate *regexspecial = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", specialregex];
    
    //检索每个字符
    for (int i=1; i<=password.length; i++) {
        NSLog(@"i:%@",[[password substringToIndex:i] substringFromIndex:i-1]);
        NSString *indexPsd=[[password substringToIndex:i] substringFromIndex:i-1];
        if ([regexdigit evaluateWithObject:indexPsd] == YES) {
            hasDigit=TRUE;
        }if ([regexletter evaluateWithObject:indexPsd] == YES) {
            hasLetter=TRUE;
        }if ([regexbigletter evaluateWithObject:indexPsd] == YES) {
            hasBigLetter=TRUE;
        }if ([regexspecial evaluateWithObject:indexPsd] == YES) {
            hasSpecial=TRUE;
        }
    }
    
    
    
    if (hasDigit) {
        matchCount+=1;
    }if (hasLetter) {
        matchCount+=1;
    }if (hasBigLetter) {
        matchCount+=1;
    }if (hasSpecial) {
        matchCount+=1;
    }
    NSLog(@"matchcount:%d",matchCount);
    
    if (![regexvalid evaluateWithObject:password] == YES) {
        return @"unvalid";
    }else if (matchCount==1) {
        return @"low";
    }else if (matchCount==2||matchCount==3) {
        return @"medium";
    }else if (matchCount==4) {
        return @"high";
    }
    
    return nil;
}

//URL转码
- (NSString *)URLEncodeString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("+ $ , # [ ]"), kCFStringEncodingUTF8));
    return result;
}

//URL解码
- (NSString *)URLDecodeString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8));
    return result;
}

//将NSString 转换成 NSarray NSdictionay
-(id)JSONValue
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+ (NSString *)stringWithDict:(NSDictionary *)dict
{
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if(error){
        return nil;
    }
    NSString *str = [[NSString alloc]initWithData:jsondata encoding:NSUTF8StringEncoding];
//    str=[@"[" stringByAppendingFormat:@"%@%@",str,@"]"];
    
    return str;
}

////将NSarray NSdictionay 转换成 NSString
//-(NSData*)JSONString
//{
//    NSError* error = nil;
//    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
//    if (error != nil) return nil;
//    return result;
//}

+ (NSString *)getTenUuids
{
    NSMutableString *uuidTmp = [NSMutableString stringWithFormat:@"%@",[UIDevice currentDevice].identifierForVendor];
    NSString *uuid = [[NSString alloc] init];
    if ([uuidTmp length] >10) {
        uuid =[uuidTmp substringToIndex:10];
    }
    return uuid;
    
}

+ (NSString *)getCurrentDate
{
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *curDate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    return curDate;
}

+ (NSString *)getCurrentDate2
{
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *curDate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    return curDate;
}

+ (NSString *)getDateString:(NSDate *)date
{
    NSDateFormatter *dateF = [NSDateFormatter new];
    dateF.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return [dateF stringFromDate:date];
}

+ (void)getBgnYM:(NSString *__autoreleasing *)bgnYM andEndYM:(NSString *__autoreleasing *)endYM containDay:(BOOL)contain
{
    NSDate *endDate=[NSDate date];
    NSInteger interval = - 365 / 2 * 24 * 60 * 60;
    NSDate *bgnDate = [NSDate dateWithTimeIntervalSinceNow:interval];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:[NSString stringWithFormat:@"yyyy-MM%@", contain ? @"-dd": @""]];
    *endYM = [NSString stringWithFormat:@"%@",[formatter stringFromDate:endDate]];
    *bgnYM = [NSString stringWithFormat:@"%@",[formatter stringFromDate:bgnDate]];
}

+(BOOL)isBankNumValid:(NSString*)num
{
    NSString *mobileregex = @"^[\\d]{16,19}";
    NSPredicate *regexmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileregex];
    if([regexmobile evaluateWithObject:num]){
        
        return YES;
    }else{
        return NO;
    }
}

+(NSString *)getCurrentTime
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //NSTimeZone *currentZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSString *outStr=[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
    return outStr;
    
}

//获取交易日期
+ (NSString *)transDate
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSString *outStr=[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
    return outStr;
}

//获取交易流水号 生成规则 02+yyyymmddhhmmss+8位随机数
+ (NSString *)serialNo
{
    //十四位时间
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddhhmmss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSString *nowDateStr=[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
    
    //8位随机数
    int randNum = arc4random()%89999999+10000000;
    
    NSString *serialNO = [NSString stringWithFormat:@"%@%@%d",@"02",nowDateStr,randNum];
    
    return serialNO;
    
}

+ (UIImage *)saveTempFileFromUrlString:(NSString *)urlString
{
    NSArray *array = [urlString componentsSeparatedByString:@"?id="];
    
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"picture"];
    
    NSFileManager *fileM = [NSFileManager defaultManager];
    if (![fileM fileExistsAtPath:filePath]) {
        
        [fileM createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //判断当前文件夹中是否已经有缓存
    NSString *fileName = [filePath stringByAppendingString:[NSString stringWithFormat:@"/%@", array[1]]];
    
    if ([fileM fileExistsAtPath:fileName]) {
        
        return [UIImage imageWithContentsOfFile:fileName];
    }
    
    //用网络加载
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    
    [data writeToFile:fileName atomically:YES];
    
    return [UIImage imageWithData:data];
    
}

+ (BOOL)checkCodeValid:(NSString *)code
{
    BOOL success = [code isNumber];
    if (code.length != 6) {
        
        success = NO;
    }
    
    return success;
}

+ (NSString *)xmlstringWithDict:(NSDictionary *)dict
{
    NSMutableString *xmlStr = [[NSMutableString alloc]init];
    [xmlStr appendString:@"<?xml version='1.0' encoding='utf-8' standalone='yes'?>\n"];
    [xmlStr appendString:@"<tree>"];
    NSArray *keys  = dict.allKeys;
    NSArray *values = dict.allValues;
    for (int i = 0 ; i<keys.count; i++) {
        NSString *keyStr = keys[i];
        NSString *valueStr = values[i];
        [xmlStr appendFormat:@"<%@>",keyStr];
        [xmlStr appendString:valueStr];
        [xmlStr appendFormat:@"</%@>",keyStr];
    }
    [xmlStr appendString:@"</tree>"];
    
    return xmlStr;
}

+ (NSString *)xmlstringWithDict:(NSDictionary *)dict attributes:(NSArray *)attArr
{
    NSMutableString *xmlStr = [[NSMutableString alloc]init];
    [xmlStr appendString:@"<?xml version='1.0' encoding='utf-8' standalone='yes'?>\n"];
    [xmlStr appendString:@"<tree>"];
    NSArray *keys  = dict.allKeys;
    NSArray *values = dict.allValues;
    for (int i = 0 ; i<keys.count; i++) {
        NSString *keyStr = keys[i];
        NSString *valueStr = values[i];
        [xmlStr appendFormat:@"<%@>",keyStr];
        [xmlStr appendString:valueStr];
        [xmlStr appendFormat:@"</%@>",keyStr];
    }
    for (NSDictionary *attDict in attArr) {
        NSString *node = [attDict objectForKey:@"node"];
        NSString *text = [attDict objectForKey:@"text"];
        NSString *attKey = [attDict objectForKey:@"attkey"];
        NSString *attValue = [attDict objectForKey:@"attvalue"];
        [xmlStr appendFormat:@"<%@ %@=\"%@\">",node,attKey,attValue];
        [xmlStr appendString:text];
        [xmlStr appendFormat:@"</%@>",node];
    }
    
    [xmlStr appendString:@"</tree>"];
    
    
    return xmlStr;
}

- (NSString *)subCharStringToIndex:(NSInteger)index
{
    NSInteger i = 0;
    if(self){
        
        for (; i < index; i++){
            
            NSRange range=NSMakeRange(i,1);
            
            NSString *subString=[self substringWithRange:range];
            
            const char *cString=[subString UTF8String];
            
            if (strlen(cString)==3){
                NSLog(@"昵称是汉字");
                index -= 2;
            }
            else if (strlen(cString) == 2) {
                
                NSLog(@"昵称是奇怪的字母");
                index--;
            }
        }
    }
    
    return [self substringToIndex:i];
}

- (NSString *)documentAppend
{
    NSString *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    return [doc stringByAppendingPathComponent:self];
}

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+ (NSString *)encodeToPercentEscapeString:(NSString *)input
{
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)input,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return outputStr;
}

@end
