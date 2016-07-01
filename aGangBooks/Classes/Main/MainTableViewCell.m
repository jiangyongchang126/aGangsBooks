//
//  MainTableViewCell.m
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/6.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 4;
        _bgView.layer.masksToBounds = YES;
        [self.contentView addSubview:_bgView];
        
        
        _leftLB = [UILabel new];
        _leftLB.backgroundColor = [UIColor clearColor];
        [_bgView addSubview:_leftLB];
        
        
        
        _imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_next"]];
        [_bgView addSubview:_imageV];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(4, 4, 0, 4));
//            make.top.equalTo(self.contentView).offset(4);
//            make.right.equalTo(self.contentView).offset(-4);
//            make.size.mas_equalTo(CGSizeMake(self.frame.size.width-8, 35));
        }];
        
//        _bgView.frame = CGRectMake(4, 4, self.frame.size.width-8, 35);
        

        [_leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_bgView).offset(5);
            make.top.equalTo(_bgView);
            make.width.mas_equalTo(280);
            make.height.mas_equalTo(35);
        }];
        
        
        
        
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.size.mas_equalTo(CGSizeMake(6, 13));
            make.centerY.mas_equalTo(_leftLB);
            make.right.equalTo(_bgView).offset(-4);
            
        }];
        
    }
    
    return self;
}

-(void)layoutSubviews{
    

//    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        //            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(4, 4, 0, 4));
//        make.top.equalTo(self.contentView).offset(4);
//        make.right.equalTo(self.contentView).offset(-4);
//        make.size.mas_equalTo(CGSizeMake(self.contentView.frame.size.width-8, 35));
//    }];
    
//
//    //        _bgView.frame = CGRectMake(4, 4, self.frame.size.width-8, 35);
//    
//    
//    [_leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(_bgView).offset(5);
//        make.top.equalTo(_bgView);
//        make.width.mas_equalTo(280);
//        make.height.mas_equalTo(35);
//    }];
//    
//    
//    
//    
//    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.size.mas_equalTo(CGSizeMake(6, 13));
//        make.centerY.mas_equalTo(_leftLB);
//        make.right.equalTo(_bgView).offset(-4);
//        
//    }];
}

-(void)setBook:(Book *)book{
    
    _leftLB.text = book.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
