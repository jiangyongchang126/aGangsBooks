//
//  AppDelegate.m
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/6.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import <Bugtags/Bugtags.h>
#import "MainViewController.h"


@interface AppDelegate ()<UIAlertViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    
    _tabRVC = [[TabbarRootViewController alloc]init];
    
    BaseNavigationController *mainNC = [[BaseNavigationController alloc]initWithRootViewController:_tabRVC];
    
    self.window.rootViewController = mainNC;
    
    [self.window makeKeyAndVisible];
    
    _tabRVC.selectedIndex = 0;
    _tabRVC.title = @"书籍列表";
    
    
    // 测试BUG的第三方软件
    BugtagsOptions *options = [[BugtagsOptions alloc] init];
    options.trackingCrashes = YES; // 具体可设置的属性请查看 Bugtags.h
    [Bugtags startWithAppKey:@"5c383d55165052ba272e45eb3501576a" invocationEvent:BTGInvocationEventBubble options:options];

    
    
    // 检测版本号
    [self performSelector:@selector(checkVersion) withObject:nil afterDelay:1];

    
    return YES;
}

- (void)checkVersion{
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    NSLog(@"currentVersion:%@",[NSBundle mainBundle].infoDictionary);
    
    NSDictionary *params = @{@"version":currentVersion};
    
    [URLModel requestWithURL:CHECKVERSION params:params request_id:@"1465637451859" completedBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 0) {
            
            _appVersionInfo = responseObject[@"result"];
            
            //提示版本更新
            if ([_appVersionInfo[@"update"] integerValue] == 1) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"有最新版本" message:@"要更新吗？" delegate:self cancelButtonTitle:@"下次再说" otherButtonTitles:@"马上更新", nil];
                
                [alert show];
            }
 
            
        }else{
            
            [Helper tipMessage:@"请求异常" afterDelay:1.2 completion:nil];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    } fromClassName:NSStringFromClass([self class])];
    

    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        //获取最新的更新路径
        NSString *appDownloadLink = _appVersionInfo[@"app_url"];
        NSURL *url = [NSURL URLWithString:appDownloadLink];
        
        if([[UIApplication sharedApplication]canOpenURL:url])
        {
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
