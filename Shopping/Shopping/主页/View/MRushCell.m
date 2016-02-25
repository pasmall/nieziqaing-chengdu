//
//  MRushCell.m
//  Shopping
//
//  Created by 聂自强 on 15/12/17.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import "MRushCell.h"
#import "Common.h"
#import "UIImageView+WebCache.h"
#import "CountdownView.h"



@implementation MRushCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        
        CountdownView  *count = [[CountdownView alloc]initWithFrame:CGRectMake(0, 0, self.width * 0.5, 25)];
        count.x = self.width* 0.5-10 ;
        count.timestamp = 43200;
        [self addSubview:count];

        
//        UIView *lineView = [[UIView alloc]init];
//        lineView.backgroundColor = [UIColor lightGrayColor];
//        line = lineView;
//        [self addSubview:lineView];
        
        for (int i = 0; i < 3; ++i) {
            //背景view
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBackView:)];
            
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(i*MainW/3, 40, (MainW-3)/3, 80)];
            backView.tag = 100+i;
            [backView addGestureRecognizer:tap];
            [self addSubview:backView];
            //
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (MainW-3)/3, 50)];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.tag = i+20;
            [backView addSubview:imageView];
            //
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i*MainW/3-1, 45, 0.5, 85)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:lineView];
            
            //
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, backView.frame.size.width, 24)];
            title.textAlignment  = NSTextAlignmentCenter;
            title.textColor = [UIColor blackColor];
            title.font = [UIFont systemFontOfSize:10 weight:20];
            title.tag = 60+i;
            [backView addSubview:title];
            //
            UILabel *newPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 74, backView.frame.size.width/2, 30)];
            newPrice.tag = 50+i;
            newPrice.textColor = mainColor;
            newPrice.textAlignment = NSTextAlignmentRight;
            newPrice.font = [UIFont systemFontOfSize:12];
            [backView addSubview:newPrice];
            //
            UILabel *oldPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(backView.frame.size.width/2+5, 74, backView.frame.size.width/2-5, 30)];
            oldPriceLabel.tag = 70+i;
            oldPriceLabel.textColor = RGB(245, 185, 98);
            oldPriceLabel.font = [UIFont systemFontOfSize:10];
            [backView addSubview:oldPriceLabel];
            
            //名店抢购图
            UIImageView *mingdian = [[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 78, 25)];
            [mingdian setImage:[UIImage imageNamed:@"todaySpecialHeaderTitleImage"]];
            [self addSubview:mingdian];
            
        }
    }
    return self;
}
- (void)layoutSubviews{
    
//    line.frame = CGRectMake(0, self.height -1, self.width, 1);

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setRushData:(NSMutableArray *)rushData{
    for (int i = 0; i < 3; i++) {
        BaiDuDealData *rush = rushData[i];
        NSString *imageUrl = rush.tiny_image;
        NSInteger newPrice = [rush.market_price integerValue];
        NSInteger oldPrice = [rush.current_price integerValue];
        
        UIImageView *imageView = (UIImageView *)[self viewWithTag:20+i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
        
        UILabel *title = (UILabel *)[self viewWithTag:60+i];
        title.text = rush.title;
        
        UILabel *newPriceLabel = (UILabel *)[self viewWithTag:50+i];
        newPriceLabel.text = [NSString stringWithFormat:@"￥%ld",(long)oldPrice/100];
        //        newPriceLabel.text = [NSString stringWithFormat:@"%@元",rush.campaignprice];
        
        UILabel *oldPriceLabel = (UILabel *)[self viewWithTag:70+i];
        NSString *oldStr = [NSString stringWithFormat:@"%ld",(long)newPrice/100];
        //        NSString *oldStr = [NSString stringWithFormat:@"%@元",rush.price];
        
        //显示下划线
        //中划线
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldStr attributes:attribtDic];
        oldPriceLabel.attributedText = attribtStr;
        
    }
}

-(void)OnTapBackView:(UITapGestureRecognizer *)sender{
    NSLog(@"tag:%ld",sender.view.tag);
    [self.delegate didSelectRushIndex:sender.view.tag];
}


@end
