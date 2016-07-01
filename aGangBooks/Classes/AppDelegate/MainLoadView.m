//
//  MainLoadView.m
//  CityDiscount
//
//  Created by 全程恺 on 15/8/12.
//  Copyright (c) 2015年 Danfort. All rights reserved.
//

#import "MainLoadView.h"
#import "BaseLoadViewPage.h"

@implementation MainLoadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _sc = [UIScrollView new];
        _sc.pagingEnabled = YES;
        _sc.bounces = NO;
        _sc.showsHorizontalScrollIndicator = NO;
        _sc.delegate = self;
        [self addSubview:_sc];
        
        UIView *container = [UIView new];
        [_sc addSubview:container];
        
        [_sc mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self);
        }];
        
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(_sc);
            make.height.equalTo(_sc);
        }];
        
        UIView *lastView;
        for (int i = 0; i < 3; i++) {
            
            BaseLoadViewPage *view = [[BaseLoadViewPage alloc] initWithPage:[@(i + 1) stringValue]];
            view.tag = i + 1;
            [container addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.size.equalTo(_sc);
                make.top.equalTo(_sc);
                make.left.equalTo(lastView ? lastView.mas_right : _sc);
            }];
            
            lastView = view;
            
            if (i == 3 - 1) {
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setTitle:@"开始体验" forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor redColor];
                btn.layer.cornerRadius = 4;
                btn.layer.masksToBounds = YES;
                [view addSubview:btn];
                
                [btn addTarget:self action:@selector(beginButtonAction) forControlEvents:UIControlEventTouchUpInside];
                
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.size.mas_equalTo(CGSizeMake(92, 42));
                    make.bottom.equalTo(view).offset(-30);
                    make.centerX.equalTo(view);
                }];
            }
        }
        
        _pageC = [UIPageControl new];
        _pageC.numberOfPages = 3;
        _pageC.currentPageIndicatorTintColor = [UIColor blueColor];
        _pageC.pageIndicatorTintColor = [UIColor grayColor];
        
        [self addSubview:_pageC];
        
        [_pageC mas_makeConstraints:^(MASConstraintMaker *make) {
            
//            make.size.mas_equalTo(CGSizeMake(95, 14));
            make.width.equalTo(self);
            make.height.mas_equalTo(_pageC.height);
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(-11);
        }];
        
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(lastView.mas_right);
        }];
    }
    
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.width;
    
    _pageC.currentPage = page;
    
//    CGRect visibleFrame = CGRectMake(scrollView.contentOffset.x, 0, scrollView.width, scrollView.height);
//    for (int i = 0; i < 3; i++) {
//        
//        BaseLoadViewPage *loadView = (BaseLoadViewPage *)[scrollView viewWithTag:i + 1];
//        
//        [NSObject cancelPreviousPerformRequestsWithTarget:loadView];
//        if (CGRectIntersectsRect(loadView.frame, visibleFrame) && [loadView respondsToSelector:@selector(show)]) {
//            
//            [loadView performSelector:@selector(show) withObject:nil afterDelay:.2];
//        }
//        else if ([loadView respondsToSelector:@selector(hide)]){
//            
//            [loadView performSelector:@selector(hide)];
//        }
//    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    for (int i = 0; i < 5; i++) {
//        
//        BaseLoadViewPage *loadView = (BaseLoadViewPage *)[_sc viewWithTag:i + 1];
//        
//        [NSObject cancelPreviousPerformRequestsWithTarget:loadView];
//        if (i == 0 && [loadView respondsToSelector:@selector(show)]) {
//            
//            [loadView performSelector:@selector(show) withObject:nil afterDelay:.2];
//        }
//        else if ([loadView respondsToSelector:@selector(hide)]){
//            
//            [loadView performSelector:@selector(hide)];
//        }
//    }
}

- (void)beginButtonAction
{
    if (self.BeginAction) {
        
        self.BeginAction();
    }
}


@end
