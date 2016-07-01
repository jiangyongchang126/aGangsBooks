//
//  AddTableViewCell.h
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/6.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface AddTableViewCell : UITableViewCell
{
    UIView *_bgView;
    UILabel *_leftLB;
//    UITextField *_rightTF;
}

@property(nonatomic,strong)Book *book;
@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)UITextField *rightTF;

@end
