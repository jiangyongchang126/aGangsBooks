//
//  AddAndUpdateViewController.m
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/6.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "AddAndUpdateViewController.h"

@interface AddAndUpdateViewController ()<AddUpdateBookDelegate>

{
    
    AddUpdateTableView *_addUpdateTV;
}

@end

@implementation AddAndUpdateViewController

- (instancetype)init
{
    if (self = [super init]) {
        
        self.title = @"添加";
        
        
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.title = @"添加";
}

-(void)addSubviews{
    
    [super addSubviews];
    
    _addUpdateTV = [[AddUpdateTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _addUpdateTV.addUpdateDelegate = self;
    _addUpdateTV.book = self.book;
    
    [self.view addSubview:_addUpdateTV];
    
}

-(void)updateAL{
    
    [_addUpdateTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.view).offset(0);
        
        make.top.equalTo(self.view).offset(64);
    }];
}

-(void)popToLastContorller{
    
    [self.navigationController popViewControllerAnimated:YES];
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
