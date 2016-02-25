//
//  MBtnView.m
//  Shopping
//
//  Created by 聂自强 on 15/12/11.
//  Copyright © 2015年 nieziqiang. All rights reserved.
//

#import "MBtnView.h"
#import "Common.h"


@implementation MBtnView

- (id)initBtnViewWithFrame:(CGRect)frame andTitle:(NSString *)title imageName:(NSString *)imgName{
    self = [super initWithFrame:frame];
    
    if (self) {
        //
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 44, 44)];
        imageView.centerX = self.width * 0.5;
        imageView.image = [UIImage imageNamed:imgName];
        [self addSubview:imageView];
        
        //
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 15+44, frame.size.width, 20)];
        titleLable.text = title;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.textColor = [UIColor lightGrayColor];
        titleLable.font = [UIFont systemFontOfSize:13];
        [self addSubview:titleLable];
    }
    return self;
}

@end
