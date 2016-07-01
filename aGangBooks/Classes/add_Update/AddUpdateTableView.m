//
//  AddUpdateTableView.m
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/6.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "AddUpdateTableView.h"
#import "AddTableViewCell.h"

@interface AddUpdateTableView ()

@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *placeholderArray;

@property(nonatomic,strong)UIButton *footBtn;

@end

@implementation AddUpdateTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        
        self.titleArray = @[@"名称",@"作者",@"主人",@"购买商家",@"购买时间",@"图片描述"];
        self.placeholderArray = @[@"book name",@"book author",@"book owner",@"book origin",@"book buydate",@"book descripe"];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    }
    
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[AddTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.title = self.titleArray[indexPath.row];
    cell.rightTF.placeholder = self.placeholderArray[indexPath.row];
    cell.rightTF.tag = 1000+indexPath.row;
    cell.rightTF.delegate = self;
    
    switch (indexPath.row) {
        case 0:
            cell.rightTF.text = self.book.name;
            break;
        case 1:
            cell.rightTF.text = self.book.author;
            break;
        case 2:
            cell.rightTF.text = self.book.owner;
            break;
        case 3:
            cell.rightTF.text = self.book.origin;
            break;
            
        case 4:
            cell.rightTF.text = self.book.buydate;
            break;
        case 5:
            cell.rightTF.text = self.book.descripe;
            break;

        default:
            break;
    }
    
    return cell;
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(AddTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    
//    switch (indexPath.row) {
//        case 0:
//            cell.rightTF.text = self.book.name;
//            break;
//        case 1:
//            cell.rightTF.text = self.book.author;
//            break;
//        case 2:
//            cell.rightTF.text = self.book.owner;
//            break;
//        case 3:
//            cell.rightTF.text = self.book.origin;
//            break;
//            
//        case 4:
//            cell.rightTF.text = self.book.buydate;
//            break;
//        case 5:
//            cell.rightTF.text = self.book.descripe;
//            break;
//            
//        default:
//            break;
//    }
//
//}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return self.footBtn;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 30;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    AddTableViewCell *cell = (AddTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
////    UITextField *tf = (UITextField *)[cell.contentView viewWithTag:1000+indexPath.row];
//    
//    [cell.rightTF addTarget:self action:@selector(textFeildValueChange:) forControlEvents:UIControlEventValueChanged];
//    [cell.rightTF becomeFirstResponder];
//
//}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    AddTableViewCell *cell = (AddTableViewCell *)[[[textField superview] superview] superview];
    
    [cell.rightTF addTarget:self action:@selector(feildValueChange:) forControlEvents:UIControlEventEditingChanged];

}

- (void)feildValueChange:(UITextField *)textField{
    
    AddTableViewCell *cell = (AddTableViewCell *)[[[textField superview] superview] superview];
    
    NSIndexPath *currentIndexPath = [self indexPathForCell:cell];
    
    
    switch (currentIndexPath.row) {
        case 0:
            self.book.name = textField.text;
            break;
        case 1:
            self.book.author = textField.text;
            break;
        case 2:
            self.book.owner = textField.text;
            break;
        case 3:
            self.book.origin = textField.text;
            break;
            
        case 4:
            self.book.buydate = textField.text;
            break;
        case 5:
            self.book.descripe = textField.text;
            break;
            
        default:
            break;
    }

}

//-(void)textFieldDidEndEditing:(UITextField *)textField{
//
//    AddTableViewCell *cell = (AddTableViewCell *)[[[textField superview] superview] superview];
//    
//    NSIndexPath *currentIndexPath = [self indexPathForCell:cell];
//    
//    
//    switch (currentIndexPath.row) {
//        case 0:
//            self.book.name = textField.text;
//            break;
//        case 1:
//            self.book.author = textField.text;
//            break;
//        case 2:
//            self.book.owner = textField.text;
//            break;
//        case 3:
//            self.book.origin = textField.text;
//            break;
//            
//        case 4:
//           self.book.buydate = textField.text;
//            break;
//        case 5:
//            self.book.descripe = textField.text;
//            break;
//            
//        default:
//            break;
//    }
//
//}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(UIButton *)footBtn{
    
    if (!_footBtn) {
        
        _footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _footBtn.backgroundColor = [UIColor orangeColor];
        
        if (self.book.name != nil) {
            
            [_footBtn setTitle:@"更 新" forState:UIControlStateNormal];
            [_footBtn addTarget:self action:@selector(updateBookAction:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            
            [_footBtn setTitle:@"添 加" forState:UIControlStateNormal];
            [_footBtn addTarget:self action:@selector(addBookAction:) forControlEvents:UIControlEventTouchUpInside];

        }
        
        
    }
    
    return _footBtn;
}


- (void)addBookAction:(UIButton *)sender{
    
    NSDictionary *dic = @{@"owner":self.book.owner,
                          @"name":self.book.name,
                          @"author":self.book.author,
                          @"origin":self.book.origin,
                          @"buydate":self.book.buydate,
                          @"descripe":self.book.descripe
                          };
    
    [URLModel requestWithURL:ADDBOOK params:dic request_id:REQUESTID completedBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        if ([responseObject[@"status"] integerValue] == 0) {
            
            [Helper tipMessage:@"添加成功" afterDelay:1.2 completion:^{
                
                if ([self.addUpdateDelegate respondsToSelector:@selector(popToLastContorller)]) {
                    
                    [self.addUpdateDelegate popToLastContorller];
                }
            }];
        }else{
            
            [Helper tipMessage:@"删除异常" afterDelay:1.2 completion:nil];
        }


        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    } fromClassName:NSStringFromClass([self class])];

}

- (void)updateBookAction:(UIButton *)sender{
    
    NSDictionary *dic = @{@"code":self.book.code,
                          @"owner":self.book.owner,
                          @"name":self.book.name,
                          @"author":self.book.author,
                          @"origin":self.book.origin,
                          @"buydate":self.book.buydate,
                          @"descripe":self.book.descripe
                          };
    
    [URLModel requestWithURL:UPDATEBOOK params:dic request_id:REQUESTID completedBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if ([responseObject[@"status"] integerValue] == 0) {
            
            [Helper tipMessage:@"更新成功" afterDelay:1.2 completion:^{
                
                if ([self.addUpdateDelegate respondsToSelector:@selector(popToLastContorller)]) {
                    
                    [self.addUpdateDelegate popToLastContorller];
                }
            }];

        }else{
            
            [Helper tipMessage:@"删除异常" afterDelay:1.2 completion:nil];
        }

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    } fromClassName:NSStringFromClass([self class])];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
