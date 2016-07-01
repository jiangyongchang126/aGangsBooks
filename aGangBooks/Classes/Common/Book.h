//
//  Book.h
//  BooksManager
//
//  Created by 蒋永昌 on 16/3/20.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
/**
 *  名称
 */
@property(nonatomic,strong)NSString *name;

/**
 *  作者
 */
@property(nonatomic,strong)NSString *author;

/**
 *  主人
 */
@property(nonatomic,strong)NSString *owner;

/**
 *  购买商家
 */
@property(nonatomic,strong)NSString *origin;

/**
 *  购买时间
 */
@property(nonatomic,strong)NSString *buydate;

/**
 *  图书描述
 */
@property(nonatomic,strong)NSString *descripe;

/**
 *  创建时间
 */
@property(nonatomic,assign)NSInteger createtime;

/**
 *  更新时间
 */
@property(nonatomic,assign)NSInteger updatetime;

/**
 *  code编码
 */
@property(nonatomic,strong)NSString *code;




@end
