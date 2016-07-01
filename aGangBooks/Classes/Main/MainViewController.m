//
//  MainViewController.m
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/6.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "MainViewController.h"
#import "AddAndUpdateViewController.h"
#import "MainTableView.h"
#import "MainLoadView.h"

@interface MainViewController ()<MainTabelDelegate>
{
    MainTableView *_mainTV;
//    MainLoadView *_loadView;
//    UILabel *_titleLB;

}

@property(nonatomic,strong)UIWebView *myWebView;

@property (retain, nonatomic) UIView *topView;


@end

@implementation MainViewController

- (instancetype)init
{
    if (self = [super init]) {
        
        self.title = @"书籍列表";
        
    }
    
    return self;
}



-(void)addSubviews{
    
    [super addSubviews];
    
    [self.view addSubview:self.topView];

    _mainTV = [[MainTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _mainTV.mainTableDelegate = self;
    [_mainTV.header beginRefreshing];
    
    [self.view addSubview:_mainTV];
    
    
}

-(void)updateAL{
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(20 - kStatusBarHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kNavHeight - (20 - kStatusBarHeight));
    }];
    
    [_mainTV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.view).offset(0);
        
        make.top.equalTo(self.view).offset(64);
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    [self newfeature];


}


////新版本的时候显示引导页
//- (void)newfeature
//{
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
//    // 2.1.先去沙盒中取出上次使用的版本号
//    NSString *lastVersionCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"Version"];
//    if (![lastVersionCode isEqualToString:currentVersion]) {
//        
////        [UIApplication sharedApplication].statusBarHidden = YES;
//    self.navigationController.navigationBarHidden=YES;
//
//
//        //同步账号数据
//        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"Version"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    
//        __unsafe_unretained MainViewController *this = self;
//        _loadView = [MainLoadView new];
//        _loadView.BeginAction =^(){
//            
//            [this -> _loadView removeFromSuperview];
//            this -> _loadView = nil;
////            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
//            this.navigationController.navigationBarHidden=NO;
//
//        };
//        [self.view addSubview:_loadView];
//        
//        [_loadView mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.edges.equalTo(self.view);
//        }];
//    }
//}


-(void)passValueToControllerWithBook:(Book *)book{
    
    AddAndUpdateViewController *addAndUpdateVC = [[AddAndUpdateViewController alloc]init];
    addAndUpdateVC.book = book;
    
    [self.navigationController pushViewController:addAndUpdateVC animated:YES];
}

- (void)pushAddBookAction:(UIBarButtonItem *)sender{
    
    AddAndUpdateViewController *addAndUpdateVC = [[AddAndUpdateViewController alloc]init];
    addAndUpdateVC.book = [Book new];
    [self.navigationController pushViewController:addAndUpdateVC animated:YES];

}


-(UIView *)topView{
    
    if (!_topView) {
        
        UIView *topView = [UIView new];
        
       UILabel *_titleLB = [UILabel new];
        _titleLB.font = [UIFont boldSystemFontOfSize:20];
        _titleLB.backgroundColor = [UIColor clearColor];
        _titleLB.textAlignment = NSTextAlignmentCenter;
        _titleLB.text = self.title;
        _titleLB.textColor = [UIColor whiteColor];
        [topView addSubview:_titleLB];
        
        //加入右上角加号显示
        
         UIImage *messageImg = [UIImage imageNamed:@"icon_add"];
         UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         messageBtn.hidden = NO;
         [messageBtn setImage:messageImg forState:UIControlStateNormal];
        [messageBtn addTarget:self action:@selector(pushAddBookAction:) forControlEvents:UIControlEventTouchUpInside];
         
         [topView addSubview:messageBtn];
        
        [topView addSubview:_titleLB];
        
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(topView);
        }];
        
         [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         
         make.size.mas_equalTo(CGSizeMake(messageImg.size.width + 16, messageImg.size.height + 12));
         make.bottom.equalTo(topView).offset(-3);
         make.right.equalTo(topView).offset(-10);
         }];
        
        _topView = topView;
    }
    
    return _topView;
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
