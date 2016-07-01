//
//  MainTableView.h
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/6.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "BaseRefreshTableView.h"
#import "Book.h"

@protocol MainTabelDelegate <NSObject>

- (void)passValueToControllerWithBook:(Book *)book;

@end

@interface MainTableView : BaseRefreshTableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)id<MainTabelDelegate> mainTableDelegate;

@end
