//
//  cartDealCell.m
//  Shopping
//
//  Created by 聂自强 on 16/2/18.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "cartDealCell.h"
#import "Common.h"

@interface cartDealCell(){
    
    UIButton *_selectBtn;
    
    UIImageView *_shopImg;
    //    UIImageView *_nextImg;
    UILabel *_title;
//    UILabel *_score;
    //    UILabel *_comment_num;
//    UITextView *_descrip;
//    UILabel *_oldprice;
    UILabel *_oneprice;
    UILabel *_nowprice;
    
    UIView *line1;
    UIView *line2;
    
    UIButton *_noBtn;
    
    
    UITextField *_field;
    UIButton *_removeBtn;
    UIButton *_addBtn;
    BOOL _isA;

}
@end


@implementation cartDealCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _isA = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TapEdit:) name:@"cartEdit" object:nil];
        
        UIView *bg = [[UIView alloc]init];
        bg.backgroundColor = RGB(245, 245, 245);
        bg.frame = CGRectMake(0, 0, MainW, 10);
        [self addSubview:bg];
        
        _selectBtn = [[UIButton alloc]init];
        _selectBtn.contentMode = UIViewContentModeScaleAspectFit;
//        [_selectBtn setImage:[UIImage imageNamed:@"icon_check_01@2x"] forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(TapSelectBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selectBtn];
        
        
        _noBtn  = [[UIButton alloc]init];
        [_noBtn setTitle:@"修改优惠" forState:UIControlStateNormal];
        [_noBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _noBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_noBtn addTarget:self action:@selector(TapNoBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_noBtn];
        
        _shopImg = [[UIImageView alloc]init];
        [self addSubview:_shopImg];
        
        //        _nextImg = [[UIImageView alloc]init];
        //        [_nextImg setImage:[UIImage imageNamed:@"brower_next_0"]];
        //        [self addSubview:_nextImg];
        
        _title = [[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:10 weight:8];
        _title.textColor = [UIColor blackColor];
        [self addSubview:_title];
        
//        _score = [[UILabel alloc]init];
//        _score.font = [UIFont systemFontOfSize:12];
//        _score.textColor = RGB(250, 209, 9);
//        [self addSubview:_score];
        
        //        _comment_num = [[UILabel alloc]init];
        //        _comment_num.font = [UIFont systemFontOfSize:10];
        //        _comment_num.textColor = [UIColor lightGrayColor];
        //        [self addSubview:_comment_num];
        
//        _descrip = [[UITextView alloc]init];
//        _descrip.font = [UIFont systemFontOfSize:9];
//        _descrip.textColor = [UIColor lightGrayColor];
//        _descrip.userInteractionEnabled = NO;
//        [self addSubview:_descrip];
//        
//        _oldprice = [[UILabel alloc]init];
//        _oldprice.font = [UIFont systemFontOfSize:10];
//        //        _oldprice.textAlignment = NSTextAlignmentRight;
//        _oldprice.textColor = [UIColor lightGrayColor];
//        [self addSubview:_oldprice];
        
        _nowprice = [[UILabel alloc]init];
        _nowprice.font = [UIFont systemFontOfSize:10];
        //        _nowprice.textAlignment = NSTextAlignmentRight;
        _nowprice.textColor = mainColor;
        [self addSubview:_nowprice];
        
        _oneprice = [[UILabel alloc]init];
        _oneprice.font = [UIFont systemFontOfSize:10];
        _oneprice.textColor = [UIColor grayColor];
        [self addSubview:_oneprice];
        
        
        
        line1 = [[UIView alloc]init];
        line1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self addSubview:line1];
        
        line2 = [[UIView alloc]init];
        line2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self addSubview:line2];
        
        //        line2 = [[UIView alloc]init];
        //        line2.backgroundColor = [UIColor whiteColor];
        //        [self addSubview:line2];
        
        _field = [[UITextField alloc]init];
        _removeBtn = [[UIButton alloc]init];
        _addBtn = [[UIButton alloc]init];
        
        [_removeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _removeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        
        _field.textAlignment = NSTextAlignmentCenter;
        _field.borderStyle = UITextBorderStyleRoundedRect;
        _field.leftViewMode = UITextFieldViewModeAlways;
        _field.rightViewMode =UITextFieldViewModeAlways;
        
        _field.leftView = _removeBtn;
        _field.rightView = _addBtn;
        
        _field.font = [UIFont systemFontOfSize:10];
        
        [self addSubview:_field];
        
        
        //添加点击事件
        
        [_removeBtn addTarget:self action:@selector(TapRemoveBtn) forControlEvents:UIControlEventTouchUpInside];
        [_addBtn addTarget:self action:@selector(TapAddBtn) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    
    _selectBtn.x = 10;
    _selectBtn.centerY = 50;
    _selectBtn.width = 20;
    _selectBtn.height = 20;
    
    _shopImg.frame = CGRectMake(40, 20, 80, 55);
    _title.frame = CGRectMake(CGRectGetMaxX(_shopImg.frame) + 10, 20,MainW - _shopImg.width - 35, 15);
    _oneprice.frame = CGRectMake(CGRectGetMaxX(_shopImg.frame) + 10, CGRectGetMaxY(_title.frame) , 100, 15);
    //    _nextImg.frame = CGRectMake(CGRectGetMaxX(_title.frame), 5, 20, 20);
//    _score.frame = CGRectMake(MainW - 40, self.height - 13 - 5, 40, 13);
    //    _comment_num.frame = CGRectMake(_title.x, 43, _shopImg.width, 15);
    
    line1.frame = CGRectMake(0, self.height-1, MainW, 0.5);
    
    line2.frame = CGRectMake(CGRectGetMaxX(_shopImg.frame) + 120, CGRectGetMaxY(_title.frame)+15, 0.5, 20);
    
    _noBtn.frame = CGRectMake(CGRectGetMaxX(_shopImg.frame) + 140, CGRectGetMaxY(_title.frame)+15, 50, 20);
    
//    _descrip.frame = CGRectMake(CGRectGetMaxX(_shopImg.frame) + 10, 25, MainW- 120, 40);
    //    line2.frame =CGRectMake(0, 79, MainW, 1);
    
//    _oldprice.frame = CGRectMake( CGRectGetMaxX(_shopImg.frame) + 60,65+2,  50, 13);
    _nowprice.frame = CGRectMake( 40,80,  200, 15);

    _field.frame = CGRectMake(CGRectGetMaxX(_shopImg.frame) + 10, CGRectGetMaxY(_oneprice.frame), 80, 24);
//    _removeBtn.x = 0;
//    _removeBtn.y = 0;
    _removeBtn.width = 24;
    _removeBtn.height = 24;
//    _addBtn.x = 0;
//    _addBtn.y = 0;
    _addBtn.width = 24;
    _addBtn.height = 24;
    
    [_removeBtn setTitle:@"-" forState:UIControlStateNormal];
    [_addBtn setTitle:@"+" forState:UIControlStateNormal];
    
    
}

- (void)setDealData:(DealInfoData *)dealData{
    _dealData = dealData;
    
    NSURL *shopImg = [NSURL URLWithString:dealData.image];
    [_shopImg sd_setImageWithURL:shopImg placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
    
    _title.text = dealData.min_title;
    
//    _score.text =[NSString stringWithFormat:@"%.1f" , dealData.score] ;
    
    //    NSString *comment_num = [NSString stringWithFormat:@"%@人评价" ,dealData.comment_num];
    //    _comment_num.text = comment_num;
    
//    _descrip.text = dealData.description;
    
//    int old =[dealData.market_price intValue]/100;
//    NSString *oldStr =[NSString stringWithFormat:@"%d",old];
//    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldStr attributes:attribtDic];
//    _oldprice.attributedText = attribtStr;
    
    int now =[dealData.current_price intValue]/100;
    NSString *oneStr = [NSString stringWithFormat:@"￥%d",now];
    _oneprice.text = oneStr;
    
   
    
    
}

- (void)setDBmodel:(DBdealModel *)DBmodel{

    _DBmodel = DBmodel;
    
    _field.text =[NSString stringWithFormat:@"%d" , DBmodel.count];
    
    int now =[self.dealData.current_price intValue]/100;
    NSString *nowStr =[NSString stringWithFormat:@"小记: ￥%d",now * DBmodel.count];
    _nowprice.text =nowStr;
    
    self.sumPirce = now * DBmodel.count;
    self.count = _DBmodel.count;
}



- (void)TapEdit:(id)sender{
    NSLog(@"%@" , sender);
    int x = [[sender object] intValue];
    if (x == 1) {
        _isSelect = ECOff;
        line2.hidden = YES;
        _noBtn.hidden = YES;
        _isA = NO;
    }else if(x == 2){
        _isSelect = ECOn;;
        line2.hidden = NO;
        _noBtn.hidden = NO;
        _isA = YES;
    }else if (x == 3){
        _isSelect = ECOff;;
    }else{
        _isSelect = ECOn;;
    }
    if (_isSelect == ECOn) {
        [_selectBtn setImage:[UIImage imageNamed:@"icon_check_01@2x"] forState:UIControlStateNormal];
        
    }else{
        [_selectBtn setImage:[UIImage imageNamed:@"icon_check_02@2x"] forState:UIControlStateNormal];
    }
    
    if (_isA) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"isCart" object:@"1"];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"isCart" object:@"2"];
    }
}

//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
#pragma mark --Action

- (void)TapRemoveBtn{
    NSLog(@"减一个");
}

- (void)TapAddBtn{
    NSLog(@"加一个");

}

- (void)TapNoBtn{
    [MBProgressHUD_Custom showError:@"目前没有优惠"];
}


- (void)TapSelectBtn{
    
    if (_isSelect == ECOn) {
        
        [_selectBtn setImage:[UIImage imageNamed:@"icon_check_02@2x"] forState:UIControlStateNormal];
        _isSelect = ECOff;
        
    }else{
        
        [_selectBtn setImage:[UIImage imageNamed:@"icon_check_01@2x"] forState:UIControlStateNormal];
        _isSelect = ECOn;
    }
    if (_isA) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"isCart" object:@"1"];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"isCart" object:@"2"];
    }
    
    
}

- (void)setIsSelect:(ECselect)isSelect{
    _isSelect = isSelect;
    if (_isSelect == ECOn) {
        [_selectBtn setImage:[UIImage imageNamed:@"icon_check_01@2x"] forState:UIControlStateNormal];
    }else{
        [_selectBtn setImage:[UIImage imageNamed:@"icon_check_02@2x"] forState:UIControlStateNormal];
    }

}

@end
