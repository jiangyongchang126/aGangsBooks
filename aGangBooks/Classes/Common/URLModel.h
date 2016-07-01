//
//  URLModel.h
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/6.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface URLModel : NSObject

{
    MBProgressHUD *_hud;
}

singleton_interface(URLModel);
@property (strong,nonatomic) NSMutableURLRequest * request;
@property (retain, nonatomic) AFHTTPRequestOperationManager *manager;

/** 数据请求 */
+ (void)requestWithURL:(NSString *)urlString
                params:(id)params
            request_id:(NSString *)request_id
        completedBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
         fromClassName:(NSString *)className;


/** 图片上传 */

@end
