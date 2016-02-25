//
//  YouLikeCell.m
//  Shopping
//
//  Created by 聂自强 on 16/2/17.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "YouLikeCell.h"
#import "Common.h"


@interface YouLikeCell(){

    UIImageView *_shopImg;
//    UIImageView *_nextImg;
    UILabel *_title;
    UILabel *_score;
//    UILabel *_comment_num;
    UITextView *_descrip;
    UILabel *_oldprice;
    UILabel *_nowprice;
    
    UIView *line1;
//    UIView *line2;

}

@end

@implementation YouLikeCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _shopImg = [[UIImageView alloc]init];
        [self addSubview:_shopImg];
        
//        _nextImg = [[UIImageView alloc]init];
//        [_nextImg setImage:[UIImage imageNamed:@"brower_next_0"]];
//        [self addSubview:_nextImg];
        
        _title = [[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:14 weight:8];
        _title.textColor = [UIColor blackColor];
        [self addSubview:_title];
        
        _score = [[UILabel alloc]init];
        _score.font = [UIFont systemFontOfSize:12];
        _score.textColor = RGB(250, 209, 9);
        [self addSubview:_score];
        
//        _comment_num = [[UILabel alloc]init];
//        _comment_num.font = [UIFont systemFontOfSize:10];
//        _comment_num.textColor = [UIColor lightGrayColor];
//        [self addSubview:_comment_num];
        
        _descrip = [[UITextView alloc]init];
        _descrip.font = [UIFont systemFontOfSize:9];
        _descrip.textColor = [UIColor lightGrayColor];
        _descrip.userInteractionEnabled = NO;
        [self addSubview:_descrip];
        
        _oldprice = [[UILabel alloc]init];
        _oldprice.font = [UIFont systemFontOfSize:10];
//        _oldprice.textAlignment = NSTextAlignmentRight;
        _oldprice.textColor = [UIColor lightGrayColor];
        [self addSubview:_oldprice];
        
        _nowprice = [[UILabel alloc]init];
        _nowprice.font = [UIFont systemFontOfSize:12];
//        _nowprice.textAlignment = NSTextAlignmentRight;
        _nowprice.textColor = mainColor;
        [self addSubview:_nowprice];
        
        line1 = [[UIView alloc]init];
        line1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self addSubview:line1];
        
//        line2 = [[UIView alloc]init];
//        line2.backgroundColor = [UIColor whiteColor];
//        [self addSubview:line2];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _shopImg.backgroundColor = [UIColor redColor];
    _shopImg.frame = CGRectMake(10, 5, 100, 80);
    _title.frame = CGRectMake(CGRectGetMaxX(_shopImg.frame) + 10, 5,MainW - _shopImg.width - 35, 20);
//    _nextImg.frame = CGRectMake(CGRectGetMaxX(_title.frame), 5, 20, 20);
    _score.frame = CGRectMake(MainW - 40, self.height - 13 - 5, 40, 13);
//    _comment_num.frame = CGRectMake(_title.x, 43, _shopImg.width, 15);
    
    line1.frame = CGRectMake(20, self.height-1, MainW- 35, 0.5);
    _descrip.frame = CGRectMake(CGRectGetMaxX(_shopImg.frame) + 10, 25, MainW- 120, 40);
//    line2.frame =CGRectMake(0, 79, MainW, 1);
    
    _oldprice.frame = CGRectMake( CGRectGetMaxX(_shopImg.frame) + 60,65+2,  50, 13);
    _nowprice.frame = CGRectMake( CGRectGetMaxX(_shopImg.frame) + 10,65,  50, 15);
    
    
}

- (void)setDealData:(BaiDuDealData *)dealData{
    _dealData = dealData;
    
    NSURL *shopImg = [NSURL URLWithString:dealData.tiny_image];
    [_shopImg sd_setImageWithURL:shopImg placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
    
    _title.text = dealData.title;
    
    _score.text =[NSString stringWithFormat:@"%.1f" , dealData.score] ;
    
//    NSString *comment_num = [NSString stringWithFormat:@"%@人评价" ,dealData.comment_num];
//    _comment_num.text = comment_num;
    
    _descrip.text = dealData.description;
    
    int old =[dealData.market_price intValue]/100;
    NSString *oldStr =[NSString stringWithFormat:@"%d",old];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldStr attributes:attribtDic];
    _oldprice.attributedText = attribtStr;
    
    int now =[dealData.current_price intValue]/100;
    NSString *nowStr =[NSString stringWithFormat:@"￥%d",now];
    _nowprice.text =nowStr;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
