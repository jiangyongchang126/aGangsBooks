//
//  AddUpdateTableView.h
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/6.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@protocol AddUpdateBookDelegate <NSObject>

- (void)popToLastContorller;

@end

@interface AddUpdateTableView : UITableView<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,assign)id<AddUpdateBookDelegate> addUpdateDelegate;

@property(nonatomic,strong)Book *book;

@end
