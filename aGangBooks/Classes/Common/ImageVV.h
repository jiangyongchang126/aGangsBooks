//
//  ImageVV.h
//  UITableView1
//
//  Created by 蒋永昌 on 15/12/13.
//  Copyright © 2015年 蒋永昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageVV : UIImageView

{
    id _target;
    SEL _action;
}


-(void)MyTarget:(id)target Action:(SEL)action;


@end
