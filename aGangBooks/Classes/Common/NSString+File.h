//
//  NSString+file.h
//  weibo
//
//  Created by apple on 13-8-28.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  字符串扩展方法

#import <Foundation/Foundation.h>

@interface NSString (File)

//字符串拼接
- (NSString *)filenameAppend:(NSString *)append;

+ (BOOL)isCodeValid:(NSString*)code;

//用户名验证
+(BOOL)isUserNameValid:(NSString*)name;

//用户密码验证
+(BOOL)isUserPasswordValid:(NSString*)password;

//电子邮箱验证
+(BOOL)isEmailValid:(NSString*)email;

//澳大利亚手机号认证
+ (BOOL)isAustraliaNumber:(NSString *)phone;

//手机号码验证
+(BOOL)isPhoneValid:(NSString*)phone;

// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

//身份证号码
+(BOOL)checkIdentityCardNo:(NSString*)cardNo;

+ (BOOL)checkCodeValid:(NSString *)code;

//过滤中文
-(BOOL)isChinese;

//过滤英文
- (BOOL)isEnglishNum;

//过滤数字
-(BOOL)isNumber;

//密码强度验证
+(NSString *)checkPasswordStrength:(NSString*)password;

//密码强度验证
+(NSString *)checkPasswordStrength2:(NSString*)password;

//URL转码
- (NSString *)URLEncodeString;

//URL解码
- (NSString *)URLDecodeString;

-(id)JSONValue;

//返回JSON格式字符串
+ (NSString *)stringWithDict:(NSDictionary *)dict;

//返回uuid
+ (NSString *)getTenUuids;

//获取当前时间 yyyyMMdd
+ (NSString *)getCurrentDate;
// 校验银行卡号
+(BOOL)isBankNumValid:(NSString*)num;
//获取当前时间
+(NSString *)getCurrentTime;
+ (NSString *)getCurrentDate2;
+ (NSString *)getDateString:(NSDate *)date;

+ (void)getBgnYM:(NSString **)bgnYM andEndYM:(NSString **)endYM containDay:(BOOL)contain;

//获取当前日期 yyyymmdd
+ (NSString *)transDate;

//获取交易流水号 生成规则 02+yyyymmddhhmmss+8位随机数
+ (NSString *)serialNo;

//保存文件
+ (UIImage *)saveTempFileFromUrlString:(NSString *)urlString;

+ (NSString *)xmlstringWithDict:(NSDictionary *)dict;

+ (NSString *)xmlstringWithDict:(NSDictionary *)dict attributes:(NSArray *)attArr;

//截取字节字符
- (NSString *)subCharStringToIndex:(NSInteger)index;

//拼出文件路径
- (NSString *)documentAppend;

//md5加密
- (NSString *)md5;

+ (NSString *)encodeToPercentEscapeString:(NSString *)input;

@end
