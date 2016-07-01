//
//  BaseLoadViewPage.m
//  CityDiscount
//
//  Created by 全程恺 on 15/8/12.
//  Copyright (c) 2015年 Danfort. All rights reserved.
//

#import "BaseLoadViewPage.h"

@implementation BaseLoadViewPage

- (instancetype)initWithPage:(NSString *)page
{
    if (self = [super init]) {
        
        self.clipsToBounds = YES;
        
        _bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"guide_%@", page]]];
        _bgView.backgroundColor = [UIColor greenColor];
        [self addSubview:_bgView];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self);
        }];
    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
