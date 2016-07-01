//
//  BaseRefreshTableView.m
//  crc
//
//  Created by 全程恺 on 15/2/5.
//  Copyright (c) 2015年 Danfort. All rights reserved.
//

#import "BaseRefreshTableView.h"

@implementation BaseRefreshTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        
        _dataArr = [NSMutableArray array];
        
        self.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        
        self.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return self;
}

- (void)loadNewData
{
    self.page = self.from;
    self.bagPage = self.from;
    [self loadData];
}

- (void)loadMoreData
{

    self.page++;
    self.bagPage += 15;
    
    [self loadData];
}

- (void)loadData
{
    
}

- (void)setTotalNum:(NSInteger)totalNum
{
    _totalNum = totalNum;
    
    if (_dataArr.count >= _totalNum) {
        
        [self.footer endRefreshingWithNoMoreData];
        
    }
    else
        [self.footer resetNoMoreData];
}

@end
