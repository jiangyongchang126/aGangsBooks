//
//  TabbarRootViewController.m
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/11.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "TabbarRootViewController.h"
#import "MainLoadView.h"


@interface TabbarRootViewController ()<UITabBarControllerDelegate,UITabBarDelegate,UIAlertViewDelegate>
{
    MainLoadView *_loadView;
}

@end

@implementation TabbarRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addViewControllers];
    
////    //修改背景色
//    UIView *backView = [UIView new];
//    backView.backgroundColor = [UIColor whiteColor];
//    
//    [self.tabBar insertSubview:backView atIndex:0];
//    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.right.bottom.equalTo(self.view);
//        make.height.mas_equalTo(49);
//    }];
//    
//    self.tabBar.tintColor = [UIColor blueColor];
    
    self.delegate = self;

    
    [self newfeature];

    // Do any additional setup after loading the view.
}

- (void)addViewControllers{
    
    
    //OrderViewController
    NSArray *controllers = @[@"MainViewController", @"MineViewController"];
    NSArray *titles = @[@"首页",@"个人中心"];
    NSArray *icons = @[@"home", @"mine"];
    

    NSMutableArray *tabControllers = [NSMutableArray new];
    for (int i = 0; i < controllers.count; i++) {
        
        UITabBarItem *item = [[UITabBarItem alloc] init];
        item.tag = i + 1;
        
        [item setTitle:titles[i]];
        
        if (IOS7_OR_LATER)
        {
            [item setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%@", icons[i]]]];
            NSString *selIcon = [NSString stringWithFormat:@"icon_%@_s", icons[i]];
            UIImage *selImage = [UIImage imageNamed:selIcon];
            [item setSelectedImage:[selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
        else
        {
            [item setFinishedSelectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%@", icons[i]]]
               withFinishedUnselectedImage:[[UIImage imageNamed:[NSString stringWithFormat:@"icon_%@_s", icons[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
        
        UIViewController *controller = [[NSClassFromString(controllers[i]) alloc]init];
        controller.tabBarItem = item;
        [controller.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
        [controller.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
        
        
        [tabControllers addObject:controller];
    }
    
    self.viewControllers = tabControllers;

}

//新版本的时候显示引导页
- (void)newfeature
{
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    // 2.1.先去沙盒中取出上次使用的版本号
    NSString *lastVersionCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"Version"];
    if (![lastVersionCode isEqualToString:currentVersion]) {
    
//                [UIApplication sharedApplication].statusBarHidden = YES;
    
        
        //同步账号数据
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"Version"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
        __unsafe_unretained TabbarRootViewController *this = self;
        _loadView = [MainLoadView new];
        _loadView.BeginAction =^(){
            
            [this -> _loadView removeFromSuperview];
            this -> _loadView = nil;
//            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
            
        };
        [self.view addSubview:_loadView];
        
        [_loadView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.view);
        }];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
//    if ([NSStringFromClass([viewController class]) isEqualToString:@"MineViewController"]) {
//        
//       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"尚未开通此功能" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:@"好的", nil];
//        [alert show];
//        
//        return NO;
//    }
    return YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
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
