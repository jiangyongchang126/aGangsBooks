//
//  BaseLoadViewPage.h
//  CityDiscount
//
//  Created by 全程恺 on 15/8/12.
//  Copyright (c) 2015年 Danfort. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseLoadViewPage : UIView
{
    UIImageView *_bgView;
}
- (instancetype)initWithPage:(NSString *)page;
@end
