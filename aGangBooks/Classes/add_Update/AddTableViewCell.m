//
//  AddTableViewCell.m
//  aGangBooks
//
//  Created by 蒋永昌 on 16/6/6.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "AddTableViewCell.h"

@implementation AddTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 4;
        _bgView.layer.masksToBounds = YES;
        [self.contentView addSubview:_bgView];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(4, 4, 0, 4));
        }];
        
        
        _leftLB = [UILabel new];
        _leftLB.backgroundColor = [UIColor clearColor];
        [_bgView addSubview:_leftLB];
        
        
        [_leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_bgView).offset(5);
            make.top.equalTo(_bgView);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(35);
        }];
        
        _rightTF = [[UITextField alloc]init];
        [_bgView addSubview:_rightTF];
        
        [_rightTF mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(_bgView);
            make.left.equalTo(_leftLB.mas_right).offset(10);
            make.height.mas_equalTo(35);
            make.right.equalTo(_bgView).offset(-5);
            
            
        }];

        
    }
    return self;
}

-(void)layoutSubviews{
    
    _leftLB.text = _title;
    
}

-(void)setBook:(Book *)book{
    
    
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
