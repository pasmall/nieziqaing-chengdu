//
//  DealInfoTitleCell.m
//  Shopping
//
//  Created by 聂自强 on 16/2/15.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "DealInfoTitleCell.h"
#import "Common.h"

@interface DealInfoTitleCell(){
    UIView *line ;
}

@property(nonatomic , strong) UILabel *price;
@property(nonatomic , strong) UILabel *deal;
@property(nonatomic , strong) UILabel *oldPrice;
@property(nonatomic , strong) UILabel *timeLabel;

@end

@implementation DealInfoTitleCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.userInteractionEnabled = NO;
        /**
         价格
         */
        _price = [[UILabel alloc]init];
        _price.textColor = mainColor;
        _price.font = [UIFont systemFontOfSize:25 weight:20];
        _price.backgroundColor = [UIColor whiteColor];
        [self addSubview:_price];
        
        /**
         团购价
         */
        _deal = [[UILabel alloc]init];
        _deal.backgroundColor = [UIColor whiteColor];
         _oldPrice.font = [UIFont systemFontOfSize:10 ];
        [self addSubview:_deal];
        
        /**
         团购的价格
         */
        _oldPrice = [[UILabel alloc]init];
        _oldPrice.backgroundColor = [UIColor whiteColor];
         _oldPrice.font = [UIFont systemFontOfSize:12 ];
        [self addSubview:_oldPrice];
        
        /**
         团购开始时间和结束时间
         */
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.backgroundColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:10 ];
        _timeLabel.textColor = [UIColor grayColor];
        [self addSubview:_timeLabel];
        
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
        line = lineView;
    }
    
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    _price.frame = CGRectMake(10, 0,100 , 60);
    
    _deal.frame = CGRectMake(110, 30 , 80 , 30);
    
    _oldPrice.frame = CGRectMake(190, 30, 100, 30);
    
    line.frame = CGRectMake(10, 60, MainW - 10, 1);
    
    _timeLabel.frame = CGRectMake(10, 61, MainW, 30);
    
    
}


- (void)setData:(DealInfoData *)data{
    _data = data;
    
    
    int old =[data.market_price intValue]/100;
    NSString *oldStr =[NSString stringWithFormat:@"原价%d",old];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldStr attributes:attribtDic];
    _oldPrice.attributedText = attribtStr;
    
    int now =[data.current_price intValue]/100;
    NSString *nowStr =[NSString stringWithFormat:@"￥%d",now];
    _price.text =nowStr;
    
    _deal.text = @"团购价";
    
    
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"yyyyMMdd"];
//    NSDate *date = [formatter dateFromString:@"1414771200"];
//    NSLog(@"date1:%@",date);
    
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSDate *start = [NSDate dateWithTimeIntervalSince1970:data.coupon_start_time];
    NSDate *end = [NSDate dateWithTimeIntervalSince1970:data.coupon_end_time];
    
    NSString *startStr = [formatter stringFromDate:start];
    NSString *endStr = [formatter stringFromDate:end];
    
    NSString *str = [NSString stringWithFormat:@"开始时间：%@  ---  结束时间：%@" ,startStr , endStr];
    _timeLabel.text = str;
    
    
//    NSLog(@"%@",data.buy_contents);
//    
//    UIWebView *webView = [[UIWebView alloc]init];
//    webView.frame = CGRectMake(0, 90, MainW, MainH);
//    [webView loadHTMLString:data.buy_contents baseURL:nil];
//    [self addSubview:webView];
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
