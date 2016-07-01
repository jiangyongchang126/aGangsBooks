//
//  AppDelegate.h
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/6.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarRootViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

{
    NSDictionary *_appVersionInfo;
}
@property (strong, nonatomic) UIWindow *window;

@property (retain, nonatomic) TabbarRootViewController *tabRVC;



@end

