//
//  URLModel.m
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/6.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "URLModel.h"

@implementation URLModel

static URLModel *_instance;

+ (URLModel *)sharedURLModel
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        if (!_instance.manager) {
            
            _instance.manager = [AFHTTPRequestOperationManager manager];
            _instance.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", @"multipart/form-data", @"application/x-www-form-urlencoded",nil];
            _instance.manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [_instance.manager.requestSerializer setValue:@"artemisToken_isvalid" forHTTPHeaderField:@"artemisToken"];
            
            _instance.manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
            _instance.manager.securityPolicy.allowInvalidCertificates = YES;
        }
    });
    return _instance;
}

+ (void)requestWithURL:(NSString *)urlString
                params:(id)params
            request_id:(NSString *)request_id
        completedBlock:(void (^)(AFHTTPRequestOperation *, id))success
               failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
         fromClassName:(NSString *)className
{

    MBProgressHUD *showHud;
    for (MBProgressHUD *hud in [MBProgressHUD allHUDsForView:[UIApplication sharedApplication].keyWindow]) {
        
        //已经显示在页面上的hud
        showHud = hud;
        break;
        
    }
    
    
    if (!showHud) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.removeFromSuperViewOnHide = YES;
        hud.dimBackground = NO;
        hud.userInteractionEnabled = NO;
        showHud = hud;
    }
    else {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:showHud];
        [showHud show:NO];
    }
    
//    if ([className isEqualToString:@"AddfileView"] ) {
//        [showHud hide:YES];
//    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPRequestOperation * operation = nil;
    
    
    NSString *postStr = [SERVERADDRS stringByAppendingString:urlString];
//    NSDictionary *postDic = @{@"arguments": paramsToArr ? paramsToArr : params};
    NSDictionary *postDic = @{@"params":@[params],@"request_id":request_id};

    
    NSError *error = nil;
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:postDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *str = [[NSString alloc]initWithData:jsondata encoding:NSUTF8StringEncoding];
    
    operation = [[URLModel sharedURLModel].manager POST:postStr parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [showHud hide:YES afterDelay:.6];

        
        if (![URLModel sharedURLModel].manager.operationQueue.operationCount) {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
        
        NSLog(@"%@请求链接：%@\n传参：%@\n回参：%@", className, postStr, str, responseObject);
        if ([[responseObject objectForKey:dStatus] integerValue] == 0 && success) {
            
            success(operation, responseObject);
        }
        else {
            
            if (failure) {
                
                failure(operation, error);
            }
            
//            if (![className isEqualToString:@"OrderTableView"] &&
//                ![className isEqualToString:@"MainTableView"]) {
//                
//                [Helper tipMessage:responseObject[dMessage] afterDelay:dTipDelay completion:^{
//                    
//                }];
//            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", [error localizedDescription]);
        if (![URLModel sharedURLModel].manager.operationQueue.operationCount) {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [showHud hide:YES];
        }
        
        NSLog(@"%@，请求链接：%@\n传参：%@", [error localizedDescription], postStr, str);
        
        if (failure) {
            
            failure(operation, error);
        }
    }];
    
//    operation.className = className;
//    operation.urlName = urlString;
}


+(void)uploadImageWithUrl:(NSString *)strUrl dataParams:(nullable NSMutableDictionary *)dataParams imageParams:(NSMutableDictionary *)imageParams Success:(void(^)(NSDictionary *resultDic)) success Failed:(void(^)(NSError *error))fail {
    NSArray *keys = [imageParams allKeys];
    UIImage * image = [imageParams objectForKey:[keys firstObject]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];//对SSL做处理，防止上传失败
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"application/json"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 120;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager POST:strUrl parameters:dataParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        
        [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:[keys firstObject] fileName:[NSString stringWithFormat:@"%@.png",[keys firstObject]] mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            
            
//            success(responseObject);
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"dict:%@",dict);
            
            success(dict);
            
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}



@end
