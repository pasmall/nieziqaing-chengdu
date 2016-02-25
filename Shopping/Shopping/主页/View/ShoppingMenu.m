//
//  ShoppingMenu.m
//  Shopping
//
//  Created by 聂自强 on 16/2/16.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "ShoppingMenu.h"
#import "Common.h"

@implementation ShoppingMenu

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _cartBtn  = [[UIButton alloc]init];
        _cartBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
        [self addSubview:_cartBtn];
        
        _addCartBtn  = [[UIButton alloc]init];
        _addCartBtn.backgroundColor = [UIColor colorWithRed:252/255.0 green:209/255.0 blue:9/255.0 alpha:1];
        [self addSubview:_addCartBtn];
        
        _payBtn  = [[UIButton alloc]init];
        _payBtn.backgroundColor = mainColor;
        [self addSubview:_payBtn];
        
    }
    return self;
}

@end
