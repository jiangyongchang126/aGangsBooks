//
//  MainLoadView.h
//  CityDiscount
//
//  Created by 全程恺 on 15/8/12.
//  Copyright (c) 2015年 Danfort. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainLoadView : UIView <UIScrollViewDelegate>
{
    UIPageControl *_pageC;
    UIScrollView *_sc;
}

@property (copy, nonatomic) void (^BeginAction)(void);

@end
