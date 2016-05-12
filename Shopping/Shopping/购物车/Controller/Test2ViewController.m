//
//  Test2ViewController.m
//  Shopping
//
//  Created by 聂自强 on 16/5/11.
//  Copyright © 2016年 nieziqiang. All rights reserved.
//

#import "Test2ViewController.h"
#import "Common.h"

@implementation Test2ViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *img  = [UIImage imageNamed:@"mess2"];
    CGFloat h = CGImageGetHeight(img.CGImage)/CGImageGetWidth(img.CGImage) *MainW;
    
    UIImageView *imgView = [[UIImageView alloc ]initWithFrame:CGRectMake(0, 64, MainW, h)];
    [imgView setImage:img];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    UIScrollView *scro = [[UIScrollView alloc ]initWithFrame:CGRectMake(0, 0, MainW, MainH -44)];
    scro.contentSize = CGSizeMake(MainW,MainH);
    scro.showsVerticalScrollIndicator = NO;
    scro.bounces = YES;
    [scro addSubview:imgView];
    
    [self.view addSubview:scro];
}

@end
