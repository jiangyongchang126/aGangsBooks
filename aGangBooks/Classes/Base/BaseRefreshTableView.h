//
//  BaseRefreshTableView.h
//  crc
//
//  Created by 全程恺 on 15/2/5.
//  Copyright (c) 2015年 Danfort. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseRefreshTableView : UITableView

@property (retain, nonatomic) NSMutableArray *dataArr;
@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger bagPage;
@property (assign, nonatomic) NSInteger totalNum;
@property (assign, nonatomic) NSInteger from;

- (void)loadData;

@end
