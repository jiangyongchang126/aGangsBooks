//
//  ImageVV.m
//  UITableView1
//
//  Created by 蒋永昌 on 15/12/13.
//  Copyright © 2015年 蒋永昌. All rights reserved.
//

#import "ImageVV.h"

@implementation ImageVV

-(void)MyTarget:(id)target Action:(SEL)action{
    
    _target = target;
    _action  = action;
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([_target respondsToSelector:_action]) {
        
        [_target performSelector:_action withObject:self];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
