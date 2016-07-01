//
//  MainTableViewCell.h
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/6.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface MainTableViewCell : UITableViewCell

{
    
    UIView *_bgView;
    UILabel *_leftLB;
    UIImageView *_imageV;

}

@property(nonatomic,strong)Book *book;

@end
