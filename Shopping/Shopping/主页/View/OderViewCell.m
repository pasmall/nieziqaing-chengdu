//
//  OderViewCell.m
//  Shopping
//
//  Created by 聂自强 on 16/3/4.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "OderViewCell.h"
#import "Common.h"

@interface OderViewCell (){
    
    UILabel *_title;
    UILabel *_price;
    
    UILabel *_st;
    
    UILabel *_psd;
    
    UIImageView *_imgv1;
    UIImageView *_imgv2;
    
    UIImageView *_imgv3;

}

@end

@implementation OderViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= RGB(224, 224, 224);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *vw = [[UIView alloc]initWithFrame:CGRectMake(10, 5,MainW - 20 , 170)];
        vw.backgroundColor = RGB(252, 248, 248);
        vw.layer.cornerRadius = 10;
        vw.layer.masksToBounds = YES;
        [self addSubview:vw];
        
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, vw.width - 20, 20)];
        _title.textColor =[UIColor blackColor];
        _title.font = [UIFont systemFontOfSize:12 weight:8];
        [vw addSubview:_title];
        
        _price = [[UILabel alloc]initWithFrame:CGRectMake(vw.width/2 + 20, 10, vw.width/4, 20)];
        _price.textAlignment = NSTextAlignmentRight;
        _price.font = [UIFont systemFontOfSize:15 weight:10];
        _price.textColor =mainColor;
        [vw addSubview:_price];
        
        _st = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, vw.width - 20, 20)];
        _st.font = [UIFont systemFontOfSize:8];
        _st.textColor = [UIColor blackColor];
        [vw addSubview:_st];
        
        
        _psd = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, vw.width -20, 20)];
        _psd.font = [UIFont systemFontOfSize:14 ];
        
        [vw addSubview:_psd];
        
        _imgv1 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, vw.width - 10, vw.height - 10)];
        _imgv1.alpha = 0.4;
        _imgv1.layer.cornerRadius = 5;
        
        _imgv1.layer.masksToBounds =YES;
        _imgv1.contentMode = UIViewContentModeScaleAspectFill;
        [vw addSubview:_imgv1];
        
        _imgv2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        _imgv2.x =  20;
        _imgv2.centerY = 115;
        [_imgv2 setImage:[UIImage imageNamed:@"easymaster.jpeg"]];
        _imgv2.contentMode = UIViewContentModeScaleAspectFill;
        [vw addSubview:_imgv2];
        
        
        _imgv3 = [[UIImageView alloc]initWithFrame:CGRectMake(vw.width - 34, 0, 24, 50)];
        [_imgv3 setImage:[UIImage imageNamed:@"wastUser.jpeg"]];
        _imgv3.contentMode = UIViewContentModeScaleAspectFill;
        [vw  addSubview:_imgv3];
        
        
        
        
    }
    return self;
}

- (void)setOder:(DBOderMdoel *)oder{
    _oder = oder;
    
   
    NSString *dateStr = [NSString stringWithFormat:@"有效期:  %@ --%@" , oder.st, oder.et];
    _st.text = dateStr;
    
    NSString *pStr = [NSString stringWithFormat:@"订单验证码: %@" , oder.dealId];
    _psd.text = pStr;
    
    
}

- (void)setDeal:(DealInfoData *)deal{
    _deal = deal;
    
    NSURL *shopImg = [NSURL URLWithString:deal.image];
    [_imgv1 sd_setImageWithURL:shopImg placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
    
    
    int now =[deal.current_price intValue]/100;
    NSString *Str = [NSString stringWithFormat:@"%@  ×%d ",deal.min_title,_oder.count];
    
    _title.text = Str;
    
     NSString *oneStr = [NSString stringWithFormat:@"￥%d",now * _oder.count];
    _price.text = oneStr;

}


@end
