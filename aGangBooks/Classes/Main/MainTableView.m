//
//  MainTableView.m
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/6.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "MainTableView.h"
#import "MainTableViewCell.h"

@implementation MainTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];

        self.from = 0;
        
    }
    
    return self;
}

-(void)loadData{
    
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"start",@"20",@"limit", nil];
    
    NSDictionary *dict = @{@"start":[@(self.bagPage) stringValue],
                           @"limit":@"15"};


    [URLModel requestWithURL:@"/getBookList" params:dict request_id:@"1433740476551" completedBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"responseObject:%@",responseObject);
        
        if ([responseObject[@"status"] integerValue] == 0) {
            
            
            self.totalNum = [responseObject[@"result"][@"count"] integerValue];
            
            
            if (self.header.isRefreshing) {
                
                [self.dataArr removeAllObjects];
            }
            
            for (NSDictionary *resDic in responseObject[@"result"][@"results"]) {
                
                Book *book = [Book new];
                
                [book setValuesForKeysWithDictionary:resDic];
                
                
                
                
                if (self.dataArr.count >= self.totalNum) {

                    break;
                }
                
                [self.dataArr addObject:book];
            
                
                NSLog(@"model.status:%@",book.name);
            }
            
            NSLog(@"dataArr....%ld",self.dataArr.count);
            NSLog(@"dataArr....%@",self.dataArr);
            
            
            self.hidden = !self.dataArr.count;
            
            [self reloadData];
            
            if (self.dataArr.count >= self.totalNum) {
                
                [Helper tipMessage:@"没有更多数据了！\n\n😊😊😊" afterDelay:1.0 completion:nil];
            }
            
            [self.header endRefreshing];
            [self.footer endRefreshing];

        }else{
            
            [Helper tipMessage:@"请求异常" afterDelay:1.2 completion:nil];

        }
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        [self.header endRefreshing];
        [self.footer endRefreshing];

    } fromClassName:NSStringFromClass([self class])];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        
    }
    
    cell.book = self.dataArr[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 39;
}

// 修改 删除按钮
-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                         title:@"删除"
                                                                       handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                           
                                                                           
                                                                           Book *book = self.dataArr[indexPath.row];
                                                                           
                                                                           NSDictionary *dic = @{@"code":book.code};
                                                                           
                                                                           [URLModel requestWithURL:DELETEBOOK params:dic request_id:REQUESTID completedBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                               
                                                                               
                                                                               if ([responseObject[@"status"] integerValue] == 0) {
                                                                                   
                                                                                   [Helper tipMessage:@"删除成功" afterDelay:1.2 completion:^{
                                                                                       
                                                                                       [self.dataArr removeObjectAtIndex:indexPath.row];
                                                                                       
                                                                                       
                                                                                       [self.header beginRefreshing];
                                                                                       
                                                                                       
                                                                                       
                                                                                   }];
                                                                               }else{
                                                                                   
                                                                                   [Helper tipMessage:@"删除异常" afterDelay:1.2 completion:nil];
                                                                               }


                                                       
                                                                               
                                                                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                               
                                                                           } fromClassName:NSStringFromClass([self class])];
                                                                           
                                                                           
                                                                           
                                                                           
                                                                       }];
    UITableViewRowAction *rowActionSec = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                            title:@"修改"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                              NSLog(@"修改...");
                                                                              Book *book = self.dataArr[indexPath.row];
                                                                              


                                                                              if ([self.mainTableDelegate respondsToSelector:@selector(passValueToControllerWithBook:)]) {
                                                                                  

                                                                                  [self.mainTableDelegate passValueToControllerWithBook:book];
                                                                              }
                                                                              
                                                                              
                                                                          }];
    
//    UITableViewRowAction *minRow = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
//                                                                            title:nil
//                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//                                                                              
//                                                                          }];
    
    rowAction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"delege"]];
    rowActionSec.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"change"]];
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

//    minRow.backgroundColor = [UIColor clearColor];
    
    NSArray *arr = @[rowAction,rowActionSec];
    return arr;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//
//
//
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//
//        Book *book = self.dataArr[indexPath.row];
//
//        NSDictionary *dic = @{@"code":book.code};
//
//
//        [URLModel requestWithURL:DELETEBOOK params:dic request_id:REQUESTID completedBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//            [self.dataArr removeObjectAtIndex:indexPath.row];
//            
//            [self reloadData];
//
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//        } fromClassName:NSStringFromClass([self class])];
//
//    }
//}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
