//
//  DealInfoHeadCell.m
//  Shopping
//
//  Created by 聂自强 on 16/1/13.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "DealInfoHeadCell.h"
#import "UIImageView+WebCache.h"
#import "Common.h"

@implementation DealInfoHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //背景图片
        _bgImage  = [[UIImageView alloc]init];
        _bgImage.backgroundColor = [UIColor whiteColor];
        _bgImage.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_bgImage];
        
        
        //已出售
        btn4 =[[UIButton alloc]init];
        btn4.enabled = NO;
        btn4.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        btn4.titleLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:btn4];
        
        //title
        lab1 = [[UILabel alloc]init];
        lab1.backgroundColor = [UIColor clearColor];
        lab1.textColor = [UIColor whiteColor];
        lab1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        lab1.font = [UIFont monospacedDigitSystemFontOfSize:13 weight:20];
        [self addSubview:lab1];
        
        //long title
        textView = [[UITextView alloc]init];
        textView.userInteractionEnabled = NO;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor whiteColor];
        textView.font = [UIFont systemFontOfSize:10];
        textView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self addSubview:textView];
        
        
        
    }
    
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    _bgImage.frame = CGRectMake(0, 0,MainW , 200);
    
    lab1.frame = CGRectMake(5, 130, MainW * 0.65, 30);
    
    btn4.frame = CGRectMake(MainW*0.65 +10-5, 130, MainW *0.35 - 10, 30);

    textView.frame = CGRectMake(5, 160, MainW - 10, 40);
    
    
}

- (void)setData:(DealInfoData *)data{
    _data = data;
    
    //设置图片
    NSURL *imgUrl = [NSURL URLWithString:_data.image];
    [_bgImage sd_setImageWithURL:imgUrl];
    
    //设置title
    lab1.text = data.title;
    
    textView.text = data.description;
    
    [btn4 setImage:[UIImage imageNamed:@"icon_tab_wode_normal_light"] forState:UIControlStateNormal];
    NSString *str = [NSString stringWithFormat:@"已出售 %d",data.sale_num];
    [btn4 setTitle:str forState:UIControlStateNormal];


}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
