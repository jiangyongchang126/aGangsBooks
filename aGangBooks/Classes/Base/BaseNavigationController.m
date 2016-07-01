//
//  BaseNavigationController.m
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/11.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseViewController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.delegate = self;
    
    //设置导航栏标题格式
    NSDictionary * dict =  [NSDictionary dictionaryWithObjectsAndKeys:
                            [UIColor whiteColor], NSForegroundColorAttributeName,
                            [UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil];
    self.navigationBar.titleTextAttributes = dict;
    
    //导航栏背景透明
    UIImage *image = [UIImage new];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:image];
    
    
    // Do any additional setup after loading the view.
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
//    if (navigationController.viewControllers.count > 1) {
//        
//        if (![NSStringFromClass([viewController class]) isEqualToString:@"IssueFeedbackViewController"] &&
//            ![NSStringFromClass([viewController class]) isEqualToString:@"MatchOrderResultViewController"]
//            ) {
//            
//            //左上角返回按钮
//            UIImage *backImg = [UIImage imageNamed:@"icon_back"];
//            UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [backBtn setImage:backImg forState:UIControlStateNormal];
//            backBtn.frame = CGRectMake(0, 0, backImg.size.width + 24, backImg.size.height + 24);
//            [backBtn addTarget:(BaseViewController *)viewController action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//        }
//        else
//        {
//            UIView *blankView = [UIView new];
//            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:blankView];
//        }
//    }
//    if ([NSStringFromClass([viewController class]) isEqualToString:@"ChatListViewController"]){
//        //左上角返回按钮
//        UIImage *backImg = [UIImage imageNamed:@"icon_back"];
//        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backBtn setImage:backImg forState:UIControlStateNormal];
//        [backBtn setTitle:@"我的消息" forState:UIControlStateNormal];
//        backBtn.frame = CGRectMake(0, 0, backImg.size.width + 80, backImg.size.height + 24);
//        [backBtn addTarget:(BaseViewController *)viewController action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    }

    
    
    if ([NSStringFromClass([viewController class]) isEqualToString:@"AddAndUpdateViewController"]) {
        
        //左上角返回按钮
        UIImage *backImg = [UIImage imageNamed:@"icon_back"];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:backImg forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, backImg.size.width + 24, backImg.size.height + 24);
        [backBtn addTarget:(BaseViewController *)viewController action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
