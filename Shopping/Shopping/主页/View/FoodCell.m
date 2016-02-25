//
//  FoodCell.m
//  Shopping
//
//  Created by 聂自强 on 15/12/21.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import "FoodCell.h"
#import "Common.h"


@interface FoodCell (){
    
    UIImageView *_shopImg;
    UIImageView *_nextImg;
    UILabel *_title;
    UILabel *_score;
    UILabel *_comment_num;
    UILabel *_descrip;
    UILabel *_oldprice;
    UILabel *_nowprice;
    
    UIView *line1;
    UIView *line2;

}

@end


@implementation FoodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _shopImg = [[UIImageView alloc]init];
        [self addSubview:_shopImg];
        
        _nextImg = [[UIImageView alloc]init];
        [_nextImg setImage:[UIImage imageNamed:@"brower_next_0"]];
        [self addSubview:_nextImg];
        
        _title = [[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:14 weight:15];
        _title.textColor = [UIColor blackColor];
        [self addSubview:_title];
        
        _score = [[UILabel alloc]init];
        _score.font = [UIFont systemFontOfSize:8];
        _score.textColor = RGB(250, 209, 9);
        [self addSubview:_score];
        
        _comment_num = [[UILabel alloc]init];
        _comment_num.font = [UIFont systemFontOfSize:10];
        _comment_num.textColor = [UIColor lightGrayColor];
        [self addSubview:_comment_num];
        
        _descrip = [[UILabel alloc]init];
        _descrip.font = [UIFont systemFontOfSize:10];
        _descrip.textColor = [UIColor lightGrayColor];
        [self addSubview:_descrip];
        
        _oldprice = [[UILabel alloc]init];
        _oldprice.font = [UIFont systemFontOfSize:10];
        _oldprice.textAlignment = NSTextAlignmentRight;
        _oldprice.textColor = [UIColor lightGrayColor];
        [self addSubview:_oldprice];
        
        _nowprice = [[UILabel alloc]init];
        _nowprice.font = [UIFont systemFontOfSize:14];
        _nowprice.textAlignment = NSTextAlignmentRight;
        _nowprice.textColor = mainColor;
        [self addSubview:_nowprice];
        
        line1 = [[UIView alloc]init];
        line1.backgroundColor = [UIColor whiteColor];
        [self addSubview:line1];
        
        line2 = [[UIView alloc]init];
        line2.backgroundColor = [UIColor whiteColor];
        [self addSubview:line2];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _shopImg.frame = CGRectMake(5, 0, 100, 58);
    _title.frame = CGRectMake(CGRectGetMaxX(_shopImg.frame) + 10, 5,MainW - _shopImg.width - 35, 20);
    _nextImg.frame = CGRectMake(CGRectGetMaxX(_title.frame), 5, 20, 20);
    _score.frame = CGRectMake(_title.x, 30, _shopImg.width, 13);
    _comment_num.frame = CGRectMake(_title.x, 43, _shopImg.width, 15);
    
    line1.frame = CGRectMake(0, 59, MainW, 1);
    _descrip.frame = CGRectMake(5, 60, MainW- 30, 19);
    line2.frame =CGRectMake(0, 79, MainW, 1);
    
    _oldprice.frame = CGRectMake( CGRectGetMaxX(_score.frame),30,  MainW - CGRectGetMaxX(_score.frame), 13);
    _nowprice.frame = CGRectMake( CGRectGetMaxX(_score.frame),43,  MainW - CGRectGetMaxX(_score.frame), 15);


}

- (void)setDealData:(BaiDuDealData *)dealData{
    _dealData = dealData;
    
    NSURL *shopImg = [NSURL URLWithString:dealData.tiny_image];
    [_shopImg sd_setImageWithURL:shopImg placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
    
    _title.text = dealData.title;
    
    _score.text =[NSString stringWithFormat:@"用户评分：%.1f" , dealData.score] ;
    
    NSString *comment_num = [NSString stringWithFormat:@"%@人评价" ,dealData.comment_num];
    _comment_num.text = comment_num;
    
    _descrip.text = dealData.description;
    
    int old =[dealData.market_price intValue]/100;
    NSString *oldStr =[NSString stringWithFormat:@"原价%d元",old];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldStr attributes:attribtDic];
    _oldprice.attributedText = attribtStr;
    
    int now =[dealData.current_price intValue]/100;
    NSString *nowStr =[NSString stringWithFormat:@"折扣价%d元",now];
    _nowprice.text =nowStr;
    

}

@end
