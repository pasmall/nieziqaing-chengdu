//
//  DealInfoContentCell.m
//  Shopping
//
//  Created by 聂自强 on 16/2/15.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "DealInfoContentCell.h"
#import "Common.h"


@implementation DealInfoContentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        
        self.userInteractionEnabled = NO;
//        self.backgroundColor = [UIColor redColor];
        
        _webView = [[UIWebView alloc]init];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.userInteractionEnabled = NO;
        [self addSubview:_webView];
        
        
        _title = [[UILabel alloc]init];
        _title.backgroundColor = [UIColor whiteColor];
        _title.textColor = [UIColor blackColor];
        _title.text = @"团购内容：";
        _title.font = [UIFont systemFontOfSize:16 weight:20];
        [self addSubview:_title];
        
        
        _headView  = [[UIView alloc]init];
        _headView.backgroundColor =  [UIColor colorWithRed:74.0/255 green:56.0/255 blue:58.0/255 alpha:0.1];
        [self addSubview:_headView];
        
    }
    
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    _headView.frame = CGRectMake(0, 0, MainW, 10);
    
    _title.frame = CGRectMake(10, 10, MainW - 10 , 30);
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    lineView.frame = CGRectMake(10, 39, MainW-10, 1);
    
//    _webView.frame = CGRectMake(20, 40 , MainW - 20 , _count *64);
    
    
}


- (void)setData:(NSString *)data{
//    _data = data;
    
    [_webView loadHTMLString:data baseURL:nil];

    NSString *subString = @"&nbsp";
    NSArray *array = [data componentsSeparatedByString:subString];
    _count = [array count] ;
    

    _webView.frame = CGRectMake(20, 40 , MainW -20 , _count *35);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
