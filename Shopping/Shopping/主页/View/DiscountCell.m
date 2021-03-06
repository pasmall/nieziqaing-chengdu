//
//  DiscountCell.m
//  meituan
//
//  Created by jinzelu on 15/7/2.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "DiscountCell.h"
#import "DiscountModel.h"
#import "Common.h"


@interface DiscountCell ()
{
    NSMutableArray *_array;
}

@end

@implementation DiscountCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _array = [[NSMutableArray alloc] init];
//        self.backgroundColor = [UIColor redColor];
        
        UIView *headView  = [[UIView alloc]init];
        headView.backgroundColor =  [UIColor colorWithRed:74.0/255 green:56.0/255 blue:58.0/255 alpha:0.1];
        headView.frame = CGRectMake(0, 0, MainW, 10);
        [self addSubview:headView];
        
        for (int i = 0; i < _discountArray.count; i++) {
            //背景
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(i*MainW/2, 10, MainW/2, 80)];
            if (i<2) {
                backView.frame = CGRectMake(i*MainW/2, 10, MainW/2, 80);
            }else{
                backView.frame = CGRectMake((i-2)*MainW/2, 90, MainW/2, 80);
            }
            backView.tag = 100+i;
            backView.layer.borderWidth = 0.25;
            backView.layer.borderColor = [RGB(200, 199, 204) CGColor];
            [self addSubview:backView];
            //点击事件
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBackView:)];
            [backView addGestureRecognizer:tap];
            
            //标题
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, MainW/2-10-60, 30)];
            titleLabel.text = @"暑期看大片";
            titleLabel.tag = 200+i;
            titleLabel.font = [UIFont boldSystemFontOfSize:15];
            [backView addSubview:titleLabel];
            
            //子标题
            UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, MainW/2-10-60, 30)];
            subTitleLabel.tag = 220+i;
            subTitleLabel.font = [UIFont systemFontOfSize:12];
            subTitleLabel.text = @"上门服务限时抢";
            [backView addSubview:subTitleLabel];
            
            //图
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MainW/2-10-60, 20, 60, 60)];
            imageView.tag = 240+i;
            [imageView setImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 30;
            [backView addSubview:imageView];
            
        }
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDiscountArray:(NSMutableArray *)discountArray{
    _discountArray = discountArray;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < discountArray.count; i++) {
        DiscountModel *discount = discountArray[i];
        NSNumber *num = [[NSNumber alloc] initWithLong:1];
        if ([discount.type isEqualToValue: num]) {
            [array addObject:discount];
        }
    }
    _array = discountArray;
    
    for (int j = 0; j < _discountArray.count; ++j) {
        UILabel *titleLabel = (UILabel *)[self viewWithTag:j+200];
        UILabel *subtitleLabel = (UILabel *)[self viewWithTag:j+220];
        UIImageView *imageView = (UIImageView *)[self viewWithTag:j+240];
        DiscountModel *discount = _array[j];
        
        titleLabel.text = discount.maintitle;
        titleLabel.textColor = [self stringTOColor:discount.typeface_color];
        subtitleLabel.text = discount.deputytitle;
        
        NSString *imgUrl = [discount.imageurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"120.0"];
        
        NSURL *url =[NSURL URLWithString:imgUrl];
        
        UIImage *image = [UIImage imageNamed:@"ugc_photo"];
        [imageView sd_setImageWithURL:url placeholderImage:image];
        
//        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
    }
    
    
}

- (UIColor *) stringTOColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

-(void)OnTapBackView:(UITapGestureRecognizer *)sender{
    NSInteger index = sender.view.tag-100;
    DiscountModel *discount = _array[index];
    
    
    NSString *str = @"╭(╯^╰)╮";
    NSNumber *num = [[NSNumber alloc] initWithLong:1];
    if ([discount.type isEqualToValue: num]) {
        str = discount.tplurl;
        NSRange rang = [str rangeOfString:@"http"];
        str = [str substringFromIndex:rang.location];
        NSLog(@"%@",str);
    }
    
//    [self.delegate didSelectUrl:str withType:discount.type withId:discount.id];
    [self.delegate didSelectUrl:str withType:discount.type withId:discount.id withTitle:discount.maintitle];
    
}

@end
