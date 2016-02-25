//
//  SelectedCondition.m
//  Shopping
//
//  Created by 聂自强 on 16/1/4.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "SelectedCondition.h"
#import "Common.h"

@interface SelectedCondition (){
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    
    UIView *heardView;
    UIView *selectedView;
    
    
    UIView *line1;
    UIView *line2;
    
    UIButton *btn1_1;
    UIButton *btn1_2;
    UIButton *btn1_3;
    

}

@end


@implementation SelectedCondition

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        _index = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
        
        heardView = [[UIView alloc]init];
        heardView.backgroundColor = [UIColor whiteColor];
        [self addSubview:heardView];
        
        btn1 = [[UIButton alloc]init];
        [btn1 setTitle:@"综合排序" forState:UIControlStateNormal];
        [btn1 setTitleColor:mainColor forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:11];
        btn1.titleLabel.textAlignment  = NSTextAlignmentCenter;
        [btn1 setImage:[UIImage imageNamed:@"icon_arrows_red_down"] forState:UIControlStateNormal];
        [btn1 setImage:[UIImage imageNamed:@"icon_arrows_red_down"] forState:UIControlStateHighlighted];
        btn1.imageEdgeInsets = UIEdgeInsetsMake(0, 58, 0, -58);
        
        
        
        [btn1 addTarget:self action:@selector(tap1) forControlEvents:UIControlEventTouchUpInside];
        [heardView addSubview:btn1];
        
        btn2 = [[UIButton alloc]init];
        [btn2 setTitle:@"销量优先" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn2.titleLabel.font = [UIFont systemFontOfSize:11];
        btn3.titleLabel.textAlignment  = NSTextAlignmentCenter;
        [btn2 addTarget:self action:@selector(tap2) forControlEvents:UIControlEventTouchUpInside];
        [heardView addSubview:btn2];
        
        btn3 = [[UIButton alloc]init];
        [btn3 setTitle:@"价格" forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn3.titleLabel.font = [UIFont systemFontOfSize:11];
        btn3.titleLabel.textAlignment  = NSTextAlignmentCenter;
        
        [btn3 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateNormal];
        [btn3 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateHighlighted];
        btn3.imageEdgeInsets = UIEdgeInsetsMake(0, 34, 0, -34);
        [btn3 addTarget:self action:@selector(tap3) forControlEvents:UIControlEventTouchUpInside];
        [heardView addSubview:btn3];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 24, MainW, 0.3)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [heardView addSubview:lineView];
        
        
        selectedView = [[UIView alloc]init];
        selectedView.backgroundColor = [UIColor whiteColor];
        btn1_1 = [[UIButton alloc]init];
        [btn1_1  setTitle:@"综合排序" forState:UIControlStateNormal];
        [btn1_1 setTitleColor:mainColor forState:UIControlStateNormal];
        btn1_1.titleLabel.font = [UIFont systemFontOfSize:11];
        btn1_1.titleLabel.textAlignment  = NSTextAlignmentLeft;
        btn1_1.titleEdgeInsets  = UIEdgeInsetsMake(0, -100, 0, 100);
        btn1_1.imageEdgeInsets = UIEdgeInsetsMake(0, 140, 0, -140);
        [btn1_1 setImage:[UIImage imageNamed:@"icon_check_03"] forState:UIControlStateNormal];
        [btn1_1 setImage:[UIImage imageNamed:@"icon_check_03"] forState:UIControlStateHighlighted];
        
        btn1_2 = [[UIButton alloc]init];
        [btn1_2  setTitle:@"最新发布" forState:UIControlStateNormal];
        [btn1_2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn1_2.titleLabel.font = [UIFont systemFontOfSize:11];
        btn1_2.titleLabel.textAlignment  = NSTextAlignmentLeft;
        btn1_2.titleEdgeInsets  = UIEdgeInsetsMake(0, -100, 0, 100);
        btn1_2.imageEdgeInsets = UIEdgeInsetsMake(0, 140, 0, -140);
        [btn1_2 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateNormal];
        [btn1_2 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateHighlighted];
        
        btn1_3 = [[UIButton alloc]init];
        [btn1_3  setTitle:@"用户评分" forState:UIControlStateNormal];
        [btn1_3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn1_3.titleLabel.font = [UIFont systemFontOfSize:11];
        btn1_3.titleLabel.textAlignment  = NSTextAlignmentLeft;
        btn1_3.titleEdgeInsets  = UIEdgeInsetsMake(0, -100, 0, 100);
        btn1_3.imageEdgeInsets = UIEdgeInsetsMake(0, 140, 0, -140);
        [btn1_3 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateNormal];
        [btn1_3 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateHighlighted];
        
        
        [btn1_1 addTarget:self action:@selector(tap1_1) forControlEvents:UIControlEventTouchUpInside];
        [btn1_2 addTarget:self action:@selector(tap1_2) forControlEvents:UIControlEventTouchUpInside];
        [btn1_3 addTarget:self action:@selector(tap1_3) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        line1 = [[UIView alloc]init];
        line1.backgroundColor = [UIColor lightGrayColor];
        line2 = [[UIView alloc]init];
        line2.backgroundColor = [UIColor lightGrayColor];
        
        [selectedView addSubview:btn1_1];
        [selectedView addSubview:btn1_2];
        [selectedView addSubview:btn1_3];
        [selectedView addSubview:line1];
        [selectedView addSubview:line2];

        selectedView.frame = CGRectMake(0, 25, MainW, 74);
        btn1_1.frame = CGRectMake(0, 0, MainW, 24);
        btn1_2.frame = CGRectMake(0, 24, MainW, 24);
        btn1_3.frame = CGRectMake(0, 49, MainW, 24);
        line1.frame = CGRectMake(0, 24, MainW, 0.2);
        line2.frame = CGRectMake(0, 49, MainW, 0.2);
        selectedView.hidden = YES;
        
        
        [self addSubview:selectedView];
        
        
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat margin = 20;
    CGFloat btnW = (MainW - 20 * 4) /3;
    heardView.frame = CGRectMake(0, 0, MainW, 25);
    btn1.frame = CGRectMake(margin, 0, btnW, 24);
    btn2.frame = CGRectMake(margin*2 + btnW +20, 0, btnW, 24);
    btn3.frame = CGRectMake(margin*3 + btnW*2, 0, btnW, 24);
    
    


}

#pragma mark -- Action

- (void)tap{
    self.height = 25;
    selectedView.hidden = YES;
}

- (void)tap1{
    if (self.height < MainH) {
        self.height = MainH;
        selectedView.hidden = NO;
        if (_index == 0 || _index == 6||_index == 8) {
            
            [btn1 setImage:[UIImage imageNamed:@"icon_arrows_red_up"] forState:UIControlStateNormal];
            [btn1 setImage:[UIImage imageNamed:@"icon_arrows_red_up"] forState:UIControlStateHighlighted];
        }else{
            [btn1 setImage:[UIImage imageNamed:@"icon_arrows_gray_up"] forState:UIControlStateNormal];
            [btn1 setImage:[UIImage imageNamed:@"icon_arrows_gray_up"] forState:UIControlStateHighlighted];
        }
        
    }else{
        self.height = 25;
        selectedView.hidden = YES;
        
        if (_index == 0 || _index == 6||_index == 8) {
            [btn1 setImage:[UIImage imageNamed:@"icon_arrows_red_down"] forState:UIControlStateNormal];
            [btn1 setImage:[UIImage imageNamed:@"icon_arrows_red_down"] forState:UIControlStateHighlighted];
        }else{
            [btn1 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateNormal];
            [btn1 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateHighlighted];
        }
        
    }
    

    

}
- (void)tap2{
    [btn2 setTitleColor:mainColor forState:UIControlStateNormal];
    self.height = 25;
    selectedView.hidden = YES;
    [btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateHighlighted];
    
    
    [btn3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateHighlighted];
    
    [btn1_1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1_1 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateNormal];
    [btn1_1 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateHighlighted];
    [btn1_2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1_2 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateNormal];
    [btn1_2 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateHighlighted];
    [btn1_3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1_3 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateNormal];
    [btn1_3 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateHighlighted];
    _index = 4;
    
    [self.delegate seletedChangeWithIndex:_index];
}
- (void)tap3{
    
    [btn3 setTitleColor:mainColor forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"icon_arrows_red_down"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"icon_arrows_red_down"] forState:UIControlStateHighlighted];
    self.height = 25;
    selectedView.hidden = YES;
    [btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateHighlighted];
    [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [btn1_1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1_1 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateNormal];
    [btn1_1 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateHighlighted];
    [btn1_2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1_2 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateNormal];
    [btn1_2 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateHighlighted];
    [btn1_3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1_3 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateNormal];
    [btn1_3 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateHighlighted];
    _index = 2;
    [self.delegate seletedChangeWithIndex:_index];
}

- (void)tap1_1{
    self.height = 25;
    selectedView.hidden = YES;
    
    [btn1_1 setTitleColor:mainColor forState:UIControlStateNormal];
    [btn1_1 setImage:[UIImage imageNamed:@"icon_check_03"] forState:UIControlStateNormal];
    [btn1_1 setImage:[UIImage imageNamed:@"icon_check_03"] forState:UIControlStateHighlighted];
    [btn1_2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1_2 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateNormal];
    [btn1_2 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateHighlighted];
    [btn1_3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1_3 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateNormal];
    [btn1_3 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateHighlighted];
    

    [btn1 setTitle:@"综合排序" forState:UIControlStateNormal];
    [btn1 setTitleColor:mainColor forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"icon_arrows_red_down"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"icon_arrows_red_down"] forState:UIControlStateHighlighted];
    
    [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateHighlighted];
    
    _index = 0;
    [self.delegate seletedChangeWithIndex:_index];
}

- (void)tap1_2{
    
    
    [btn1_2 setTitleColor:mainColor forState:UIControlStateNormal];
    [btn1_2 setImage:[UIImage imageNamed:@"icon_check_03"] forState:UIControlStateNormal];
    [btn1_2 setImage:[UIImage imageNamed:@"icon_check_03"] forState:UIControlStateHighlighted];
    [btn1_1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1_1 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateNormal];
    [btn1_1 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateHighlighted];
    [btn1_3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1_3 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateNormal];
    [btn1_3 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateHighlighted];
    
    [btn1 setTitle:@"最新发布" forState:UIControlStateNormal];
    [btn1 setTitleColor:mainColor forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"icon_arrows_red_down"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"icon_arrows_red_down"] forState:UIControlStateHighlighted];
    
    [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateHighlighted];
    self.height = 25;
    selectedView.hidden = YES;
    _index = 6;
    [self.delegate seletedChangeWithIndex:_index];
    
}
- (void)tap1_3{
    
    [btn1_3 setTitleColor:mainColor forState:UIControlStateNormal];
    [btn1_3 setImage:[UIImage imageNamed:@"icon_check_03"] forState:UIControlStateNormal];
    [btn1_3 setImage:[UIImage imageNamed:@"icon_check_03"] forState:UIControlStateHighlighted];
    [btn1_1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1_1 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateNormal];
    [btn1_1 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateHighlighted];
    [btn1_2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1_2 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateNormal];
    [btn1_2 setImage:[UIImage imageNamed:@"citySelectArrow"] forState:UIControlStateHighlighted];
    
    [btn1 setTitle:@"评价优先" forState:UIControlStateNormal];
    [btn1 setTitleColor:mainColor forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"icon_arrows_red_down"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"icon_arrows_red_down"] forState:UIControlStateHighlighted];
    
    [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"icon_arrows_gray_down"] forState:UIControlStateHighlighted];
    self.height = 25;
    selectedView.hidden = YES;
    _index = 8;
    [self.delegate seletedChangeWithIndex:_index];
    
}



@end
